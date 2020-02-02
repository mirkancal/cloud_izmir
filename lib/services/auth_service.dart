import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

class AuthService {
  final client = Dio()
    ..options.baseUrl = "http://us-central1-mht123321.cloudfunctions.net";
  Future<String> signUp({
    @required String email,
    @required String password,
  }) async {
    try {
      final response = await client.get(
        "/signup",
        queryParameters: {
          "mail": email,
          "pass": password,
        },
      );
      String data = response.data;

      final lastIndex = data.lastIndexOf("/");
      final userId = data.substring(lastIndex + 1);

      print(userId);
      return userId;
    } on Exception {
      rethrow;
    }
  }

  Future verifyEmail({
    @required String userId,
    @required String code,
  }) async {
    try {
      final response = await client.get(
        "/verify",
        queryParameters: {
          "id": userId,
          "code": code,
        },
      );
    } on Exception {
      rethrow;
    }
  }

  Future<String> login({
    @required String email,
    @required String password,
  }) async {
    try {
      final response = await client.get(
        "/login",
        queryParameters: {
          "mail": email,
          "pass": password,
        },
      );
      print(response.data);
      return "Success";
    } on Exception {
      rethrow;
    }
  }
}
