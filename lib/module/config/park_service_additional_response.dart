
import 'package:app2park/module/park_service_additional.dart';
import 'package:json_annotation/json_annotation.dart';

part 'park_service_additional_response.g.dart';

@JsonSerializable()
class ParkServiceAdditionalResponse {
  final String status;
  final List<ParkServiceAdditional> data;
  final String message;

  ParkServiceAdditionalResponse({this.status, this.data, this.message});

  factory ParkServiceAdditionalResponse.fromJson(Map<String, dynamic> json) =>
      _$ParkServiceAdditionalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ParkServiceAdditionalResponseToJson(this);
}
