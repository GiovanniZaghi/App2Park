import 'package:json_annotation/json_annotation.dart';

part 'invite_object_select.g.dart';

@JsonSerializable()
class InviteObjectSelect {
  int id;
  int id_office;
  int id_user;
  int id_park;
  int id_status;
  String cell;
  String email;
  String first_name;
  String last_name;
  String office;

  InviteObjectSelect(this.id, this.id_office, this.id_user, this.id_park,
      this.id_status, this.cell, this.email, this.first_name, this.last_name, this.office);

  factory InviteObjectSelect.fromJson(Map<String, dynamic> json) =>
      _$InviteObjectSelectFromJson(json);

  Map<String, dynamic> toJson() => _$InviteObjectSelectToJson(this);
}
