// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_historic_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketHistoricOffModel _$TicketHistoricOffModelFromJson(
    Map<String, dynamic> json) {
  return TicketHistoricOffModel(
    json['id'] as int,
    json['id_ticket'] as int,
    json['id_ticket_app'] as int,
    json['id_ticket_historic_status'] as int,
    json['id_user'] as int,
    json['id_service_additional'] as int,
    json['id_service_additional_app'] as int,
    json['date_time'] as String,
  )..id_ticket_historic_app = json['id_ticket_historic_app'] as int;
}

Map<String, dynamic> _$TicketHistoricOffModelToJson(
        TicketHistoricOffModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_ticket': instance.id_ticket,
      'id_ticket_historic_app': instance.id_ticket_historic_app,
      'id_ticket_app': instance.id_ticket_app,
      'id_ticket_historic_status': instance.id_ticket_historic_status,
      'id_user': instance.id_user,
      'id_service_additional': instance.id_service_additional,
      'id_service_additional_app': instance.id_service_additional_app,
      'date_time': instance.date_time,
    };
