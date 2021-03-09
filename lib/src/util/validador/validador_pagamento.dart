class ValidadorPagamento {
  String validateQuantidade(String text) {
    int quantidade = int.tryParse(text);
    if (quantidade != null) {
      if (quantidade <= 0) return "deve ter pelo menos um item";
    } else {
      return "Quantidade inválida";
    }
    return null;
  }

  String validateValorTotal(String text) {
    double valorTotal = double.tryParse(text);
    if (valorTotal != null) {
      if (!text.contains(".") || text.split(".")[1].length != 2)
        return "Utilize 2 casas decimais";
    } else {
      return "Valor total inválido";
    }
    return null;
  }

  String validateDataPagamento(DateTime dataPagamento) {
    if (dataPagamento == null) {
      return "Preencha a data de pagamento";
    }
    return null;
  }
}
