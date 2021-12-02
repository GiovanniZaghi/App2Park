import 'package:json_annotation/json_annotation.dart';

part 'payment_method_park_inner.g.dart';

@JsonSerializable()
class PaymentMethodParkInner{
  int id;
  int id_park;
  int id_payment_method;
  double flat_rate;
  double variable_rate;
  double min_value;
  int id_status;
  int sort_order;
  String name;

  PaymentMethodParkInner(
      this.id,
      this.id_park,
      this.id_payment_method,
      this.flat_rate,
      this.variable_rate,
      this.min_value,
      this.id_status,
      this.sort_order,
      this.name);

  factory PaymentMethodParkInner.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodParkInnerFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodParkInnerToJson(this);
}