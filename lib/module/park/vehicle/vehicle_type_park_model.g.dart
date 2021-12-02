// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_type_park_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleTypeParkModel _$VehicleTypeParkModelFromJson(Map<String, dynamic> json) {
  return VehicleTypeParkModel(
    id: json['id'] as String,
    id_vehicle_type: json['id_vehicle_type'] as String,
    id_park: json['id_park'] as String,
    status: json['status'] as String,
    sort_order: json['sort_order'] as String,
  );
}

Map<String, dynamic> _$VehicleTypeParkModelToJson(
        VehicleTypeParkModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_vehicle_type': instance.id_vehicle_type,
      'id_park': instance.id_park,
      'status': instance.status,
      'sort_order': instance.sort_order,
    };
