import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/cart/cart_off_model.dart';
import 'package:app2park/moduleoff/nota_fiscal_assinatura/nota_fiscal_assinatura_off_model.dart';
import 'package:sqflite/sqflite.dart';

class NotaFiscalAssinaturaDao {

  static const String _tableNotaFiscalAssinatura = 'nota_fiscal_assinatura';
  static const String tableNotaFiscalAssinatura = 'CREATE TABLE $_tableNotaFiscalAssinatura('
      '$_id INTEGER, '
      '$_id_user INTEGER, '
      '$_cpf TEXT NULL, '
      '$_cnpj TEXT NULL, '
      '$_nome TEXT NULL, '
      '$_razao_social TEXT NULL, '
      '$_inscricao_municipal TEXT NULL, '
      '$_telefone TEXT, '
      '$_email TEXT, '
      '$_cep TEXT, '
      '$_endereco TEXT, '
      '$_numero TEXT, '
      '$_complemento TEXT NULL, '
      '$_bairro TEXT, '
      '$_municipio TEXT, '
      '$_uf TEXT, '
      '$_data_criacao TEXT);';

  static const String _id = 'id';
  static const String _id_user = 'id_user';
  static const String _cpf = 'cpf';
  static const String _cnpj= 'cnpj';
  static const String _nome = 'nome';
  static const String _razao_social = 'razao_social';
  static const String _inscricao_municipal= 'inscricao_municipal';
  static const String _telefone = 'telefone';
  static const String _email = 'email';
  static const String _cep= 'cep';
  static const String _endereco = 'endereco';
  static const String _numero = 'numero';
  static const String _complemento = 'complemento';
  static const String _bairro = 'bairro';
  static const String _municipio = 'municipio';
  static const String _uf = 'uf';
  static const String _data_criacao= 'data_criacao';

  Future<int> saveNotaFiscalAssinaturaOffModel(NotaFiscalAssinaturaOffModel notaFiscalAssinaturaOffModel) async {
    final Database db = await getDatabase();
    Map<String, dynamic> customersMap = _toMapNotaFiscalAssinaturaOffModel(notaFiscalAssinaturaOffModel);
    return db.insert(_tableNotaFiscalAssinatura, customersMap);
  }

  Future<NotaFiscalAssinaturaOffModel> getNotaFiscalAssinaturaOffModelById(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableNotaFiscalAssinatura,
        columns: [ _id, _id_user, _cpf, _cnpj, _nome, _razao_social, _inscricao_municipal, _telefone, _email, _cep, _endereco, _numero, _complemento, _bairro, _municipio, _uf, _data_criacao],
        where: 'id = ?',
        whereArgs: [id]);

    if (result.length > 0) {
      return new NotaFiscalAssinaturaOffModel.fromJson(result.first);
    }
    return null;
  }

  Future<List<NotaFiscalAssinaturaOffModel>> findAllNotaFiscalAssinaturaOffModel() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableNotaFiscalAssinatura);
    List<NotaFiscalAssinaturaOffModel> NotaFiscalAssinaturaOffModelList = _toListNotaFiscalAssinaturaOffModel(result);
    return NotaFiscalAssinaturaOffModelList;
  }

  Future<bool> verifyNotaFiscalAssinaturaOffModel(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableNotaFiscalAssinatura,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }


  Map<String, dynamic> _toMapNotaFiscalAssinaturaOffModel(NotaFiscalAssinaturaOffModel notaFiscalAssinaturaOffModel) {
    final Map<String, dynamic> notaFiscalAssinaturaOffModelMap = Map();
    notaFiscalAssinaturaOffModelMap['id'] = notaFiscalAssinaturaOffModel.id;
    notaFiscalAssinaturaOffModelMap['cpf'] = notaFiscalAssinaturaOffModel.cpf;
    notaFiscalAssinaturaOffModelMap['cnpj'] = notaFiscalAssinaturaOffModel.cnpj;
    notaFiscalAssinaturaOffModelMap['nome'] = notaFiscalAssinaturaOffModel.nome;
    notaFiscalAssinaturaOffModelMap['razao_social'] = notaFiscalAssinaturaOffModel.razao_social;
    notaFiscalAssinaturaOffModelMap['inscricao_municipal'] = notaFiscalAssinaturaOffModel.inscricao_municipal;
    notaFiscalAssinaturaOffModelMap['telefone'] = notaFiscalAssinaturaOffModel.telefone;
    notaFiscalAssinaturaOffModelMap['email'] = notaFiscalAssinaturaOffModel.email;
    notaFiscalAssinaturaOffModelMap['cep'] = notaFiscalAssinaturaOffModel.cep;
    notaFiscalAssinaturaOffModelMap['endereco'] = notaFiscalAssinaturaOffModel.endereco;
    notaFiscalAssinaturaOffModelMap['numero'] = notaFiscalAssinaturaOffModel.numero;
    notaFiscalAssinaturaOffModelMap['complemento'] = notaFiscalAssinaturaOffModel.complemento;
    notaFiscalAssinaturaOffModelMap['bairro'] = notaFiscalAssinaturaOffModel.bairro;
    notaFiscalAssinaturaOffModelMap['municipio'] = notaFiscalAssinaturaOffModel.municipio;
    notaFiscalAssinaturaOffModelMap['uf'] = notaFiscalAssinaturaOffModel.uf;
    notaFiscalAssinaturaOffModelMap['data_criacao'] = notaFiscalAssinaturaOffModel.data_criacao;
    return notaFiscalAssinaturaOffModelMap;
  }

  List<NotaFiscalAssinaturaOffModel> _toListNotaFiscalAssinaturaOffModel(List<Map<String, dynamic>> result) {
    final List<NotaFiscalAssinaturaOffModel> notaFiscalOffList = List();
    for (Map<String, dynamic> row in result) {
      final NotaFiscalAssinaturaOffModel notaFiscalAssinaturaOffModel = NotaFiscalAssinaturaOffModel(
          row['id'],
          row['id_user'],
          row['cpf'],
          row['cnpj'],
          row['nome'],
          row['razao_social'],
          row['inscricao_municipal'],
          row['telefone '],
          row['email'],
          row['cep'],
          row['endereco'],
          row['numero'],
          row['complemento'],
          row['bairro'],
          row['municipio'],
          row['uf'],
          row['data_criacao']
      );
      notaFiscalOffList.add(notaFiscalAssinaturaOffModel);
    }
    return notaFiscalOffList;
  }
}