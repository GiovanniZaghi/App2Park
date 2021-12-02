import 'package:json_annotation/json_annotation.dart';
part 'send_mail_boleto.g.dart';

@JsonSerializable()
class SendMailBoleto{
  String id_park;
  String name;
  String inter_number;
  String bank_slip_number;
  String bank_slip_value;
  String email;
  String type;

  SendMailBoleto({this.id_park, this.name, this.inter_number,
      this.bank_slip_number, this.bank_slip_value, this.email, this.type});

  factory SendMailBoleto.fromJson(Map<String, dynamic> json) => _$SendMailBoletoFromJson(json);

  Map<String, dynamic> toJson() => _$SendMailBoletoToJson(this);
}