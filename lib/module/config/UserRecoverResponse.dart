import 'package:app2park/module/user/User.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UserRecoverResponse.g.dart';

@JsonSerializable()
class UserRecoverResponse {
  final String status;
  final User data;
  final String message;

  UserRecoverResponse({this.status, this.data, this.message});

  factory UserRecoverResponse.fromJson(Map<String, dynamic> json) => _$UserRecoverResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserRecoverResponseToJson(this);
}
