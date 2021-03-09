import 'package:nosso/src/core/model/endereco.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:nosso/src/core/model/usuario.dart';

class Pessoa {
  int id;
  String nome;
  String telefone;
  String tipoPessoa;
  // DateTime dataRegistro;
  String foto;
  List<Produto> produtos;
  Usuario usuario = new Usuario();
  List<Endereco> enderecos = List<Endereco>();

  Pessoa({
    this.id,
    this.nome,
    this.telefone,
    this.tipoPessoa,
    // this.dataRegistro,
    this.foto,
    this.produtos,
    this.usuario,
    this.enderecos,
  });

  Pessoa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    telefone = json['telefone'];
    tipoPessoa = json['tipoPessoa'];
    // dataRegistro = DateTime.tryParse(json['dataRegistro'].toString());
    foto = json['foto'];

    if (json['produtos'] != null) {
      produtos = new List<Produto>();
      json['produtos'].forEach((v) {
        produtos.add(new Produto.fromJson(v));
      });
    }

    usuario =
        json['usuario'] != null ? new Usuario.fromJson(json['usuario']) : null;

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
    data['telefone'] = this.telefone;
    data['tipoPessoa'] = this.tipoPessoa;
    // data['dataRegistro'] = this.dataRegistro.toIso8601String();
    data['foto'] = this.foto;

    if (this.produtos != null) {
      data['produtos'] = this.produtos.map((v) => v.toJson()).toList();
    }

    if (this.usuario != null) {
      data['usuario'] = this.usuario.toJson();
    }

    if (this.enderecos != null) {
      data['enderecos'] = this.enderecos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
