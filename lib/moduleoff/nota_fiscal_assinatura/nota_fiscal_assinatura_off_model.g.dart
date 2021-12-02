// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nota_fiscal_assinatura_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotaFiscalAssinaturaOffModel _$NotaFiscalAssinaturaOffModelFromJson(
    Map<String, dynamic> json) {
  return NotaFiscalAssinaturaOffModel(
    json['id'] as int,
    json['id_user'] as int,
    json['cpf'] as String,
    json['cnpj'] as String,
    json['nome'] as String,
    json['razao_social'] as String,
    json['inscricao_municipal'] as String,
    json['telefone'] as String,
    json['email'] as String,
    json['cep'] as String,
    json['endereco'] as String,
    json['numero'] as String,
    json['complemento'] as String,
    json['bairro'] as String,
    json['municipio'] as String,
    json['uf'] as String,
    json['data_criacao'] as String,
  );
}

Map<String, dynamic> _$NotaFiscalAssinaturaOffModelToJson(
        NotaFiscalAssinaturaOffModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_user': instance.id_user,
      'cpf': instance.cpf,
      'cnpj': instance.cnpj,
      'nome': instance.nome,
      'razao_social': instance.razao_social,
      'inscricao_municipal': instance.inscricao_municipal,
      'telefone': instance.telefone,
      'email': instance.email,
      'cep': instance.cep,
      'endereco': instance.endereco,
      'numero': instance.numero,
      'complemento': instance.complemento,
      'bairro': instance.bairro,
      'municipio': instance.municipio,
      'uf': instance.uf,
      'data_criacao': instance.data_criacao,
    };
