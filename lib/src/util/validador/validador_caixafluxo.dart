class ValidadorCaixaFluxo {
  String validateDescricao(String text) {
    if (text.isEmpty) return "Preencha o descrição";
    return null;
  }

  String validateSaldoAnterior(String text) {
    double valor = double.tryParse(text);
    if (valor != null) {
      if (!text.contains(".") || text.split(".")[1].length != 2)
        return "Utilize 2 casas decimais";
    } else {
      return "Preencha o valor de saldo anterior";
    }
    return null;
  }

  String validateValorEntrada(String text) {
    double valor = double.tryParse(text);
    if (valor != null) {
      if (!text.contains(".") || text.split(".")[1].length != 2)
        return "Utilize 2 casas decimais";
    } else {
      return "Preencha o valor de entrada";
    }
    return null;
  }

  String validateValorSaida(String text) {
    double valor = double.tryParse(text);
    if (valor != null) {
      if (!text.contains(".") || text.split(".")[1].length != 2)
        return "Utilize 2 casas decimais";
    } else {
      return "Preencha o valor de saída";
    }
    return null;
  }

  String validateValorTotal(String text) {
    double valor = double.tryParse(text);
    if (valor != null) {
      if (!text.contains(".") || text.split(".")[1].length != 2)
        return "Utilize 2 casas decimais";
    } else {
      return "Preencha o valor total";
    }
    return null;
  }

  String validateDataAbertura(DateTime dataAbertura) {
    if (dataAbertura == null) {
      return "Preencha a data de abertura";
    }
    return null;
  }

  String validateDateRegsitro(DateTime dataRegistro) {
    if (dataRegistro == null) {
      return "Preencha a data registro";
    }
    return null;
  }
}
