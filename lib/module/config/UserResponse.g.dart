// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) {
  return UserResponse(
    status: json['status'] as String,
    data: json['data'] == null
        ? null
        : User.fromJson(json['data'] as Map<String, dynamic>),
    message: json['message'] as String,
    jwt: json['jwt'] as String,
  );
}

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) {
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
  val['jwt'] = instance.jwt;
  return val;
}
