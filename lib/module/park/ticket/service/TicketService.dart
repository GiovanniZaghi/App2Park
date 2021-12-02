import 'dart:convert';
import 'package:app2park/module/config/TicketResponse.dart';
import 'package:app2park/module/config/ticket_historic_response.dart';
import 'package:app2park/module/config/ticket_historic_status_response.dart';
import 'package:app2park/module/config/ticket_object_response.dart';
import 'package:app2park/module/config/ticket_online_response.dart';
import 'package:app2park/module/config/ticket_service_additional_response.dart';
import 'package:app2park/module/config/ticket_sinc_all_response.dart';
import 'package:app2park/module/config/ticket_sinc_response.dart';
import 'package:app2park/module/park/ticket/Ticket.dart';
import 'package:app2park/module/park/ticket/send_ticket_model.dart';
import 'package:app2park/module/park/ticket/ticket_historic_model.dart';
import 'package:app2park/module/park/ticket/ticket_object_model.dart';
import 'package:app2park/module/park/ticket/ticket_service_additional_model.dart';
import 'package:app2park/module/sinc_model.dart';
import 'package:http/http.dart' as http;

import '../../../../config_dev.dart';

class TicketService{
  static Future<TicketResponse> createTicketOn(Ticket ticket) async {
    try {
      final url = urlRequest+"api/tickets/new";

      final headers = {"Content-Type": "application/json"};
      final body = json.encode(ticket.toJson());

      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = TicketResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
    }
  }

  static Future<TicketResponse> updateTicketOn(Ticket ticket, int id) async {
    try {
      final url = urlRequest+"api/tickets/update/$id";

      final headers = {"Content-Type": "application/json"};
      final body = json.encode(ticket.toJson());

      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = TicketResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
    }
  }

  static Future<TicketHistoricResponse> createTicketHistoric(TicketHistoricModel ticketHistoric) async {
    try {
      final url = urlRequest+"api/tickets/newtickethistoric";

      final headers = {"Content-Type": "application/json"};
      final body = json.encode(ticketHistoric.toJson());

      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = TicketHistoricResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
    }
  }

  static Future<TicketHistoricStatusResponse> getTicketHistoricStatus() async {
    try {
      final url = urlRequest+"api/tickets/getalltickethistoricstatus";

      final response = await http.get(url);

      final s = response.body;

      final r = TicketHistoricStatusResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
    }
  }

  static Future<TicketObjectResponse> createTicketObject(TicketObjectModel ticketObject) async {
    try {
      final url = urlRequest+"api/tickets/newticketobject";

      final headers = {"Content-Type": "application/json"};
      final body = json.encode(ticketObject.toJson());

      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = TicketObjectResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
    }
  }

  static Future<TicketServiceAdditionalResponse> createTicketServiceAdditional(TicketServiceAdditionalModel ticketServiceAdditional) async {
    try {
      final url = urlRequest+"api/tickets/newticketserviceadditional";

      final headers = {"Content-Type": "application/json"};
      final body = json.encode(ticketServiceAdditional.toJson());

      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = TicketServiceAdditionalResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
    }
  }

  static Future<TicketOnlineResponse> SendTicket(SendTicketModelModel sendTicketModel) async {
    try {
      final url = urlRequest+"api/tickets/sendticket";

      final headers = {"Content-Type": "application/json"};
      final body = json.encode(sendTicketModel.toJson());


      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = TicketOnlineResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
    }
  }

  static Future<TicketSincResponse> getAllTicketsOpenSinc(SincModel sincModel) async {
    try {
      final url = urlRequest+"api/tickets/getallticketsopen";

      final headers = {"Content-Type": "application/json"};
      final body = json.encode(sincModel.toJson());

      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = TicketSincResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {

    }
  }

  static Future<TicketSincAllResponse> getTicketInfoSinc(String id_ticket) async {
    try{
      final url = urlRequest+"api/tickets/getallinformationticket/$id_ticket";

      final response = await http.get(url);

      final s = response.body;

      final r = TicketSincAllResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }
}