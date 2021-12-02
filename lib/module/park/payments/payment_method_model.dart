import 'package:json_annotation/json_annotation.dart';

part 'payment_method_model.g.dart';

@JsonSerializable()
class PaymentMethodModel{
  String id;
  String name;
  String flat_rate;
  String variable_rate;
  String min_value;
  String status;
  String sort_order;


  PaymentMethodModel({this.id, this.name, this.flat_rate, this.variable_rate,
      this.min_value, this.status, this.sort_order});

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) => _$PaymentMethodModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodModelToJson(this);

  @override
  String toString() {
    return 'PaymentMethodModel{id: $id, name: $name, flat_rate: $flat_rate, variable_rate: $variable_rate, min_value: $min_value, status: $status, sort_order: $sort_order}';
  }
}