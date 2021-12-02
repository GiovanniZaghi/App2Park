// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_type_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleTypeResponse _$VehicleTypeResponseFromJson(Map<String, dynamic> json) {
  return VehicleTypeResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : VehicleTypeModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$VehicleTypeResponseToJson(
        VehicleTypeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
