import 'package:absenteeism_v2/models/calendar/CourseCalendar.dart';
import 'package:json_annotation/json_annotation.dart';
import '../course/Course.dart';

part 'CourseCalendarForSyllabus.g.dart';

@JsonSerializable()
class CourseCalendarForSyllabus extends CourseCalendar {

  Course course;
  CourseCalendarForSyllabus({
    required this.course,
    required int courseId,
    required int dayId,
    required String startTime,
    required String endTime,
  }) : super(
    courseId: courseId,
    dayId: dayId,
    startTime: startTime,
    endTime: endTime,
  );
  factory CourseCalendarForSyllabus.fromJson(Map<String, dynamic> json) => _$CourseCalendarForSyllabusFromJson(json);
  Map<String,dynamic> toJson() => _$CourseCalendarForSyllabusToJson(this);
}
