import 'package:json_annotation/json_annotation.dart';


part 'nota_fiscal_assinatura_off_model.g.dart';

@JsonSerializable()
class NotaFiscalAssinaturaOffModel{
  int id;
  int id_user;
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

  NotaFiscalAssinaturaOffModel(
      this.id,
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
      this.data_criacao);

  factory NotaFiscalAssinaturaOffModel.fromJson(Map<String, dynamic> json) => _$NotaFiscalAssinaturaOffModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotaFiscalAssinaturaOffModelToJson(this);
}