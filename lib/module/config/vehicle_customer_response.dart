import 'package:app2park/module/vehicles/vehicle_customer_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_customer_response.g.dart';

@JsonSerializable()
class VehicleCustomerResponse {
   String status;
   List<VehicleCustomerModel> data;
   String message;


   VehicleCustomerResponse({this.status, this.data, this.message});

  factory VehicleCustomerResponse.fromJson(Map<String, dynamic> json) => _$VehicleCustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleCustomerResponseToJson(this);
}
