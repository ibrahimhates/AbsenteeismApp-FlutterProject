import 'package:json_annotation/json_annotation.dart';

part 'Course.g.dart';

@JsonSerializable()
class Course {
  int id;
  String courseName;

  Course({required this.id, required this.courseName});

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
  Map<String,dynamic> toJson() => _$CourseToJson(this);
}
