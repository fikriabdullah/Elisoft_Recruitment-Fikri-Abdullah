import 'package:elisoft/pages/dashboard.dart';
import 'package:elisoft/pages/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login' : (context) =>  Login(),
        '/dashboard' : (context) =>  Dashboard()
      },
    );
  }
}
