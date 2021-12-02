// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ParkResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkResponse _$ParkResponseFromJson(Map<String, dynamic> json) {
  return ParkResponse(
    status: json['status'] as String,
    data: json['data'] == null
        ? null
        : Park.fromJson(json['data'] as Map<String, dynamic>),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$ParkResponseToJson(ParkResponse instance) {
  final val = <String, dynamic>{
    'status': instance.status,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data);
  val['message'] = instance.message;
  return val;
}
