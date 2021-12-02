import 'package:json_annotation/json_annotation.dart';

part 'park_user_off_model.g.dart';

@JsonSerializable()
class ParkUserOff {
  int id;
  int id_park;
  int id_user;
  int id_office;
  int id_status;
  String keyval;
  String date_added;
  String date_edited;


  ParkUserOff(this.id, this.id_park, this.id_user, this.id_office,
      this.id_status, this.keyval, this.date_added, this.date_edited);

  factory ParkUserOff.fromJson(Map<String, dynamic> json) =>
      _$ParkUserOffFromJson(json);

  Map<String, dynamic> toJson() => _$ParkUserOffToJson(this);
}
