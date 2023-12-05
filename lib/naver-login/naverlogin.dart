import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:http/http.dart' as http;
final GlobalKey<ScaffoldMessengerState> snackbarKey =
GlobalKey<ScaffoldMessengerState>();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Naver Login',
      scaffoldMessengerKey: snackbarKey,
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: const Color(0xFF00c73c),
        canvasColor: const Color(0xFFfafafa),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(
              fontSize: 12.0,
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontFamily: "Roboto",
            ),
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLogin = false;
  String? accesToken;
  String? expiresAt;
  String? tokenType;
  String? name;
  String? refreshToken;

  /// Show [error] content in a ScaffoldMessenger snackbar
  void _showSnackError(String error) {
    snackbarKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(error.toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Naver Login Sample',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        children: [
          Column(
            children: [
              Text('isLogin: $isLogin\n'),
              Text('accesToken: $accesToken\n'),
              Text('refreshToken: $refreshToken\n'),
              Text('tokenType: $tokenType\n'),
              Text('user: $name\n'),
            ],
          ),
          ElevatedButton(
            onPressed: buttonLoginPressed,
            child: const Text("LogIn"),
          ),
        ],
      ),
    );
  }

  Future<void> buttonLoginPressed() async {

  }



}