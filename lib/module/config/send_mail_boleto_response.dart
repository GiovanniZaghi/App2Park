import 'package:json_annotation/json_annotation.dart';

part 'send_mail_boleto_response.g.dart';

@JsonSerializable()
class SendMailBoletoResponse{
  String status;

  SendMailBoletoResponse({this.status});

  factory SendMailBoletoResponse.fromJson(Map<String, dynamic> json) => _$SendMailBoletoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendMailBoletoResponseToJson(this);

}