import 'package:app2park/module/status/status_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'status_response.g.dart';

@JsonSerializable()
class StatusResponse{
  String status;
  List<Status> data;
  String message;

  StatusResponse({this.status, this.data, this.message});

  factory StatusResponse.fromJson(Map<String, dynamic> json) =>
      _$StatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StatusResponseToJson(this);


}