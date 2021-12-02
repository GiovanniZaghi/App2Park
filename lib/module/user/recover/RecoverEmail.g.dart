// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RecoverEmail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecoverEmail _$RecoverEmailFromJson(Map<String, dynamic> json) {
  return RecoverEmail(
    email: json['email'] as String,
    keyval: json['keyval'] as String,
    pass: json['pass'] as String,
  );
}

Map<String, dynamic> _$RecoverEmailToJson(RecoverEmail instance) =>
    <String, dynamic>{
      'email': instance.email,
      'keyval': instance.keyval,
      'pass': instance.pass,
    };
