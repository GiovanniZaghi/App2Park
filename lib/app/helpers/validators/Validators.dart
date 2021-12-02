import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:validators/validators.dart';

bool validaCpf(documento) {
  return CPFValidator.isValid(documento);
}

bool validaCnpj(documento) {
  return CNPJValidator.isValid(documento);
}

validaEmail(String email) {
  return isEmail(email);
}

isNull(String str) {
  return isNull(str);
}
