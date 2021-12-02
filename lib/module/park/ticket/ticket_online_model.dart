import 'package:json_annotation/json_annotation.dart';

part 'ticket_online_model.g.dart';

@JsonSerializable()
class TicketOnlineModel{
  String id;
  String id_cupom;
  String plate;
  String color;
  String year;
  String maker;
  String model;
  String cupom_entrance_datetime;
  String name_park;
  String doc;
  String postal_code;
  String street;
  String number;
  String city;
  String state;
  String neighborhood;
  String cell;
  String first_name;
  String last_name;
  String id_customer;
  String email;
  String cell_customer;
  String nome_customer;


  TicketOnlineModel({
      this.id,
      this.id_cupom,
      this.plate,
      this.color,
      this.year,
      this.maker,
      this.model,
      this.cupom_entrance_datetime,
      this.name_park,
      this.doc,
      this.postal_code,
      this.street,
      this.number,
      this.city,
      this.state,
      this.neighborhood,
      this.cell,
      this.first_name,
      this.last_name,
      this.id_customer,
      this.email,
      this.cell_customer,
      this.nome_customer});

  factory TicketOnlineModel.fromJson(Map<String, dynamic> json) => _$TicketOnlineModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketOnlineModelToJson(this);

  @override
  String toString() {
    return 'TicketOnlineModel{id: $id, id_cupom: $id_cupom, plate: $plate, color: $color, year: $year, maker: $maker, model: $model, cupom_entrance_datetime: $cupom_entrance_datetime, name_park: $name_park, doc: $doc, postal_code: $postal_code, street: $street, number: $number, city: $city, state: $state, first_name: $first_name, last_name: $last_name, cell: $cell, id_customer: $id_customer, email: $email, cell_customer: $cell_customer, nome_customer: $nome_customer}';
  }
}