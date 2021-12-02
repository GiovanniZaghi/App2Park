import 'package:app2park/module/version.dart';
import 'package:json_annotation/json_annotation.dart';

part 'version_response.g.dart';

@JsonSerializable()
class VersionResponse{
  String status;
  List<Version> data;
  String message;

  VersionResponse({this.status, this.data, this.message});

  factory VersionResponse.fromJson(Map<String, dynamic> json) =>
      _$VersionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VersionResponseToJson(this);


}