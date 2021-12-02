import 'package:json_annotation/json_annotation.dart';

part 'ParkJwt.g.dart';

@JsonSerializable()
class ParkJwt {
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
  String jwt;
  String date_added;
  String id_user;


  ParkJwt({
      this.id,
      this.type,
      this.doc,
      this.name_park,
      this.business_name,
      this.cell,
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
      this.jwt,
      this.date_added,
      this.id_user});

  factory ParkJwt.fromJson(Map<String, dynamic> json) =>
      _$ParkJwtFromJson(json);


  @override
  String toString() {
    return 'ParkJwt{id: $id, type: $type, name_park: $name_park, doc: $doc, business_name: $business_name, cell: $cell, postal_code: $postal_code, street: $street, number: $number, complement: $complement, neighborhood: $neighborhood, city: $city, state: $state, country: $country, vacancy: $vacancy, subscription: $subscription, id_status: $id_status, jwt: $jwt, date_added: $date_added, id_user: $id_user}';
  }

  Map<String, dynamic> toJson() => _$ParkJwtToJson(this);
}
