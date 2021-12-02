import 'package:app2park/module/park/customer/Customer.dart';
import 'package:app2park/module/park/ticket/Ticket.dart';
import 'package:app2park/module/park/ticket/ticket_historic_model.dart';
import 'package:app2park/module/park/ticket/ticket_historic_photo_model.dart';
import 'package:app2park/module/park/ticket/ticket_object_model.dart';
import 'package:app2park/module/park/ticket/ticket_service_additional_model.dart';
import 'package:app2park/module/park/vehicle/Vehicle.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket_sinc_all_response.g.dart';

@JsonSerializable()
class TicketSincAllResponse{
  String status;
  String message;
  List<Ticket> tickets;
  List<TicketHistoricModel> ticket_historic;
  List<TicketObjectModel> ticket_object;
  List<TicketServiceAdditionalModel> ticket_service_additional;
  List<TicketHistoricPhotoModel> ticket_historic_photo;
  List<Vehicle> tickets_vehicle;
  List<Customer> tickets_customers;


  TicketSincAllResponse(
      {this.status,
      this.message,
      this.tickets,
      this.ticket_historic,
      this.ticket_object,
      this.ticket_service_additional,
      this.ticket_historic_photo,
      this.tickets_vehicle,
      this.tickets_customers});

  factory TicketSincAllResponse.fromJson(Map<String, dynamic> json) =>
      _$TicketSincAllResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TicketSincAllResponseToJson(this);
}