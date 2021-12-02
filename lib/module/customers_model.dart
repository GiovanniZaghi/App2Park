import 'package:json_annotation/json_annotation.dart';


part 'customers_model.g.dart';

@JsonSerializable()
class CustomersModel{
  String id;
  String id_customer_app;
  String cell;
  String email;
  String name;
  String doc;
  String id_status;
  String date_added;
  String date_edited;

  CustomersModel({this.id, this.id_customer_app, this.cell, this.email,
      this.name, this.doc, this.id_status, this.date_added, this.date_edited});

  factory CustomersModel.fromJson(Map<String, dynamic> json) => _$CustomersModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomersModelToJson(this);
}