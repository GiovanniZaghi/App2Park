import 'package:app2park/module/user/User.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UserResponse.g.dart';

@JsonSerializable()
class UserResponse {
  final String status;
  @JsonKey(includeIfNull : false)
  final User data;
  final String message;
  final String jwt;

  UserResponse({this.status, this.data, this.message, this.jwt});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
