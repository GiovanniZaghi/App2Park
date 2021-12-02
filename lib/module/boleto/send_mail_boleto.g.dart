// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_mail_boleto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendMailBoleto _$SendMailBoletoFromJson(Map<String, dynamic> json) {
  return SendMailBoleto(
    id_park: json['id_park'] as String,
    name: json['name'] as String,
    inter_number: json['inter_number'] as String,
    bank_slip_number: json['bank_slip_number'] as String,
    bank_slip_value: json['bank_slip_value'] as String,
    email: json['email'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$SendMailBoletoToJson(SendMailBoleto instance) =>
    <String, dynamic>{
      'id_park': instance.id_park,
      'name': instance.name,
      'inter_number': instance.inter_number,
      'bank_slip_number': instance.bank_slip_number,
      'bank_slip_value': instance.bank_slip_value,
      'email': instance.email,
      'type': instance.type,
    };
