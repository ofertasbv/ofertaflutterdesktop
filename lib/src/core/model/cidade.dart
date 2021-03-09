import 'package:nosso/src/core/model/endereco.dart';
import 'package:nosso/src/core/model/estado.dart';

class Cidade {
  int id;
  String nome;
  Estado estado;
  List<Endereco> enderecos;

  Cidade({this.id, this.nome, this.estado, this.enderecos});

  Cidade.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    estado =
        json['estado'] != null ? new Estado.fromJson(json['estado']) : null;
    if (json['enderecos'] != null) {
      enderecos = new List<Endereco>();
      json['enderecos'].forEach((v) {
        enderecos.add(new Endereco.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    if (this.estado != null) {
      data['estado'] = this.estado.toJson();
    }
    if (this.enderecos != null) {
      data['enderecos'] = this.enderecos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
