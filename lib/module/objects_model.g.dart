// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'objects_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjectsModel _$ObjectsModelFromJson(Map<String, dynamic> json) {
  return ObjectsModel(
    id: json['id'] as String,
    name: json['name'] as String,
    sort_order: json['sort_order'] as String,
  );
}

Map<String, dynamic> _$ObjectsModelToJson(ObjectsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sort_order': instance.sort_order,
    };
