import 'package:app2park/module/service_additional_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'service_additional_response.g.dart';

@JsonSerializable()
class ServiceAdditionalResponse{
  String status;
  List<ServiceAdditionalModel> data;
  String message;

  ServiceAdditionalResponse({this.status, this.data, this.message});

  factory ServiceAdditionalResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceAdditionalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceAdditionalResponseToJson(this);
}