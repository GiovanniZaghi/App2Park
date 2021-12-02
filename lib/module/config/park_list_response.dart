import 'package:app2park/module/park/Park.dart';
import 'package:json_annotation/json_annotation.dart';

part 'park_list_response.g.dart';

@JsonSerializable()
class ParkListResponse {
  String status;
  List<Park> data;
  String message;

  ParkListResponse({this.status, this.data, this.message});

  factory ParkListResponse.fromJson(Map<String, dynamic> json) => _$ParkListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ParkListResponseToJson(this);
}
