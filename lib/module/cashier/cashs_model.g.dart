// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cashs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cashs _$CashsFromJson(Map<String, dynamic> json) {
  return Cashs(
    id: json['id'] as String,
    id_cash_app: json['id_cash_app'] as String,
    id_park: json['id_park'] as String,
    id_user: json['id_user'] as String,
  );
}

Map<String, dynamic> _$CashsToJson(Cashs instance) => <String, dynamic>{
      'id': instance.id,
      'id_cash_app': instance.id_cash_app,
      'id_park': instance.id_park,
      'id_user': instance.id_user,
    };
