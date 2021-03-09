class ValidadorCartao {
  String validateNome(String text) {
    if (text.isEmpty) return "Preencha o nome completo";
    return null;
  }

  String validateNumeroCartao(String text) {
    if (text.isEmpty) return "Preencha o número do cartão";
    return null;
  }

  String validateNumeroSeguranca(String text) {
    if (text.isEmpty) return "Preencha o código de segurança do cartão";
    return null;
  }

  String validateDataValidade(DateTime dataValidade) {
    if (dataValidade == null) {
      return "Preencha a data de validade";
    }
    return null;
  }
}
