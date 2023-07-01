import 'package:absenteeism_v2/controllers/course/course_service.dart';
import 'package:absenteeism_v2/models/course/CourseCreate.dart';
import 'package:absenteeism_v2/models/coursedetail/CourseDetail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({Key? key}) : super(key: key);

  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  TextEditingController dersAdiController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? examDate;
  TimeOfDay? examTime;
  int? absenceLimit;
  int? currentAbsence;
  final Box _boxLogin = Hive.box("login");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Center(child:Text('Ders Ekle')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: dersAdiController,
              decoration: InputDecoration(
                labelText: 'Ders Adı',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<int>(
              value: absenceLimit,
              decoration:
                  const InputDecoration(labelText: 'Devamsızlık Sınırı'),
              onChanged: (value) {
                setState(() {
                  absenceLimit = value;
                  currentAbsence = null;
                });
              },
              items: List.generate(100, (index) => index + 1).map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
            ),
            SizedBox(
              height: 10,
            ),
            if (absenceLimit != null)
              DropdownButtonFormField<int>(
                value: currentAbsence,
                decoration:
                    const InputDecoration(labelText: 'Şu an ki Devamsızlık'),
                onChanged: (value) {
                  setState(() {
                    currentAbsence = value;
                  });
                },
                items: List.generate(absenceLimit!, (index) => index + 1)
                    .map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Açıklama',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month_outlined),
              title: Text(
                examDate != null && examTime != null
                    ? 'Exam Time: ${examDate!.toString().split(' ')[0]} ${examTime!.format(context)}'
                    : 'Select Exam Time',
              ),
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  final pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      examDate = pickedDate;
                      examTime = pickedTime;
                    });
                  }
                }
              },
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.deepPurpleAccent),
              onPressed: () async {
                var time = DateTime(
                  examDate!.year,
                  examDate!.month,
                  examDate!.day,
                  examTime!.hour,
                  examTime!.minute,
                );
                var createdCourse = CourseCreate(
                  courseName: dersAdiController.text,
                  id: 0,
                  courseDetail: CourseDetail(
                    absenceLimit: absenceLimit!,
                    description: descriptionController.text,
                    currentAbsence: currentAbsence!,
                    examTime: time,
                  ),
                );
                await fetchCreate(createdCourse);
              },
              child: const Text("Kaydet"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchCreate(CourseCreate courseCreate) async {
    final dio = Dio();
    final courseService = CourseService(dio);

    try {
      SpinKit();
      var token = _boxLogin.get("loginStatus");
      token = "Bearer $token";
      var createdCourse =
          await courseService.getCreateOneCourse(token, courseCreate);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CourseDetailPage(
            created: createdCourse,
          ),
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      Error(
          "Kaydetme işleminde bir hata oluştu internet bağlantınızı kontrol edin",
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

class CourseDetailPage extends StatelessWidget {
  final CourseCreate created;

  CourseDetailPage({required this.created});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kayıt Detayı'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Course Name: ${created.courseName}'),
          Text('Course ID: ${created.id}'),
          Text('Absence Limit: ${created.courseDetail.absenceLimit}'),
          Text('Current Absence: ${created.courseDetail.currentAbsence}'),
          Text('Description: ${created.courseDetail.description}'),
          Text('Exam Time: ${created.courseDetail.examTime}'),
        ],
      ),
    );
  }
}
