// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_additional_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceAdditionalOffModel _$ServiceAdditionalOffModelFromJson(
    Map<String, dynamic> json) {
  return ServiceAdditionalOffModel(
    json['id'] as int,
    json['name'] as String,
    json['id_vehicle_type'] as int,
    json['sort_order'] as int,
  );
}

Map<String, dynamic> _$ServiceAdditionalOffModelToJson(
        ServiceAdditionalOffModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'id_vehicle_type': instance.id_vehicle_type,
      'sort_order': instance.sort_order,
    };
