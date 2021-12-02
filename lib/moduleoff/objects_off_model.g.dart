// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'objects_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjectsOffModel _$ObjectsOffModelFromJson(Map<String, dynamic> json) {
  return ObjectsOffModel(
    json['id'] as int,
    json['name'] as String,
    json['sort_order'] as int,
  )..tickado = json['tickado'] as int;
}

Map<String, dynamic> _$ObjectsOffModelToJson(ObjectsOffModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sort_order': instance.sort_order,
      'tickado': instance.tickado,
    };
