import 'package:json_annotation/json_annotation.dart';

part 'simple_response.g.dart';

@JsonSerializable()
class SimpleResponse{
  String status;
  String message;

  SimpleResponse({this.status, this.message});

  factory SimpleResponse.fromJson(Map<String, dynamic> json) =>
      _$SimpleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleResponseToJson(this);


}