// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nota_fiscal_assinatura_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotaFiscalAssinaturaModel _$NotaFiscalAssinaturaModelFromJson(
    Map<String, dynamic> json) {
  return NotaFiscalAssinaturaModel(
    id: json['id'] as String,
    id_user: json['id_user'] as String,
    cpf: json['cpf'] as String,
    cnpj: json['cnpj'] as String,
    nome: json['nome'] as String,
    razao_social: json['razao_social'] as String,
    inscricao_municipal: json['inscricao_municipal'] as String,
    telefone: json['telefone'] as String,
    email: json['email'] as String,
    cep: json['cep'] as String,
    endereco: json['endereco'] as String,
    numero: json['numero'] as String,
    complemento: json['complemento'] as String,
    bairro: json['bairro'] as String,
    municipio: json['municipio'] as String,
    uf: json['uf'] as String,
    data_criacao: json['data_criacao'] as String,
  );
}

Map<String, dynamic> _$NotaFiscalAssinaturaModelToJson(
        NotaFiscalAssinaturaModel instance) =>
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
