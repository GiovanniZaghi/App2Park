import 'package:json_annotation/json_annotation.dart';

part 'payment_method_park_check_box.g.dart';

@JsonSerializable()
class PaymentMethodParkCheckBox{
  String payment;
  bool status;

  PaymentMethodParkCheckBox({this.payment, this.status});

  factory PaymentMethodParkCheckBox.fromJson(Map<String, dynamic> json) => _$PaymentMethodParkCheckBoxFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodParkCheckBoxToJson(this);

  @override
  String toString() {
    return 'PaymentMethodParkCheckBox{payment: $payment, status: $status}';
  }
}