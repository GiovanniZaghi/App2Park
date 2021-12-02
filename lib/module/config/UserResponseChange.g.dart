// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserResponseChange.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponseChange _$UserResponseChangeFromJson(Map<String, dynamic> json) {
  return UserResponseChange(
    status: json['status'] as String,
    data: json['data'] == null
        ? null
        : User.fromJson(json['data'] as Map<String, dynamic>),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$UserResponseChangeToJson(UserResponseChange instance) {
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
