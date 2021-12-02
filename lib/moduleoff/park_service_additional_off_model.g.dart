// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'park_service_additional_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkServiceAdditionalOffModel _$ParkServiceAdditionalOffModelFromJson(
    Map<String, dynamic> json) {
  return ParkServiceAdditionalOffModel(
    json['id'] as int,
    json['id_service_additional'] as int,
    json['id_park'] as int,
    (json['price'] as num)?.toDouble(),
    json['tolerance'] as String,
    json['sort_order'] as int,
    json['status'] as int,
    json['date_edited'] as String,
  );
}

Map<String, dynamic> _$ParkServiceAdditionalOffModelToJson(
        ParkServiceAdditionalOffModel instance) =>
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
