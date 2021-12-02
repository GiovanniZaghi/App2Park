import 'package:json_annotation/json_annotation.dart';

part 'verifiy_plate_exists_model.g.dart';

@JsonSerializable()
class VerifyPlateExitsModel{
  String name;
  int id;
  int id_ticket;
  int id_ticket_historic_app;
  int id_ticket_app;
  int id_ticket_historic_status;
  int id_user;
  int id_service_additional;
  int id_service_additional_app;
  String date_time;


  VerifyPlateExitsModel(
      this.name,
      this.id,
      this.id_ticket,
      this.id_ticket_historic_app,
      this.id_ticket_app,
      this.id_ticket_historic_status,
      this.id_user,
      this.id_service_additional,
      this.id_service_additional_app,
      this.date_time);

  factory VerifyPlateExitsModel.fromJson(Map<String, dynamic> json) => _$VerifyPlateExitsModelFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyPlateExitsModelToJson(this);

  @override
  String toString() {
    return 'VerifyPlateExitsModel{name: $name, id: $id, id_ticket: $id_ticket, id_ticket_historic_app: $id_ticket_historic_app, id_ticket_app: $id_ticket_app, id_ticket_historic_status: $id_ticket_historic_status, id_user: $id_user, id_service_additional: $id_service_additional, id_service_additional_app: $id_service_additional_app, date_time: $date_time}';
  }
}