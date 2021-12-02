import 'dart:convert';

import 'package:app2park/module/config/CustomerResponse.dart';
import 'package:app2park/module/config/VehicleResponse.dart';
import 'package:app2park/module/config/vehicle_cust_response.dart';
import 'package:app2park/module/config/vehicle_type_park_response.dart';
import 'package:app2park/module/config/vehicle_type_response.dart';
import 'package:http/http.dart' as http;

import '../../../../config_dev.dart';

class VehicleService{
  static Future<VehicleResponse> getVehicle(String placa) async {
    try{
      final url = urlRequest+"api/vehicles/$placa";

      final response = await http.get(url);

      final s = response.body;

      final r = VehicleResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<VehicleCustResponse> getVehicleCust(String placa) async {
    try{
      final url = urlRequest+"api/customers/findvehiclecustomersbyplate/$placa";

      final response = await http.get(url);

      final s = response.body;

      final r = VehicleCustResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<CustomerResponse> getCustomerbyIdVehicle(String id) async {
    try{
      final url = urlRequest+"api/customers/$id";

      final response = await http.get(url);

      final s = response.body;

      final r = CustomerResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<VehicleTypeResponse> getVehicleType() async {
    try{
      final url = urlRequest+"api/vehicles/vehicletype";

      final response = await http.get(url);

      final s = response.body;

      final r = VehicleTypeResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<VehicleTypeParkResponse> getVehicleTypePark(String id_park) async {
    try{
      final url = urlRequest+"api/vehicles/allvehicletypebypark/$id_park";

      final response = await http.get(url);

      final s = response.body;

      final r = VehicleTypeParkResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<VehicleTypeParkResponse> sincVehicleTypePark(String id_park) async {
    try{
      final url = urlRequest+"api/vehicles/sincvehicletypeparkbypark/$id_park";


      final response = await http.get(url);

      final s = response.body;

      final r = VehicleTypeParkResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }
  }
}