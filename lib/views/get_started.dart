import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'menu/menu.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  final Box _firstTimeOpen = Hive.box("getStarted");

  bool checkFirstTimeOpen(){
    if(_firstTimeOpen.get("isOpen") == true)
      return true;
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return checkFirstTimeOpen()?Menu():Scfull();
  }
  Widget Scfull(){
    return Scaffold(
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
                      _firstTimeOpen.put("isOpen", true),
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const Menu();
                          },
                        ),
                      ),
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
}