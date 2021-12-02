// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cashs_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashsOff _$CashsOffFromJson(Map<String, dynamic> json) {
  return CashsOff(
    json['id'] as int,
    json['id_park'] as int,
    json['id_user'] as int,
  )..id_cash_app = json['id_cash_app'] as int;
}

Map<String, dynamic> _$CashsOffToJson(CashsOff instance) => <String, dynamic>{
      'id': instance.id,
      'id_cash_app': instance.id_cash_app,
      'id_park': instance.id_park,
      'id_user': instance.id_user,
    };
