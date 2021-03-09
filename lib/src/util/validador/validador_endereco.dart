class ValidadorEndereco {
  String validateLogradouro(String text) {
    if (text.isEmpty) return "Preencha o logradouro";
    return null;
  }

  String validateComplemento(String text) {
    if (text.isEmpty) return "Preencha o complemento";
    return null;
  }

  String validateNumero(String text) {
    if (text.isEmpty) return "Preencha o número";
    return null;
  }

  String validateCep(String text) {
    if (text.isEmpty) return "Preencha o cep";
    return null;
  }

  String validateBairro(String text) {
    if (text.isEmpty) return "Preencha o bairro";
    return null;
  }

  String validateLatitude(String text) {
    if (text.isEmpty) return "Preencha o latitude";
    return null;
  }

  String validateLongitude(String text) {
    if (text.isEmpty) return "Preencha o longitude";
    return null;
  }
}
