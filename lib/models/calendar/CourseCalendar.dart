import 'package:json_annotation/json_annotation.dart';

part 'CourseCalendar.g.dart';

@JsonSerializable()
class CourseCalendar {
  int courseId;
  int dayId;
  String startTime;
  String endTime;
  CourseCalendar(
      {
        required this.courseId,
        required this.dayId,
        required this.startTime,
        required this.endTime
      }
  );
  factory CourseCalendar.fromJson(Map<String, dynamic> json) => _$CourseCalendarFromJson(json);
  Map<String,dynamic> toJson() => _$CourseCalendarToJson(this);
}