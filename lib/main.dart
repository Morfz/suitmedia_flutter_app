import 'package:flutter/material.dart';

import 'pages/first_page.dart';
import 'pages/second_page.dart';
import 'pages/third_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suitmedia Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FirstPage(),
        '/second_page': (context) => SecondPage(name: ModalRoute.of(context)!.settings.arguments as String),
        '/third_page': (context) => ThirdPage(),
      },
    );
  }
}