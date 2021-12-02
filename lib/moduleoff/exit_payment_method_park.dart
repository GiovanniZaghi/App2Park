import 'package:json_annotation/json_annotation.dart';

part 'exit_payment_method_park.g.dart';

@JsonSerializable()
class ExitPaymentMethodPark{
  int id;
  int id_park;
  int id_payment_method;
  double flat_rate;
  double variable_rate;
  double min_value;
  int status;
  int sort_order;
  String name;

  ExitPaymentMethodPark(
      this.id,
      this.id_park,
      this.id_payment_method,
      this.flat_rate,
      this.variable_rate,
      this.min_value,
      this.status,
      this.sort_order,
      this.name);

  factory ExitPaymentMethodPark.fromJson(Map<String, dynamic> json) => _$ExitPaymentMethodParkFromJson(json);

  Map<String, dynamic> toJson() => _$ExitPaymentMethodParkToJson(this);

  @override
  String toString() {
    return 'ExitPaymentMethodPark{id: $id, id_park: $id_park, id_payment_method: $id_payment_method, flat_rate: $flat_rate, variable_rate: $variable_rate, min_value: $min_value, status: $status, sort_order: $sort_order, name: $name}';
  }
}