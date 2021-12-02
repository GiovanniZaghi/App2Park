import 'package:app2park/module/office/office_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'office_response.g.dart';

@JsonSerializable()
class OfficeResponse{
  String status;
  List<Office> data;
  String message;

  OfficeResponse({this.status, this.data, this.message});

  factory OfficeResponse.fromJson(Map<String, dynamic> json) =>
      _$OfficeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OfficeResponseToJson(this);


}