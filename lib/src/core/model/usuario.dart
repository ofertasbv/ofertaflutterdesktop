import 'package:nosso/src/core/model/pessoa.dart';

class Usuario {
  int id;
  String email;
  String senha;
  String confirmaSenha;
  Pessoa pessoa;

  Usuario({this.id, this.email, this.senha, this.confirmaSenha, this.pessoa});

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    senha = json['senha'];
    confirmaSenha = json['confirmaSenha'];
    pessoa =
        json['pessoa'] != null ? new Pessoa.fromJson(json['pessoa']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['senha'] = this.senha;
    data['confirmaSenha'] = this.confirmaSenha;
    if (this.pessoa != null) {
      data['pessoa'] = this.pessoa.toJson();
    }
    return data;
  }
}
