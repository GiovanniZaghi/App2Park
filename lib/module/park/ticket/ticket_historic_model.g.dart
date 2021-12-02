// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_historic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketHistoricModel _$TicketHistoricModelFromJson(Map<String, dynamic> json) {
  return TicketHistoricModel(
    id: json['id'] as String,
    id_ticket_historic_app: json['id_ticket_historic_app'] as String,
    id_ticket: json['id_ticket'] as String,
    id_ticket_app: json['id_ticket_app'] as String,
    id_user: json['id_user'] as String,
    id_ticket_historic_status: json['id_ticket_historic_status'] as String,
    id_service_additional: json['id_service_additional'] as String,
    date_time: json['date_time'] as String,
  );
}

Map<String, dynamic> _$TicketHistoricModelToJson(
        TicketHistoricModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_ticket_historic_app': instance.id_ticket_historic_app,
      'id_ticket': instance.id_ticket,
      'id_ticket_app': instance.id_ticket_app,
      'id_user': instance.id_user,
      'id_ticket_historic_status': instance.id_ticket_historic_status,
      'id_service_additional': instance.id_service_additional,
      'date_time': instance.date_time,
    };
