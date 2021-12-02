// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tickets_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketsOffModel _$TicketsOffModelFromJson(Map<String, dynamic> json) {
  return TicketsOffModel(
    json['id'] as int,
    json['id_park'] as int,
    json['id_user'] as int,
    json['id_vehicle'] as int,
    json['id_vehicle_app'] as int,
    json['id_customer'] as int,
    json['id_customer_app'] as int,
    json['id_agreement'] as int,
    json['id_agreement_app'] as int,
    json['id_cupom'] as int,
    json['id_price_detached'] as int,
    json['id_price_detached_app'] as int,
    json['cupom_entrance_datetime'] as String,
    json['pay_until'] as String,
  )..id_ticket_app = json['id_ticket_app'] as int;
}

Map<String, dynamic> _$TicketsOffModelToJson(TicketsOffModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_ticket_app': instance.id_ticket_app,
      'id_park': instance.id_park,
      'id_user': instance.id_user,
      'id_vehicle': instance.id_vehicle,
      'id_vehicle_app': instance.id_vehicle_app,
      'id_customer': instance.id_customer,
      'id_customer_app': instance.id_customer_app,
      'id_agreement': instance.id_agreement,
      'id_agreement_app': instance.id_agreement_app,
      'id_cupom': instance.id_cupom,
      'id_price_detached': instance.id_price_detached,
      'id_price_detached_app': instance.id_price_detached_app,
      'cupom_entrance_datetime': instance.cupom_entrance_datetime,
      'pay_until': instance.pay_until,
    };
