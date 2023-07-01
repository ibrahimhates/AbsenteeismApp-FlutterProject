import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../models/calendar/CourseCalendar.dart';
import '../../../models/course/TodayCourses.dart';
import '../../../models/coursedetail/CourseDetail.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({Key? key}) : super(key: key);

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  TodayCourses todayCourses = TodayCourses(
    courseName: "Matematik",
    id: 1,
    courseDetail: CourseDetail(
      absenceLimit: 10,
      currentAbsence: 5,
      description: "Matematik dersi için program ve devamsızlık durumu",
      examTime: DateTime(2023, 7, 1, 9, 0), // Örnek bir tarih ve saat
    ),
    courseCalendars: [
      CourseCalendar(
        courseId: 1,
        dayId: 1,
        startTime: "09:00",
        endTime: "10:30",
      ),
      CourseCalendar(
        courseId: 1,
        dayId: 2,
        startTime: "11:00",
        endTime: "12:30",
      ),
      CourseCalendar(
        courseId: 1,
        dayId: 3,
        startTime: "14:00",
        endTime: "15:30",
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return TodayCoursesPage(
      courseName: 'Matematik',
      absenceLimit: 10,
      currentAbsence: 6,
      startTime: '09:00',
      endTime: '10:30',
    );
  }
}

class TodayCoursesPage extends StatelessWidget {
  final String courseName;
  final int absenceLimit;
  final int currentAbsence;
  final String startTime;
  final String endTime;

  TodayCoursesPage({
    required this.courseName,
    required this.absenceLimit,
    required this.currentAbsence,
    required this.startTime,
    required this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bugünün Dersi: $courseName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Devamsızlık Durumu',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Stack(
              children: [
                Container(
                  height: (20*absenceLimit).toDouble(),
                  width: 10,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      height: (20*currentAbsence).toDouble(),
                      width: 10,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      height: (20*(absenceLimit-currentAbsence)).toDouble(),
                      width: 10,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Yüzde: 10',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Ders Saati: $startTime - $endTime',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
