import 'package:flutter/material.dart';
import 'package:yine/screens/init_profile.dart';
import 'package:yine/screens/login.dart';
import 'package:yine/screens/main_nav.dart';
import 'package:yine/screens/register.dart';
import 'package:yine/screens/startup.dart';
import 'package:yine/screens/welcome.dart';

dynamic database;

void main() {
  runApp(const Yine());
}

class Yine extends StatelessWidget {
  const Yine({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yine',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: MainNav.id,
      routes: {
        StartUp.id: (context) => StartUp(),
        Welcome.id: (context) => Welcome(),
        Login.id: (context) => Login(),
        Register.id: (context) => Register(),
        InitProfile.id: (context) => InitProfile(),
        MainNav.id: (context) => MainNav(),
      },
    );
  }
}