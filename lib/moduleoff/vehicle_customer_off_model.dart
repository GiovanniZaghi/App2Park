import 'package:json_annotation/json_annotation.dart';

part 'vehicle_customer_off_model.g.dart';

@JsonSerializable()
class VehicleCustomerOffModel{
  int id;
  int id_vehicle_customer_app;
  int id_customer;
  int id_customer_app;
  int id_vehicle;
  int id_vehicle_app;

  VehicleCustomerOffModel(
      this.id,
      this.id_customer,
      this.id_customer_app,
      this.id_vehicle,
      this.id_vehicle_app);

  factory VehicleCustomerOffModel.fromJson(Map<String, dynamic> json) => _$VehicleCustomerOffModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleCustomerOffModelToJson(this);
}