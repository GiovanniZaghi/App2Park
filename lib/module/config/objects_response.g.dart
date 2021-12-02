// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'objects_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjectsResponse _$ObjectsResponseFromJson(Map<String, dynamic> json) {
  return ObjectsResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : ObjectsModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$ObjectsResponseToJson(ObjectsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
