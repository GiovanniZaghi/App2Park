import 'package:json_annotation/json_annotation.dart';


class FormPaymentOff{
  int id_park;
  int taxa_fixa;
  int taxa_variavel;
  int valor_minimo;
  String ordem;
  String id_status;

  FormPaymentOff(this.id_park, this.taxa_fixa, this.taxa_variavel,
      this.valor_minimo, this.ordem, this.id_status);




}