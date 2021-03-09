class ValidadorPromocao {
  String validateImages(List images) {
    if (images.isEmpty) return "Adicione imagens da promoção";
    return null;
  }

  String validateNome(String text) {
    if (text.isEmpty) return "Preencha o nome da promoção";
    return null;
  }

  String validateDescricao(String text) {
    if (text.isEmpty) return "Preencha a descrição da promoção";
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

  String validateDateRegsitro(DateTime dataRegistro) {
    if (dataRegistro == null) {
      return "Preencha a data registro da promoção";
    }
    return null;
  }

  String validateDateInicio(DateTime dataInicio) {
    if (dataInicio == null) {
      return "Preencha a data início da promoção";
    }
    if (dataInicio.isBefore(new DateTime.now())) {
      return "Data deve ser acima de hoje";
    }
    return null;
  }

  String validateDateFinal(DateTime dataFinal) {
    if (dataFinal == null) {
      return "Preencha a data final da promoção";
    }
    if (dataFinal.isBefore(new DateTime.now())) {
      return "Data deve ser acima de hoje";
    }
    return null;
  }
}
