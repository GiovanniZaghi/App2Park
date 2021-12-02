import 'package:app2park/module/customers_model.dart';
import 'package:app2park/module/vehicles/vehicle_customer_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_cust_response.g.dart';

@JsonSerializable()
class VehicleCustResponse {
  String status;
  List<CustomersModel> customers;
  List<VehicleCustomerModel> vehiclecustomer;
  String message;


  VehicleCustResponse({this.status, this.customers, this.vehiclecustomer, this.message});

  factory VehicleCustResponse.fromJson(Map<String, dynamic> json) => _$VehicleCustResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleCustResponseToJson(this);
}
