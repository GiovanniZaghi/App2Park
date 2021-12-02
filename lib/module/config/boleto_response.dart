import 'package:app2park/module/boleto/boleto_get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'boleto_response.g.dart';

@JsonSerializable()
class BoletoResponse{
  String status;
  BoletoGet data;
  String message;

  BoletoResponse({this.status, this.data, this.message});

  factory BoletoResponse.fromJson(Map<String, dynamic> json) => _$BoletoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BoletoResponseToJson(this);

}