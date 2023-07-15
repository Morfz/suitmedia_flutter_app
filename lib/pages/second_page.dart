import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suitmedia_flutter_app/pages/third_page.dart';

class SecondPage extends StatefulWidget {
  final String name;

  const SecondPage({required this.name});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String selectedUserName = 'Selected User Name';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Second Screen'),
        backgroundColor: Colors.white,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DefaultTextStyle(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                ),
                child: Text('Welcome'),
              ),
              const SizedBox(height: 8.0),
              Text(
                widget.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none, // Add this line
                ),
              ),
              const SizedBox(height: 32.0),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    child: Text(
                      selectedUserName,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(43, 99, 123, 1),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ThirdPage(
                          onUserNameSelected: (userName) {
                            setState(() {
                              selectedUserName = userName;
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Choose a User',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}