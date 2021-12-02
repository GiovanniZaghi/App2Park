import 'package:json_annotation/json_annotation.dart';

part 'payment_method_park_off_model.g.dart';

@JsonSerializable()
class PaymentMethodParkOffModel{
  int id;
  int id_park;
  int id_payment_method;
  double flat_rate;
  double variable_rate;
  double min_value;
  int status;
  int sort_order;

  PaymentMethodParkOffModel(this.id, this.id_park, this.id_payment_method, this.flat_rate,
    this.variable_rate, this.min_value, this.status, this.sort_order);

  factory PaymentMethodParkOffModel.fromJson(Map<String, dynamic> json) => _$PaymentMethodParkOffModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodParkOffModelToJson(this);

  @override
  String toString() {
    return 'PaymentMethodParkModel{id: $id, id_park: $id_park, id_payment_method: $id_payment_method, flat_rate: $flat_rate, variable_rate: $variable_rate, min_value: $min_value, status: $status, sort_order: $sort_order}';
  }
}