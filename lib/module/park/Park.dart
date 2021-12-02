import 'package:json_annotation/json_annotation.dart';

part 'Park.g.dart';

@JsonSerializable()
class Park {
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


  Park({
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
      this.date_edited});

  factory Park.fromJson(Map<String, dynamic> json) => _$ParkFromJson(json);

  Map<String, dynamic> toJson() => _$ParkToJson(this);

  @override
  String toString() {
    return 'Park{id: $id, type: $type, doc: $doc, name_park: $name_park, business_name: $business_name, cell: $cell, photo: $photo, postal_code: $postal_code, street: $street, number: $number, complement: $complement, neighborhood: $neighborhood, city: $city, state: $state, country: $country, vacancy: $vacancy, subscription: $subscription, id_status: $id_status, date_added: $date_added, date_edited: $date_edited}';
  }
}
