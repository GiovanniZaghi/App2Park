import 'package:app2park/module/user/User.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_list_response.g.dart';

@JsonSerializable()
class UserListResponse {
  final String status;
  final List<User> data;
  final String message;

  UserListResponse({this.status, this.data, this.message});

  factory UserListResponse.fromJson(Map<String, dynamic> json) =>
      _$UserListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserListResponseToJson(this);
}
