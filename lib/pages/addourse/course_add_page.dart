import 'package:absenteeism_v2/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CourseAdd extends StatefulWidget {
  const CourseAdd({Key? key}) : super(key: key);

  @override
  State<CourseAdd> createState() => _CourseAddState();
}

class _CourseAddState extends State<CourseAdd> {
  final Box _firstTimeOpen = Hive.box("getStarted");
  @override
  Widget build(BuildContext context) {
    if (_firstTimeOpen.get("getStarted")??false) {
      return Login();
    }
    return Scaff.scaffold(context,_firstTimeOpen);
  }
}

class Scaff {
  static scaffold(BuildContext context,Box _firstTimeOpen) => Scaffold(
    backgroundColor: Color.fromRGBO(140, 82, 255, 1.0),
    body: Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          height: 450,
          child: Container(
            height: 450,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Aktif Derslerini Ekle',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width-25,
                child: Text(
                  'Senin için programın ve sınav takvimin oluşsun.',
                  style: TextStyle(
                    color: Colors.white60,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: 180,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.deepPurple,
                ),
                child: ElevatedButton(
                  onPressed: () => {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Login();
                        },
                      ),
                    ),
                    _firstTimeOpen.put("getStarted", true),
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              SizedBox(height: 100,)
            ],
          ),
        ),
      ],
    ),
  );
}
