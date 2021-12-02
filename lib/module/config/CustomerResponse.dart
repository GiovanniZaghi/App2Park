import 'package:app2park/module/park/customer/Customer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'CustomerResponse.g.dart';

@JsonSerializable()
class CustomerResponse{
  String status;
  List<Customer> data;
  String message;

  CustomerResponse({this.status, this.data, this.message});

  factory CustomerResponse.fromJson(Map<String, dynamic> json) => _$CustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);

}