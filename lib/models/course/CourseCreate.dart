import 'package:absenteeism_v2/models/coursedetail/CourseDetail.dart';
import 'Course.dart';
import 'package:json_annotation/json_annotation.dart';

part 'CourseCreate.g.dart';

@JsonSerializable()
class CourseCreate extends Course{
  CourseDetail courseDetail;

  CourseCreate({
    required super.courseName,
    required super.id,
    required this.courseDetail
  });

  factory CourseCreate.fromJson(Map<String, dynamic> json) => _$CourseCreateFromJson(json);
  Map<String,dynamic> toJson() => _$CourseCreateToJson(this);
}