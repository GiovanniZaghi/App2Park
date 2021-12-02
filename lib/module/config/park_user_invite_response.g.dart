// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'park_user_invite_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkUserInviteResponse _$ParkUserInviteResponseFromJson(
    Map<String, dynamic> json) {
  return ParkUserInviteResponse(
    status: json['status'] as String,
    puser: (json['puser'] as List)
        ?.map((e) =>
            e == null ? null : ParkUser.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
    link_invite: json['link_invite'] as String,
  );
}

Map<String, dynamic> _$ParkUserInviteResponseToJson(
        ParkUserInviteResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'puser': instance.puser,
      'message': instance.message,
      'link_invite': instance.link_invite,
    };
