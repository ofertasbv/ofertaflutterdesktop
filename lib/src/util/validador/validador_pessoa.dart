class ValidadorPessoa {
  String validateNome(String text) {
    if (text.isEmpty) return "Preencha o nome";
    return null;
  }

  String validateTelefone(String text) {
    if (text.isEmpty) return "Preencha o telefone";
    return null;
  }

  String validateCpf(String text) {
    if (text.isEmpty) return "Preencha o cpf";
    return null;
  }

  String validateCnpj(String text) {
    if (text.isEmpty) return "Preencha o cnpj";
    return null;
  }

  String validateDateRegsitro(DateTime dataRegistro) {
    if (dataRegistro == null) {
      return "Preencha a data registro";
    }
    return null;
  }

  String validateEmail(String text) {
    if (text.isEmpty) {
      return "preencha o valor com email";
    }
    if (!text.contains("@")) {
      return "email inválido";
    }
  }

  String validateSenha(String text) {
    if (text.isEmpty) {
      return "preencha o valor com senha";
    }
    if (text.length < 4) {
      return "a senha deve ter 4 caracteres";
    }
  }
}
