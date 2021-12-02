// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'park_service_inner_join_service_additional_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkServiceInnerJoinServiceAdditionalModel
    _$ParkServiceInnerJoinServiceAdditionalModelFromJson(
        Map<String, dynamic> json) {
  return ParkServiceInnerJoinServiceAdditionalModel(
    json['id_servico'] as int,
    json['name'] as String,
    json['id'] as int,
    json['status'] as int,
    (json['price'] as num)?.toDouble(),
    (json['price_p'] as num)?.toDouble(),
    json['tolerance'] as String,
    json['sort_order'] as int,
    json['type'] as String,
  )..tickado = json['tickado'] as int;
}

Map<String, dynamic> _$ParkServiceInnerJoinServiceAdditionalModelToJson(
        ParkServiceInnerJoinServiceAdditionalModel instance) =>
    <String, dynamic>{
      'id_servico': instance.id_servico,
      'name': instance.name,
      'id': instance.id,
      'status': instance.status,
      'price': instance.price,
      'price_p': instance.price_p,
      'tolerance': instance.tolerance,
      'sort_order': instance.sort_order,
      'type': instance.type,
      'tickado': instance.tickado,
    };
