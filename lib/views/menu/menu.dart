import 'package:absenteeism_v2/views/menu/mainpage/main_page.dart';
import 'package:absenteeism_v2/views/menu/syllabus/syllabus_view.dart';
import 'package:flutter/material.dart';

import 'addcourse/addcalendar_page.dart';
import 'addcourse/addcourse_page.dart';
import 'addpage/add_all_page.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  List<Widget> widgetList = [
    TodayPage(),
    SyllabusView(),
    Placeholder(),
    AddAllPage(),
    AddCourseCalendarPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: BottomList.list,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.deepPurpleAccent,
        selectedIconTheme: const IconThemeData(size: 35.0),
        selectedLabelStyle: const TextStyle(fontSize: 16.0),
        unselectedItemColor: Colors.black54,
        iconSize: 30,
        selectedFontSize: 12.0,
        showUnselectedLabels: false,
      ),
      body: widgetList[_selectedIndex],
    );
  }
}

class BottomList {
  static const List<BottomNavigationBarItem> list = [
    BottomNavigationBarItem(
      activeIcon: Icon(Icons.home),
      icon: Icon(Icons.home_outlined),
      label: 'Ana Sayfa',
    ),
    BottomNavigationBarItem(
      activeIcon: Icon(Icons.calendar_month),
      icon: Icon(Icons.calendar_month_outlined),
      label: 'Program',
    ),
    BottomNavigationBarItem(
      activeIcon: Icon(Icons.school),
      icon: Icon(Icons.school_outlined),
      label: 'Sınav Takvimi',
    ),
    BottomNavigationBarItem(
      activeIcon: Icon(Icons.add_box),
      icon: Icon(Icons.add_box_outlined),
      label: 'Ders ekle',
    ),
    BottomNavigationBarItem(
      activeIcon: Icon(Icons.person_2),
      icon: Icon(Icons.person_2_outlined),
      label: 'Profil',
    ),
  ];
}
