import 'package:nosso/src/core/enum/tipo_endereco.dart';
import 'package:nosso/src/core/model/cidade.dart';

class Endereco {
  int id;
  String logradouro;
  String numero;
  String complemento;
  String bairro;
  String cep;
  double latitude;
  double longitude;
  String tipoEndereco;
  Cidade cidade;

  Endereco(
      {this.id,
      this.logradouro,
      this.numero,
      this.complemento,
      this.bairro,
      this.cep,
      this.latitude,
      this.longitude,
      this.tipoEndereco,
      this.cidade});

  Endereco.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logradouro = json['logradouro'];
    numero = json['numero'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    cep = json['cep'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    tipoEndereco = json['tipoEndereco'];
    cidade =
        json['cidade'] != null ? new Cidade.fromJson(json['cidade']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logradouro'] = this.logradouro;
    data['numero'] = this.numero;
    data['complemento'] = this.complemento;
    data['bairro'] = this.bairro;
    data['cep'] = this.cep;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['tipoEndereco'] = this.tipoEndereco;
    if (this.cidade != null) {
      data['cidade'] = this.cidade.toJson();
    }
    return data;
  }
}
