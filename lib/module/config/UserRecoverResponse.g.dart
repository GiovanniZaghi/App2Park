// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserRecoverResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRecoverResponse _$UserRecoverResponseFromJson(Map<String, dynamic> json) {
  return UserRecoverResponse(
    status: json['status'] as String,
    data: json['data'] == null
        ? null
        : User.fromJson(json['data'] as Map<String, dynamic>),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$UserRecoverResponseToJson(
        UserRecoverResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
