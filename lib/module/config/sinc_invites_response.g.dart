// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sinc_invites_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SincInviteResponse _$SincInviteResponseFromJson(Map<String, dynamic> json) {
  return SincInviteResponse(
    status: json['status'] as String,
    puser: (json['puser'] as List)
        ?.map((e) =>
            e == null ? null : ParkUser.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$SincInviteResponseToJson(SincInviteResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'puser': instance.puser,
      'message': instance.message,
    };
