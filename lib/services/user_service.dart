import 'package:cloud_izmir/models/user.dart';
import 'package:dio/dio.dart';

class UserService {
  final client = Dio();

  Future<List<User>> getUsers() async {
    try {
      final response =
          await client.get("https://jsonplaceholder.typicode.com/users");

      final users = (response.data as List).map((item) {
        return User.fromJson(item);
      }).toList();
      return users;
    } on Exception {
      rethrow;
    }
  }
}
