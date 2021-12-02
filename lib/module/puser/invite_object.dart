import 'package:json_annotation/json_annotation.dart';

part 'invite_object.g.dart';

@JsonSerializable()
class InviteObject {
  String email;
  String id_park;
  String id_office;
  String cell;
  String first_name;
  String id_user;


  InviteObject(
      {this.email, this.id_park, this.id_office, this.cell, this.first_name, this.id_user});

  factory InviteObject.fromJson(Map<String, dynamic> json) =>
      _$InviteObjectFromJson(json);

  Map<String, dynamic> toJson() => _$InviteObjectToJson(this);
}
