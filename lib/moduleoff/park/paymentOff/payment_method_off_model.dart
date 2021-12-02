import 'package:json_annotation/json_annotation.dart';

part 'payment_method_off_model.g.dart';

@JsonSerializable()
class PaymentMethodOffModel{
  int id;
  String name;
  double flat_rate;
  double variable_rate;
  double min_value;
  int status;
  int sort_order;


  PaymentMethodOffModel(this.id, this.name, this.flat_rate, this.variable_rate,
    this.min_value, this.status, this.sort_order);

  factory PaymentMethodOffModel.fromJson(Map<String, dynamic> json) => _$PaymentMethodOffModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodOffModelToJson(this);

  @override
  String toString() {
    return 'PaymentMethodModel{id: $id, name: $name, flat_rate: $flat_rate, variable_rate: $variable_rate, min_value: $min_value, status: $status, sort_order: $sort_order}';
  }
}