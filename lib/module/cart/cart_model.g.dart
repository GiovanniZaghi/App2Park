// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) {
  return CartModel(
    id: json['id'] as String,
    id_nota_fiscal_assinatura: json['id_nota_fiscal_assinatura'] as String,
    inter_number: json['inter_number'] as String,
    bank_slip_number: json['bank_slip_number'] as String,
    bank_slip_value: json['bank_slip_value'] as String,
    bank_slip_issue: json['bank_slip_issue'] as String,
    bank_slip_due: json['bank_slip_due'] as String,
    bank_slip_payment: json['bank_slip_payment'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
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
