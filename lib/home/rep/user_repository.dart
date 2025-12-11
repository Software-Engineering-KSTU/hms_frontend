import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dto/user_dto.dart';

class UserRepository {
  final String baseUrl = 'http://localhost:8080/api/users';

  Future<UserDto> getUser(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$id'),
    );

    if (response.statusCode == 200) {
      return UserDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Ошибка загрузки пользователя');
    }
  }
}
