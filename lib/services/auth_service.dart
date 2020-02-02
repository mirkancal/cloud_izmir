import 'package:dio/dio.dart';

class AuthService {
  final client = Dio()
    ..options.baseUrl = "https://us-central1-subat-de0ea.cloudfunctions.net";

  Future<String> signUp(String email, String password) async {
    try {
      final response = await client.get(
        "/signup",
        queryParameters: {
          "mail": email,
          "pass": password,
        },
      );
      final String data = response.data;
      final lastIndex = data.lastIndexOf("/");
      final userId = data.substring(lastIndex + 1);
      print(userId);
      return userId;
    } on Exception {
      rethrow;
    }
  }

  verifyUser(String userId, String code) async {
    try {
      final response = await client.get("/verify", queryParameters: {
        "id": userId,
        "code": code,
      });
    } on Exception {
      rethrow;
    }
  }

  login(String email, String password) async {
    try {
      final response = await client.get(
        "/login",
        queryParameters: {
          "mail": email,
          "pass": password,
        },
      );
    } on Exception {
      rethrow;
    }
  }
}
