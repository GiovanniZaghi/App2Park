import 'package:json_annotation/json_annotation.dart';

part 'park_off_join.g.dart';

@JsonSerializable()
class ParkOffJoin{
  String id;
  String type;
  String doc;
  String name_park;
  String business_name;
  String cell;
  String photo;
  String postal_code;
  String street;
  String number;
  String complement;
  String neighborhood;
  String city;
  String state;
  String country;
  String vacancy;
  String subscription;
  String id_status;
  String date_added;
  String date_edited;
  int tickado;


  ParkOffJoin(
      this.id,
      this.type,
      this.doc,
      this.name_park,
      this.business_name,
      this.cell,
      this.photo,
      this.postal_code,
      this.street,
      this.number,
      this.complement,
      this.neighborhood,
      this.city,
      this.state,
      this.country,
      this.vacancy,
      this.subscription,
      this.id_status,
      this.date_added,
      this.date_edited,
      this.tickado);


  factory ParkOffJoin.fromJson(Map<String, dynamic> json) => _$ParkOffJoinFromJson(json);

  Map<String, dynamic> toJson() => _$ParkOffJoinToJson(this);

  @override
  String toString() {
    return 'ParkOffJoin{id: $id, type: $type, doc: $doc, name_park: $name_park, business_name: $business_name, cell: $cell, photo: $photo, postal_code: $postal_code, street: $street, number: $number, complement: $complement, neighborhood: $neighborhood, city: $city, state: $state, country: $country, vacancy: $vacancy, subscription: $subscription, id_status: $id_status, date_added: $date_added, date_edited: $date_edited, tickado: $tickado}';
  }
}
