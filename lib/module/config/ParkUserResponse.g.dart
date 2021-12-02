// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ParkUserResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkUserResponse _$ParkUserResponseFromJson(Map<String, dynamic> json) {
  return ParkUserResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : ParkUser.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
    photo: json['photo'] as String,
  );
}

Map<String, dynamic> _$ParkUserResponseToJson(ParkUserResponse instance) {
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
  val['photo'] = instance.photo;
  return val;
}
