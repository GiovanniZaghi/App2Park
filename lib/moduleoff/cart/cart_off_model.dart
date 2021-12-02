import 'package:json_annotation/json_annotation.dart';


part 'cart_off_model.g.dart';

@JsonSerializable()
class CartOffModel{
  int id;
  int id_nota_fiscal_assinatura;
  String inter_number;
  String bank_slip_number;
  double bank_slip_value;
  String bank_slip_issue;
  String bank_slip_due;
  String bank_slip_payment;
  int status;

  CartOffModel(
      this.id,
      this.id_nota_fiscal_assinatura,
      this.inter_number,
      this.bank_slip_number,
      this.bank_slip_value,
      this.bank_slip_issue,
      this.bank_slip_due,
      this.bank_slip_payment,
      this.status);

  factory CartOffModel.fromJson(Map<String, dynamic> json) => _$CartOffModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartOffModelToJson(this);
}