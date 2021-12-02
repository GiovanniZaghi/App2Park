// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'park_service_additional.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkServiceAdditional _$ParkServiceAdditionalFromJson(
    Map<String, dynamic> json) {
  return ParkServiceAdditional(
    id: json['id'] as String,
    id_service_additional: json['id_service_additional'] as String,
    id_park: json['id_park'] as String,
    price: json['price'] as String,
    tolerance: json['tolerance'] as String,
    sort_order: json['sort_order'] as String,
    status: json['status'] as String,
    date_edited: json['date_edited'] as String,
  );
}

Map<String, dynamic> _$ParkServiceAdditionalToJson(
        ParkServiceAdditional instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_service_additional': instance.id_service_additional,
      'id_park': instance.id_park,
      'price': instance.price,
      'tolerance': instance.tolerance,
      'sort_order': instance.sort_order,
      'status': instance.status,
      'date_edited': instance.date_edited,
    };
