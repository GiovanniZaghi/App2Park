// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserForgotResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserForgotResponse _$UserForgotResponseFromJson(Map<String, dynamic> json) {
  return UserForgotResponse(
    status: json['status'] as String,
    data: json['data'] as String,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$UserForgotResponseToJson(UserForgotResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
