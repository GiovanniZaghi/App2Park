import 'package:json_annotation/json_annotation.dart';

part 'customers_off_model.g.dart';

@JsonSerializable()
class CustomersOffModel{
  int id;
  int id_customer_app;
  String cell;
  String email;
  String name;
  String doc;
  int id_status;

  CustomersOffModel(this.id, this.cell, this.email,
      this.name, this.doc, this.id_status);

  factory CustomersOffModel.fromJson(Map<String, dynamic> json) => _$CustomersOffModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomersOffModelToJson(this);

  @override
  String toString() {
    return 'CustomersOffModel{id: $id, id_customer_app: $id_customer_app, cell: $cell, email: $email, name: $name, doc: $doc, id_status: $id_status}';
  }
}