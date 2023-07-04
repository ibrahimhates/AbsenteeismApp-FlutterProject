import 'package:absenteeism_v2/controllers/syllabus/syllabus_service.dart';
import 'package:absenteeism_v2/models/course/Course.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import '../../../models/calendar/CourseCalendarForSyllabus.dart';
import '../../../models/syllabus/Syllabus.dart';
class SyllabusView extends StatefulWidget {
  const SyllabusView({Key? key}) : super(key: key);

  @override
  State<SyllabusView> createState() => _SyllabusViewState();
}

class _SyllabusViewState extends State<SyllabusView> {
  final Box _boxLogin = Hive.box("login");

  Future<List<Syllabus>> fetchSyllabus() async {
    final dio = Dio();
    final syllService = SyllabusService(dio);

    var token = _boxLogin.get("loginStatus");
    token = "Bearer $token";

    return syllService.getSyllabus(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Program'),
      ),
      body: FutureBuilder<List<Syllabus>>(
        future: fetchSyllabus(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            final syllabusList = snapshot.data!;
            return ListView.builder(
              itemCount: syllabusList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(syllabusList[index].dayName),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseCalendarDetail(
                          courseCalendars: syllabusList[index].courseCalendars,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Veri Yok'),
            );
          } else {
            return Center(
              child: SpinKitFadingCircle(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? Colors.purple : Colors.purpleAccent,
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class CourseCalendarDetail extends StatelessWidget {
  final List<CourseCalendarForSyllabus> courseCalendars;

  CourseCalendarDetail({required this.courseCalendars});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Saatler'),
      ),
      body: ListView.builder(
        itemCount: courseCalendars.length,
        itemBuilder: (context, index) {
          return ListTile(
            style: ListTileStyle.drawer,
            title: Text('${courseCalendars[index].course.courseName}'),
            subtitle: Row(children: [
              Text('Start Time: ${courseCalendars[index].startTime}'),
              Text(' End Time: ${courseCalendars[index].endTime}'),
            ]),
          );
        },
      ),
    );
  }
}