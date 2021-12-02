import 'package:app2park/module/nota_fiscal_assinatura/nota_fiscal_assinatura_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nota_fiscal_assinatura_response.g.dart';

@JsonSerializable()
class NotaFiscalAssinaturaResponse{
  String status;
  NotaFiscalAssinaturaModel data;
  String message;

  NotaFiscalAssinaturaResponse({this.status, this.data, this.message});

  factory NotaFiscalAssinaturaResponse.fromJson(Map<String, dynamic> json) =>
      _$NotaFiscalAssinaturaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotaFiscalAssinaturaResponseToJson(this);
}