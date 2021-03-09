class ValidadorPDV {
  String validateCodigoBarra(String text) {
    if (text.isEmpty) return "Preencha o código de barra";
    return null;
  }

  String validateQuantidade(String text) {
    int quantidade = int.tryParse(text);
    if (quantidade != null) {
      if (quantidade <= 0) return "deve ter pelo menos um item";
    } else {
      return "Quantidade inválida";
    }
    return null;
  }

  String validateValorUnitario(String text) {
    double valorFrete = double.tryParse(text);
    if (valorFrete != null) {
      if (!text.contains(".") || text.split(".")[1].length != 2)
        return "Utilize 2 casas decimais";
    } else {
      return "Valor unitário inválido";
    }
    return null;
  }

  String validateSubTotal(String text) {
    double valorFrete = double.tryParse(text);
    if (valorFrete != null) {
      if (!text.contains(".") || text.split(".")[1].length != 2)
        return "Utilize 2 casas decimais";
    } else {
      return "SubTotal inválido";
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

  String validateDesconto(String text) {
    double desconto = double.tryParse(text);
    if (desconto != null) {
      if (!text.contains(".") || text.split(".")[1].length != 2)
        return "Utilize 2 casas decimais";
    } else {
      return "Desconto inválido";
    }
    return null;
  }

  String validateDateEntrega(DateTime dataEntrega) {
    if (dataEntrega == null) {
      return "Preencha a data entrega do pedido";
    }
    return null;
  }
}
