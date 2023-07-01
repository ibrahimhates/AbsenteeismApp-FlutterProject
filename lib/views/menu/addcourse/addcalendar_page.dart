import 'package:absenteeism_v2/controllers/coursecalendar/course_calendar_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import '../../../controllers/course/course_service.dart';
import '../../../models/calendar/CourseCalendar.dart';
import '../../../models/course/Course.dart';

class AddCourseCalendarPage extends StatefulWidget {
  @override
  _AddCourseCalendarPageState createState() => _AddCourseCalendarPageState();
}

class _AddCourseCalendarPageState extends State<AddCourseCalendarPage> {
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  List<Course> courses = [];
  List<String> days = [
    'Pazartesi',
    'Salı',
    'Çarşamba',
    'Perşembe',
    'Cuma',
    'Cumartesi',
    'Pazar',
  ];
  String? selectedDay;
  Course? selectedCourse;
  final Box _boxLogin = Hive.box("login");
  Future<TimeOfDay?> selectTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    return selectedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Center(child:Text('Ders Günlerini Ekle')),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              DropdownButtonFormField<Course>(
                value: selectedCourse,
                onChanged: (value) {
                  setState(() {
                    selectedCourse = value;
                  });
                },
                items: courses.map((course) {
                  return DropdownMenuItem<Course>(
                    value: course,
                    child: Text(course.courseName),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Dersler',
                ),
              ),
              DropdownButtonFormField<String>(
                value: selectedDay,
                onChanged: (value) {
                  setState(() {
                    selectedDay = value;
                  });
                },
                items: days.map((day) {
                  return DropdownMenuItem<String>(
                    value: day,
                    child: Text(day),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Günler',
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: startTimeController,
                      decoration: InputDecoration(labelText: 'Başlama Zamanı'),
                      enabled: false,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      TimeOfDay? selectedTime = await selectTime(context);
                      if (selectedTime != null) {
                        startTimeController.text = selectedTime.format(context);
                      }
                    },
                    icon: Icon(Icons.access_time),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: endTimeController,
                      decoration: InputDecoration(labelText: 'Bitiş Zamanı'),
                      enabled: false,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      TimeOfDay? selectedTime = await selectTime(context);
                      if (selectedTime != null) {
                        endTimeController.text = selectedTime.format(context);
                      }
                    },
                    icon: Icon(Icons.access_time),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.deepPurpleAccent),
                onPressed: () async {
                  await addCourseCalendar();
                },
                child: Text('Ekle'),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.deepPurpleAccent),
                onPressed: () async {
                  await fetchCourses();
                },
                child: Text('Derslerimi Getir'),
              ),
            ],
          ),
        ));
  }

  Future<void> fetchCourses() async {
    if (courses.isNotEmpty) return;
    final dio = Dio();
    final courseService = CourseService(dio);

    try {
      SpinKit();
      var token = _boxLogin.get("loginStatus");
      token = "Bearer $token";
      courses = await courseService.getAllCourseByUser(token);
      Navigator.pop(context);
      setState(() {});
    } catch (e) {
      Navigator.pop(context);
      Error("Bilinmeyen bir hata oluştu birkaç dk içinde tekrar deneyin!",
          "Hata");
    }
  }

  Future<void> addCourseCalendar() async {
    final dio = Dio();
    final calendarService = CalendarService(dio);

    if (selectedDay == null || selectedCourse == null) {
      Error("Ders ve Gün Boş Geçilemez", "Boş");
      return;
    }

    int dayId = days.indexOf(selectedDay!) + 1;
    int courseId = selectedCourse!.id;
    String startTime = startTimeController.text;
    String endTime = endTimeController.text;

    var courseCalendar = CourseCalendar(
      courseId: courseId,
      dayId: dayId,
      startTime: startTime,
      endTime: endTime,
    );
    try {
      SpinKit();
      var token = _boxLogin.get("loginStatus");
      token = "Bearer $token";
      await calendarService.createOneCourseCalendar(
          token, dayId, courseId, courseCalendar);
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      Error("Oluşturulmak istenen Ders Aynı günde Mevcut",
          "Hata");
    }
  }

  void Error(String message, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("Tamam"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void SpinKit() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
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
      },
    );
  }
}
