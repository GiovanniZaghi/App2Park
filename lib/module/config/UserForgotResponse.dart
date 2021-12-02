import 'package:app2park/module/user/User.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UserForgotResponse.g.dart';

@JsonSerializable()
class UserForgotResponse {
  final String status;
  final String data;
  final String message;

  UserForgotResponse({this.status, this.data, this.message});

  factory UserForgotResponse.fromJson(Map<String, dynamic> json) => _$UserForgotResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserForgotResponseToJson(this);
}
