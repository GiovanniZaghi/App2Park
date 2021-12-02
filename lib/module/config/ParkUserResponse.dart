import 'package:app2park/module/puser/park_user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ParkUserResponse.g.dart';

@JsonSerializable()
class ParkUserResponse {
  final String status;
  @JsonKey(includeIfNull : false)
  final List<ParkUser> data;
  final String message;
  final String photo;

  ParkUserResponse({this.status, this.data, this.message, this.photo});

  factory ParkUserResponse.fromJson(Map<String, dynamic> json) =>
      _$ParkUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ParkUserResponseToJson(this);
}
