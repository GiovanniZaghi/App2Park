// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserListResponse _$UserListResponseFromJson(Map<String, dynamic> json) {
  return UserListResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$UserListResponseToJson(UserListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
