import 'package:absenteeism_v2/views/login_page.dart';
import 'package:absenteeism_v2/views/menu/menu.dart';
import 'package:absenteeism_v2/views/menu/syllabus/syllabus_view.dart';
import 'package:flutter/material.dart';


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(32, 63, 129, 1.0),
        ),
      ),
      home: const Menu(),
    );
  }
}