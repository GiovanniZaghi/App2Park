// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_type_park_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleTypeParkOffModel _$VehicleTypeParkOffModelFromJson(
    Map<String, dynamic> json) {
  return VehicleTypeParkOffModel(
    json['id'] as int,
    json['id_vehicle_type'] as int,
    json['id_park'] as int,
    json['status'] as int,
    json['sort_order'] as int,
  );
}

Map<String, dynamic> _$VehicleTypeParkOffModelToJson(
        VehicleTypeParkOffModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_vehicle_type': instance.id_vehicle_type,
      'id_park': instance.id_park,
      'status': instance.status,
      'sort_order': instance.sort_order,
    };
