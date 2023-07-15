import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:suitmedia_flutter_app/api/user.dart';

class UserRepository {
  late final http.Client _client;
  final String _baseUrl = 'https://reqres.in/api';

  UserRepository({http.Client? client}) {
    _client = client ?? http.Client();
  }

  Future<List<User>> getUsers(int page, int perPage) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/users?page=$page&per_page=$perPage'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final usersData = jsonData['data'];

      List<User> fetchedUsers = [];
      for (var user in usersData) {
        fetchedUsers.add(User.fromJson(user));
      }

      return fetchedUsers;
    } else {
      throw Exception('Failed to fetch users');
    }
  }
}