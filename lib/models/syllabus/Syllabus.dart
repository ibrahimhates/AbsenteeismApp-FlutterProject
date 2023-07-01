import '../calendar/CourseCalendarForSyllabus.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Syllabus.g.dart';

@JsonSerializable()
class Syllabus{
  int id;
  String dayName;
  List<CourseCalendarForSyllabus> courseCalendars;
  Syllabus({
    required this.id,
    required this.dayName,
    required this.courseCalendars,
  });

  factory Syllabus.fromJson(Map<String, dynamic> json) => _$SyllabusFromJson(json);
  Map<String,dynamic> toJson() => _$SyllabusToJson(this);
}