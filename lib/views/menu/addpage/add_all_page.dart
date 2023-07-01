import 'package:absenteeism_v2/views/menu/addcourse/addcourse_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../addcourse/addcalendar_page.dart';


class AddAllPage extends StatefulWidget {
  const AddAllPage({Key? key}) : super(key: key);

  @override
  State<AddAllPage> createState() => _AddAllPageState();
}

class _AddAllPageState extends State<AddAllPage> {
  List<Widget> pages = [
    AddCourse(),
    AddCourseCalendarPage()
  ];
  int _selectedIndex = 0;
  var iconData = Icons.add;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void _onOpenorClose(IconData icon){
    setState(() {
      iconData = icon;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      floatingActionButton:SpeedDial(
        animatedIcon:AnimatedIcons.add_event,
        backgroundColor: Colors.deepPurple,
        children: [
          SpeedDialChild(
            child: Icon(Icons.book_online),
            backgroundColor: Colors.purple[50],
            label: 'Ders Ekle',
            onTap: () => _onItemTapped(0),
          ),
          SpeedDialChild(
            child: Icon(Icons.view_week_outlined),
            backgroundColor: Colors.purple[100],
            label: 'Ders Günlerini Ekle',
            onTap: ()=>  _onItemTapped(1),
          ),
        ],
      ),
    );
  }
}