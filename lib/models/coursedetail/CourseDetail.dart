import 'package:json_annotation/json_annotation.dart';

part 'CourseDetail.g.dart';

@JsonSerializable()
class CourseDetail {
  int absenceLimit;
  int currentAbsence;
  String description;
  DateTime examTime;

  CourseDetail({
    required this.absenceLimit,
    required this.currentAbsence,
    required this.description,
    required this.examTime,
  });

  factory CourseDetail.fromJson(Map<String, dynamic> json) => _$CourseDetailFromJson(json);
  Map<String,dynamic> toJson() => _$CourseDetailToJson(this);
}
