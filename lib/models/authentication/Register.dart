import 'package:json_annotation/json_annotation.dart';

part 'Register.g.dart';

@JsonSerializable()
class Register {
    String firstName;
    String lastName;
    String userName;
    String email;
    String password;
    String phoneNumber;
    Register({
      required this.firstName,
      required this.lastName,
      required this.userName,
      required this.email,
      required this.password,
      required this.phoneNumber
    });
    factory Register.fromJson(Map<String, dynamic> json) => _$RegisterFromJson(json);
    Map<String,dynamic> toJson() => _$RegisterToJson(this);
}


