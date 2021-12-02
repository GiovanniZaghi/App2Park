// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verifiy_plate_exists_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyPlateExitsModel _$VerifyPlateExitsModelFromJson(
    Map<String, dynamic> json) {
  return VerifyPlateExitsModel(
    json['name'] as String,
    json['id'] as int,
    json['id_ticket'] as int,
    json['id_ticket_historic_app'] as int,
    json['id_ticket_app'] as int,
    json['id_ticket_historic_status'] as int,
    json['id_user'] as int,
    json['id_service_additional'] as int,
    json['id_service_additional_app'] as int,
    json['date_time'] as String,
  );
}

Map<String, dynamic> _$VerifyPlateExitsModelToJson(
        VerifyPlateExitsModel instance) =>
    <String, dynamic>{
      'name': instance.name,
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
