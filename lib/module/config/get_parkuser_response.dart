import 'package:app2park/module/puser/park_user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_parkuser_response.g.dart';

@JsonSerializable()
class GetParkUserResponse {
  final String status;
  @JsonKey(includeIfNull : false)
  final List<ParkUser> data;
  final String message;

  GetParkUserResponse({this.status, this.data, this.message});

  factory GetParkUserResponse.fromJson(Map<String, dynamic> json) =>
      _$GetParkUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetParkUserResponseToJson(this);
}
