import 'package:json_annotation/json_annotation.dart';

part 'park_user_model.g.dart';

@JsonSerializable()
class ParkUser {
  String id;
  String id_park;
  String id_user;
  String id_office;
  String id_status;
  String keyval;
  String date_added;
  String date_edited;


  ParkUser({this.id, this.id_park, this.id_user, this.id_office, this.id_status,
      this.keyval, this.date_added, this.date_edited});

  factory ParkUser.fromJson(Map<String, dynamic> json) =>
      _$ParkUserFromJson(json);

  Map<String, dynamic> toJson() => _$ParkUserToJson(this);
}
