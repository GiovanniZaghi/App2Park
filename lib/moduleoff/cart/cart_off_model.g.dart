// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartOffModel _$CartOffModelFromJson(Map<String, dynamic> json) {
  return CartOffModel(
    json['id'] as int,
    json['id_nota_fiscal_assinatura'] as int,
    json['inter_number'] as String,
    json['bank_slip_number'] as String,
    (json['bank_slip_value'] as num)?.toDouble(),
    json['bank_slip_issue'] as String,
    json['bank_slip_due'] as String,
    json['bank_slip_payment'] as String,
    json['status'] as int,
  );
}

Map<String, dynamic> _$CartOffModelToJson(CartOffModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_nota_fiscal_assinatura': instance.id_nota_fiscal_assinatura,
      'inter_number': instance.inter_number,
      'bank_slip_number': instance.bank_slip_number,
      'bank_slip_value': instance.bank_slip_value,
      'bank_slip_issue': instance.bank_slip_issue,
      'bank_slip_due': instance.bank_slip_due,
      'bank_slip_payment': instance.bank_slip_payment,
      'status': instance.status,
    };
