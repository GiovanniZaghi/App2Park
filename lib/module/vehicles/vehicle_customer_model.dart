import 'package:json_annotation/json_annotation.dart';

part 'vehicle_customer_model.g.dart';

@JsonSerializable()
class VehicleCustomerModel {
  String id;
  String id_vehicle_customer_app;
  String id_customer;
  String id_customer_app;
  String id_vehicle;
  String id_vehicle_app;


  VehicleCustomerModel({this.id, this.id_vehicle_customer_app, this.id_customer,
      this.id_customer_app, this.id_vehicle, this.id_vehicle_app});

  factory VehicleCustomerModel.fromJson(Map<String, dynamic> json) => _$VehicleCustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleCustomerModelToJson(this);

  @override
  String toString() {
    return 'VehicleCustomerModel{id: $id, id_vehicle_customer_app: $id_vehicle_customer_app, id_customer: $id_customer, id_customer_app: $id_customer_app, id_vehicle: $id_vehicle, id_vehicle_app: $id_vehicle_app}';
  }
}