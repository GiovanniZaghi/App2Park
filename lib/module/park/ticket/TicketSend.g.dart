// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TicketSend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketSend _$TicketSendFromJson(Map<String, dynamic> json) {
  return TicketSend(
    id_park: json['id_park'] as String,
    id_vehicle: json['id_vehicle'] as String,
    id_customer: json['id_customer'] as String,
    cupom: json['cupom'] as String,
    id_user: json['id_user'] as String,
  );
}

Map<String, dynamic> _$TicketSendToJson(TicketSend instance) =>
    <String, dynamic>{
      'id_park': instance.id_park,
      'id_vehicle': instance.id_vehicle,
      'id_customer': instance.id_customer,
      'id_user': instance.id_user,
      'cupom': instance.cupom,
    };
