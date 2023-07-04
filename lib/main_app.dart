import 'package:absenteeism_v2/views/get_started.dart';
import 'package:absenteeism_v2/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


class MainApp extends StatelessWidget {
  MainApp({super.key});

  final Box _boxLogin = Hive.box("login");
  bool checkLogin(){
    var token = _boxLogin.get("loginStatus");
    if(token.toString() == null)
      return false;
    if(token.toString() == "")
      return false;
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(32, 63, 129, 1.0),
        ),
      ),
      home: checkLogin()?GetStarted():LoginPage(),
    );
  }
}