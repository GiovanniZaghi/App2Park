// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_parkuser_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetParkUserResponse _$GetParkUserResponseFromJson(Map<String, dynamic> json) {
  return GetParkUserResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : ParkUser.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$GetParkUserResponseToJson(GetParkUserResponse instance) {
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
