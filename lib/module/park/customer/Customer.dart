import 'package:json_annotation/json_annotation.dart';

part 'Customer.g.dart';

@JsonSerializable()
class Customer{
  String id;
  String id_customer_app;
  String cell;
  String email;
  String name;
  String doc;
  String id_status;
  String date_added;
  String date_edited;


  Customer({this.id, this.id_customer_app, this.cell, this.email, this.name,
      this.doc, this.id_status, this.date_added, this.date_edited});

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}