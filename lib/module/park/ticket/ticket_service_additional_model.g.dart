// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_service_additional_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketServiceAdditionalModel _$TicketServiceAdditionalModelFromJson(
    Map<String, dynamic> json) {
  return TicketServiceAdditionalModel(
    id: json['id'] as String,
    id_ticket_service_additional_app:
        json['id_ticket_service_additional_app'] as String,
    id_ticket: json['id_ticket'] as String,
    id_ticket_app: json['id_ticket_app'] as String,
    id_park_service_additional: json['id_park_service_additional'] as String,
    name: json['name'] as String,
    price: json['price'] as String,
    tolerance: json['tolerance'] as String,
    finish_estimate: json['finish_estimate'] as String,
    price_justification: json['price_justification'] as String,
    observation: json['observation'] as String,
    id_status: json['id_status'] as String,
  );
}

Map<String, dynamic> _$TicketServiceAdditionalModelToJson(
        TicketServiceAdditionalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_ticket_service_additional_app':
          instance.id_ticket_service_additional_app,
      'id_ticket': instance.id_ticket,
      'id_ticket_app': instance.id_ticket_app,
      'id_park_service_additional': instance.id_park_service_additional,
      'name': instance.name,
      'price': instance.price,
      'tolerance': instance.tolerance,
      'finish_estimate': instance.finish_estimate,
      'price_justification': instance.price_justification,
      'observation': instance.observation,
      'id_status': instance.id_status,
    };
