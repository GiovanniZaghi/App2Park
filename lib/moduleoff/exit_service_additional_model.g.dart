// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exit_service_additional_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExitServiceAdditionalModel _$ExitServiceAdditionalModelFromJson(
    Map<String, dynamic> json) {
  return ExitServiceAdditionalModel(
    json['id'] as int,
    json['id_ticket'] as int,
    json['id_ticket_service_additional_app'] as int,
    json['id_ticket_app'] as int,
    json['id_park_service_additional'] as int,
    json['name'] as String,
    (json['price'] as num)?.toDouble(),
    json['lack'] as String,
    json['finish_estimate'] as String,
    json['price_justification'] as String,
    json['observation'] as String,
    json['id_status'] as int,
  );
}

Map<String, dynamic> _$ExitServiceAdditionalModelToJson(
        ExitServiceAdditionalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_ticket': instance.id_ticket,
      'id_ticket_service_additional_app':
          instance.id_ticket_service_additional_app,
      'id_ticket_app': instance.id_ticket_app,
      'id_park_service_additional': instance.id_park_service_additional,
      'name': instance.name,
      'price': instance.price,
      'lack': instance.lack,
      'finish_estimate': instance.finish_estimate,
      'price_justification': instance.price_justification,
      'observation': instance.observation,
      'id_status': instance.id_status,
    };
