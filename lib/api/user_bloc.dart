import 'dart:async';

import 'package:suitmedia_flutter_app/api/user.dart';
import 'package:suitmedia_flutter_app/api/user_repository.dart';

class UserBloc {
  final UserRepository userRepository;

  UserBloc(this.userRepository);

  final _userListController = StreamController<List<User>>.broadcast();
  Stream<List<User>> get userListStream => _userListController.stream;

  int _currentPage = 1;
  int _perPage = 10;
  List<User> _userList = [];
  bool _isLoading = false;

  Future<void> getUsers() async {
    if (_isLoading) return;

    _isLoading = true;

    try {
      final users = await userRepository.getUsers(_currentPage, _perPage);
      _userList.addAll(users);
      _currentPage++;
      _isLoading = false;

      _userListController.sink.add(_userList);
    } catch (error) {
      _isLoading = false;
      // Handle error
    }
  }

  void refreshUsers() {
    _userList.clear();
    _currentPage = 1;
    getUsers();
  }

  void dispose() {
    _userListController.close();
  }
}