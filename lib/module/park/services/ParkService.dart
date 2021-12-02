import 'dart:convert';

import 'package:app2park/module/agreement/agreement_model.dart';
import 'package:app2park/module/config/CustomerResponse.dart';
import 'package:app2park/module/config/ParkResponse.dart';
import 'package:app2park/module/config/ParkResponseGet.dart';
import 'package:app2park/module/config/ParkUserResponse.dart';
import 'package:app2park/module/config/agreement_list_response.dart';
import 'package:app2park/module/config/agreement_response.dart';
import 'package:app2park/module/config/park_list_response.dart';
import 'package:app2park/module/config/park_service_additional_response.dart';
import 'package:app2park/module/config/park_user_invite_response.dart';
import 'package:app2park/module/config/payment_method_park_response.dart';
import 'package:app2park/module/config/subscription_update_response.dart';
import 'package:app2park/module/config/user_list_response.dart';
import 'package:app2park/module/config/vehicle_customer_response.dart';
import 'package:app2park/module/config/vehicle_type_park_response.dart';
import 'package:app2park/module/config/version_response.dart';
import 'package:app2park/module/park/customer/Customer.dart';
import 'package:app2park/module/park/parkjwt/ParkJwt.dart';
import 'package:app2park/module/park/payments/payment_method_park_model.dart';
import 'package:app2park/module/park/vehicle/vehicle_type_park_model.dart';
import 'package:app2park/module/park_service_additional.dart';
import 'package:app2park/module/puser/invite_object.dart';
import 'package:app2park/module/puser/park_user_model.dart';
import 'package:app2park/module/vehicles/vehicle_customer_model.dart';
import 'package:http/http.dart' as http;

import '../../../config_dev.dart';


class ParkService{

  static Future<ParkResponse> save(ParkJwt park) async {
    try{
      final url = urlRequest+"api/parks/new";

      final headers = {"Content-Type":"application/json"};
      final body = json.encode(park.toJson());


      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = ParkResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<ParkUserInviteResponse> invite(InviteObject invite) async {
    try{
      final url = urlRequest+"api/puser/invite";

      final headers = {"Content-Type":"application/json"};
      final body = json.encode(invite.toJson());


      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = ParkUserInviteResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<ParkResponseGet> getPark(String id, String jwt) async {
    try{
      final url = urlRequest+"api/parks/$id?jwt=$jwt";

      final response = await http.get(url);

      final s = response.body;

      final r = ParkResponseGet.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<CustomerResponse> insertCustomer(Customer customer) async {
    try{
      final url = urlRequest+"api/customers/new";

      final headers = {"Content-Type":"application/json"};
      final body = json.encode(customer.toJson());


      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = CustomerResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<VehicleCustomerResponse> insertVehicleCustomer(VehicleCustomerModel customer) async {
    try{
      final url = urlRequest+"api/customers/newvehiclecustomer";

      final headers = {"Content-Type":"application/json"};
      final body = json.encode(customer.toJson());


      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = VehicleCustomerResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<ParkServiceAdditionalResponse> getParkServiceAdditional(String id) async {
    try{
      final url = urlRequest+"api/parks/getserviceparkbyidpark/$id";

      final response = await http.get(url);

      final s = response.body;

      final r = ParkServiceAdditionalResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<VehicleTypeParkResponse>updateVehicleTypePark (String id, VehicleTypeParkModel vehicleTypeParkModel) async {
    try{
      final url = urlRequest+"api/vehicles/updatevehicletypepark/$id";

      final headers = {"Content-Type":"application/json"};
      final body = json.encode(vehicleTypeParkModel.toJson());


      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = VehicleTypeParkResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<ParkServiceAdditionalResponse>updateParkServiceAdditional (String id, ParkServiceAdditional parkServiceAdditional) async {
    try{
      final url = urlRequest+"api/parks/updateservicepark/$id";

      final headers = {"Content-Type":"application/json"};
      final body = json.encode(parkServiceAdditional.toJson());


      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = ParkServiceAdditionalResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<PaymentMethodParkResponse>updatePaymentsMethodPark (String id, PaymentMethodParkModel paymentMethodParkModel) async {
    try{
      final url = urlRequest+"api/payments/updatepaymentmethodpark/$id";

      final headers = {"Content-Type":"application/json"};
      final body = json.encode(paymentMethodParkModel.toJson());


      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = PaymentMethodParkResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<AgreementResponse> saveAgreement(Agreements agreement) async {
    try{
      final url = urlRequest+"api/agreements/newagreement";

      final headers = {"Content-Type":"application/json"};
      final body = json.encode(agreement.toJson());



      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = AgreementResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<AgreementResponse>updateAgreement (String id, Agreements agreements) async {
    try{
      final url = urlRequest+"api/agreements/editagreement/$id";

      final headers = {"Content-Type":"application/json"};
      final body = json.encode(agreements.toJson());


      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = AgreementResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<ParkListResponse> sincParksIdUser(ParkUser parkUser) async {
    try{
      final url = urlRequest+"api/parks/sincparksbyiduser";

      final headers = {"Content-Type":"application/json"};
      final body = json.encode(parkUser.toJson());


      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = ParkListResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }
  }

  static Future<ParkUserResponse> sincParkUserIdParkIdUser(ParkUser parkUser) async {
    try{
      final url = urlRequest+"api/parks/sincparkuserbyidparkiduser";

      final headers = {"Content-Type":"application/json"};
      final body = json.encode(parkUser.toJson());


      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;


      final r = ParkUserResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<UserListResponse> sincUserParkUserByIdPark(ParkUser parkUser) async {
    try{
      final url = urlRequest+"api/parks/sincuserparkuserbyidpark";

      final headers = {"Content-Type":"application/json"};
      final body = json.encode(parkUser.toJson());


      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = UserListResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }
  }

  static Future<ParkServiceAdditionalResponse> sincParkServiceAdditional(String id) async {
    try{
      final url = urlRequest+"api/services/sincparkserviceadditional/$id";

      final response = await http.get(url);

      final s = response.body;

      final r = ParkServiceAdditionalResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<AgreementListResponse> sincAgreement(String id_user) async {
    try{
      final url = urlRequest+"api/agreements/sincagreementbyiduser/$id_user";

      final response = await http.get(url);

      final s = response.body;

      final r = AgreementListResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<VersionResponse> Version() async {
    try{
      final url = urlRequest+"api/version/getversion";


      final response = await http.get(url);

      final s = response.body;

      final r = VersionResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<SubscriptionUpdateResponse> subscriptionUpdate(String id_user) async {
    try{
      final url = urlRequest+"api/parks/allparksbyuser/$id_user";
      final response = await http.get(url);

      final s = response.body;

      final r = SubscriptionUpdateResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

}