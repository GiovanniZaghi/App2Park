import 'package:json_annotation/json_annotation.dart';

part 'payment_method_inner_join_payment_method_park_model.g.dart';

@JsonSerializable()
class PaymentMethodInnerJoinPaymentMethodPark{
  String name;
  String st;
  int id;
  int id_park;
  int id_payment_method;
  double flat_rate;
  double variable_rate;
  double min_value;
  int status;
  int sort_order;

  PaymentMethodInnerJoinPaymentMethodPark({
      this.name,
      this.st,
      this.id,
      this.id_park,
      this.id_payment_method,
      this.flat_rate,
      this.variable_rate,
      this.min_value,
      this.status,
      this.sort_order});

  factory PaymentMethodInnerJoinPaymentMethodPark.fromJson(Map<String, dynamic> json) => _$PaymentMethodInnerJoinPaymentMethodParkFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodInnerJoinPaymentMethodParkToJson(this);

  @override
  String toString() {
    return 'PaymentMethodInnerJoinPaymentMethodPark{name: $name, st: $st, id: $id, id_park: $id_park, id_payment_method: $id_payment_method, flat_rate: $flat_rate, variable_rate: $variable_rate, min_value: $min_value, status: $status, sort_order: $sort_order}';
  }
}