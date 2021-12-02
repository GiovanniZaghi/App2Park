// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Office _$OfficeFromJson(Map<String, dynamic> json) {
  return Office(
    id: json['id'] as String,
    office: json['office'] as String,
  );
}

Map<String, dynamic> _$OfficeToJson(Office instance) => <String, dynamic>{
      'id': instance.id,
      'office': instance.office,
    };
