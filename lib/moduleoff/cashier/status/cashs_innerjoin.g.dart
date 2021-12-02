// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cashs_innerjoin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectCashStatus _$SelectCashStatusFromJson(Map<String, dynamic> json) {
  return SelectCashStatus(
    json['id_park'] as int,
    json['id_user'] as int,
    json['id_cash_app'] as int,
    json['status'] as int,
  );
}

Map<String, dynamic> _$SelectCashStatusToJson(SelectCashStatus instance) =>
    <String, dynamic>{
      'id_park': instance.id_park,
      'id_user': instance.id_user,
      'id_cash_app': instance.id_cash_app,
      'status': instance.status,
    };
