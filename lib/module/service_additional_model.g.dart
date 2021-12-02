// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_additional_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceAdditionalModel _$ServiceAdditionalModelFromJson(
    Map<String, dynamic> json) {
  return ServiceAdditionalModel(
    id: json['id'] as String,
    name: json['name'] as String,
    id_vehicle_type: json['id_vehicle_type'] as String,
    sort_order: json['sort_order'] as String,
  );
}

Map<String, dynamic> _$ServiceAdditionalModelToJson(
        ServiceAdditionalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'id_vehicle_type': instance.id_vehicle_type,
      'sort_order': instance.sort_order,
    };
