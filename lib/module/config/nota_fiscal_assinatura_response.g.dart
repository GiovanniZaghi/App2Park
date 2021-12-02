// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nota_fiscal_assinatura_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotaFiscalAssinaturaResponse _$NotaFiscalAssinaturaResponseFromJson(
    Map<String, dynamic> json) {
  return NotaFiscalAssinaturaResponse(
    status: json['status'] as String,
    data: json['data'] == null
        ? null
        : NotaFiscalAssinaturaModel.fromJson(
            json['data'] as Map<String, dynamic>),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$NotaFiscalAssinaturaResponseToJson(
        NotaFiscalAssinaturaResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
