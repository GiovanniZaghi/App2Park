// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_type_innerjoin_typepark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleTypeInnerjoinTypePark _$VehicleTypeInnerjoinTypeParkFromJson(
    Map<String, dynamic> json) {
  return VehicleTypeInnerjoinTypePark(
    type: json['type'] as String,
    id: json['id'] as int,
    id_vehicle_type: json['id_vehicle_type'] as int,
    id_park: json['id_park'] as int,
    status: json['status'] as int,
    sort_order: json['sort_order'] as int,
  );
}

Map<String, dynamic> _$VehicleTypeInnerjoinTypeParkToJson(
        VehicleTypeInnerjoinTypePark instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'id_vehicle_type': instance.id_vehicle_type,
      'id_park': instance.id_park,
      'status': instance.status,
      'sort_order': instance.sort_order,
    };
