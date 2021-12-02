// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) {
  return Ticket(
    id: json['id'] as String,
    id_ticket_app: json['id_ticket_app'] as String,
    id_park: json['id_park'] as String,
    id_user: json['id_user'] as String,
    id_vehicle: json['id_vehicle'] as String,
    id_vehicle_app: json['id_vehicle_app'] as String,
    id_customer: json['id_customer'] as String,
    id_customer_app: json['id_customer_app'] as String,
    id_agreement: json['id_agreement'] as String,
    id_agreement_app: json['id_agreement_app'] as String,
    id_cupom: json['id_cupom'] as String,
    id_price_detached: json['id_price_detached'] as String,
    id_price_detached_app: json['id_price_detached_app'] as String,
    cupom_entrance_datetime: json['cupom_entrance_datetime'] as String,
    pay_until: json['pay_until'] as String,
  );
}

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
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
