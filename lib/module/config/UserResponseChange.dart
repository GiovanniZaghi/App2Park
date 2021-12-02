import 'package:app2park/module/user/User.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UserResponseChange.g.dart';

@JsonSerializable()
class UserResponseChange {
  final String status;
  @JsonKey(includeIfNull : false)
  final User data;
  final String message;

  UserResponseChange({this.status, this.data, this.message});

  factory UserResponseChange.fromJson(Map<String, dynamic> json) =>
      _$UserResponseChangeFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseChangeToJson(this);
}
