import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../api/user.dart';
import '../../api/user_bloc.dart';
import '../../api/user_repository.dart';

class ThirdPage extends StatefulWidget {
  final Function(String)? onUserNameSelected;

  ThirdPage({this.onUserNameSelected});

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  late UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _userBloc = UserBloc(UserRepository());
    _userBloc.getUsers();
  }

  @override
  void dispose() {
    _userBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Third Screen'),
        backgroundColor: Colors.white,
      ),
      child: StreamBuilder<List<User>>(
        stream: _userBloc.userListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userList = snapshot.data!;
            return Material(
              child: RefreshIndicator(
                onRefresh: () async {
                  _userBloc.refreshUsers();
                },
                child: ListView.builder(
                  itemCount: userList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == userList.length) {
                      return _buildLoaderIndicator();
                    }
                    final user = userList[index];
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.avatar),
                            radius: 30.0,
                          ),
                          title: Text(
                              user.name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                              user.email,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          onTap: () {
                            if (widget.onUserNameSelected != null) {
                              widget.onUserNameSelected!(user.name);
                            }
                            Navigator.pop(context);
                          },
                        ),
                        const Divider(indent: 20.0),
                      ],
                    );
                  },
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildLoaderIndicator() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}