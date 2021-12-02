import 'package:json_annotation/json_annotation.dart';

part 'vehicle_inner_join_customer_model.g.dart';

@JsonSerializable()
class VehicleInnerJoinCustomer{
  int id;
  int id_customer_app;
  String cell;
  String email;
  String name;
  String doc;
  int id_status;

  VehicleInnerJoinCustomer(this.id, this.id_customer_app, this.cell, this.email,
      this.name, this.doc, this.id_status);

  factory VehicleInnerJoinCustomer.fromJson(Map<String, dynamic> json) => _$VehicleInnerJoinCustomerFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleInnerJoinCustomerToJson(this);
}