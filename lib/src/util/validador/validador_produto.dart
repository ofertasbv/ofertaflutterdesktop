class ValidadorProduto {
  String validateImages(List images) {
    if (images.isEmpty) return "Adicione imagens do produto";
    return null;
  }

  String validateNome(String text) {
    if (text.isEmpty) return "Preencha o nome";
    return null;
  }

  String validateCodigoBarra(String text) {
    if (text.isEmpty) return "Preencha o código de barra";
    return null;
  }

  String validateSKU(String text) {
    if (text.isEmpty) return "Preencha o SKU";
    return null;
  }

  String validateDescricao(String text) {
    if (text.isEmpty) return "Preencha a descrição";
    return null;
  }

  String validateQuantidade(String text) {
    int quantidade = int.tryParse(text);
    if (quantidade != null) {
      if (quantidade <= 0) return "Deve ter pelo menos 1 estoque";
    } else {
      return "Preencha a quantidade";
    }
    return null;
  }

  String validateValorUnitario(String text) {
    double price = double.tryParse(text);
    if (price != null) {
      if (!text.contains(".") || text.split(".")[1].length != 2)
        return "Utilize 2 casas decimais";
    } else {
      return "Preencha o valor unitário";
    }
    return null;
  }

  String validateValorVenda(String text) {
    double price = double.tryParse(text);
    if (price != null) {
      if (!text.contains(".") || text.split(".")[1].length != 2)
        return "Utilize 2 casas decimais";
    } else {
      return "Preencha o valor de venda";
    }
    return null;
  }

  String validatePercentual(String text) {
    double price = double.tryParse(text);
    if (price != null) {
      if (!text.contains(".") || text.split(".")[1].length != 2)
        return "Utilize 2 casas decimais";
    } else {
      return "Preencha o percentual de venda";
    }
    return null;
  }

  String validateDateRegistro(DateTime dataRegistro) {
    if (dataRegistro == null) {
      return "Preencha a data de registro";
    }
    return null;
  }

  String validateDateFabricacao(DateTime dataFabricacao) {
    if (dataFabricacao == null) {
      return "Preencha a data de Fabricaçao";
    }
    return null;
  }

  String validateDateVencimento(DateTime dataRegistro) {
    if (dataRegistro == null) {
      return "Preencha a data de vencimento";
    }
    return null;
  }
}
