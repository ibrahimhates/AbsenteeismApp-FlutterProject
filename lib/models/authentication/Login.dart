import 'package:json_annotation/json_annotation.dart';

part 'Login.g.dart';

@JsonSerializable()
class Login {
  String username;
  String password;

  Login({
    required this.username,
    required this.password,
  });

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
  Map<String,dynamic> toJson() => _$LoginToJson(this);
}