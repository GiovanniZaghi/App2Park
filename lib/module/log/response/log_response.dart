
import 'package:json_annotation/json_annotation.dart';

part 'log_response.g.dart';

@JsonSerializable()
class LogResponse{
  String status;
  String message;

  LogResponse({this.status,this.message});

  factory LogResponse.fromJson(Map<String, dynamic> json) => _$LogResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LogResponseToJson(this);

}