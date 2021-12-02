// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_movement_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashMovementResponse _$CashMovementResponseFromJson(Map<String, dynamic> json) {
  return CashMovementResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : CashMovement.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$CashMovementResponseToJson(
        CashMovementResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
