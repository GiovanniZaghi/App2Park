import 'package:app2park/module/park/Park.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UploadImageResponse.g.dart';

@JsonSerializable()
class UploadImageResponse {
  final String status;
  final Park data;
  final String message;

  UploadImageResponse({this.status, this.data, this.message});

  factory UploadImageResponse.fromJson(Map<String, dynamic> json) => _$UploadImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadImageResponseToJson(this);
}
