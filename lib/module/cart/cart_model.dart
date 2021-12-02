import 'package:json_annotation/json_annotation.dart';


part 'cart_model.g.dart';

@JsonSerializable()
class CartModel{
  String id;
  String id_nota_fiscal_assinatura;
  String inter_number;
  String bank_slip_number;
  String bank_slip_value;
  String bank_slip_issue;
  String bank_slip_due;
  String bank_slip_payment;
  String status;

  CartModel(
      {this.id,
        this.id_nota_fiscal_assinatura,
      this.inter_number,
      this.bank_slip_number,
      this.bank_slip_value,
      this.bank_slip_issue,
      this.bank_slip_due,
      this.bank_slip_payment,
      this.status});

  factory CartModel.fromJson(Map<String, dynamic> json) => _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}