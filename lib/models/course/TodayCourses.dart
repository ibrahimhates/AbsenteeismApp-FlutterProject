import '../course/Course.dart';
import '../calendar/CourseCalendar.dart';
import '../coursedetail/CourseDetail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'TodayCourses.g.dart';

@JsonSerializable()
class TodayCourses extends Course{
  CourseDetail courseDetail;
  List<CourseCalendar> courseCalendars;

  TodayCourses({
    required this.courseDetail,
    required this.courseCalendars,
    required super.id,
    required super.courseName,
  });

  factory TodayCourses.fromJson(Map<String, dynamic> json) => _$TodayCoursesFromJson(json);
  Map<String,dynamic> toJson() => _$TodayCoursesToJson(this);
}