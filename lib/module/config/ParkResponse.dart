import 'package:app2park/module/park/Park.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ParkResponse.g.dart';

@JsonSerializable()
class ParkResponse {
  final String status;
  @JsonKey(includeIfNull : false)
  final Park data;
  final String message;

  ParkResponse({this.status, this.data, this.message});

  factory ParkResponse.fromJson(Map<String, dynamic> json) => _$ParkResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ParkResponseToJson(this);
}
