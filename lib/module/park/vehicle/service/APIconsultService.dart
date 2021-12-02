import 'dart:convert';
import 'dart:io';
import 'package:app2park/module/park/vehicle/APIconsult.dart';

class APIconsultService{
  static Future<APIconsult> getVehicle(String placa) async {
    try{
      HttpClient client = new HttpClient();
      client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

      String url ='https://apicarros.com/v1/consulta/$placa/json';

      HttpClientRequest request = await client.getUrl(Uri.parse(url));

      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();

      if(response.statusCode == 200){
        final r = APIconsult.fromJson(json.decode(reply));
        return r;
      }else if(response.statusCode == 400){
        // erro com proxy
        throw new Exception("Erro com Proxy");
      }else if(response.statusCode == 402){
        // sem dados na base
        throw new Exception("Sem dados na base");
      }else if(response.statusCode == 500){
        // erro interno
        throw new Exception("Erro interno");
      }

    } catch(e){
    }

  }
}