import 'package:dio/dio.dart';

class AuthService {
  final client = Dio()
    ..options.baseUrl = "https://us-central1-subat-de0ea.cloudfunctions.net";

  signUp() {}

  verifyUser() {}

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
