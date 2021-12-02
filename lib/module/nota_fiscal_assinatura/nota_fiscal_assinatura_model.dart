import 'package:json_annotation/json_annotation.dart';


part 'nota_fiscal_assinatura_model.g.dart';

@JsonSerializable()
class NotaFiscalAssinaturaModel{
  String id;
  String id_user;
  String cpf;
  String cnpj;
  String nome;
  String razao_social;
  String inscricao_municipal;
  String telefone;
  String email;
  String cep;
  String endereco;
  String numero;
  String complemento;
  String bairro;
  String municipio;
  String uf;
  String data_criacao;

  NotaFiscalAssinaturaModel(
     { this.id,
      this.id_user,
      this.cpf,
      this.cnpj,
      this.nome,
      this.razao_social,
      this.inscricao_municipal,
      this.telefone,
      this.email,
      this.cep,
      this.endereco,
      this.numero,
      this.complemento,
      this.bairro,
      this.municipio,
      this.uf,
      this.data_criacao});

  factory NotaFiscalAssinaturaModel.fromJson(Map<String, dynamic> json) => _$NotaFiscalAssinaturaModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotaFiscalAssinaturaModelToJson(this);
}