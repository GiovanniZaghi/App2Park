import 'package:json_annotation/json_annotation.dart';

part 'payment_method_park_model.g.dart';

@JsonSerializable()
class PaymentMethodParkModel{
  String id;
  String id_park;
  String id_payment_method;
  String flat_rate;
  String variable_rate;
  String min_value;
  String status;
  String sort_order;

  PaymentMethodParkModel({this.id, this.id_park, this.id_payment_method, this.flat_rate,
      this.variable_rate, this.min_value, this.status, this.sort_order});

  factory PaymentMethodParkModel.fromJson(Map<String, dynamic> json) => _$PaymentMethodParkModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodParkModelToJson(this);

  @override
  String toString() {
    return 'PaymentMethodParkModel{id: $id, id_park: $id_park, id_payment_method: $id_payment_method, flat_rate: $flat_rate, variable_rate: $variable_rate, min_value: $min_value, status: $status, sort_order: $sort_order}';
  }
}