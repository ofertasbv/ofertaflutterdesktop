import 'package:nosso/src/core/model/cliente.dart';
import 'package:nosso/src/core/model/produto.dart';

class Favorito {
  int id;
  bool status;
  Produto produto;
  Cliente cliente;

  Favorito({this.id, this.status, this.produto, this.cliente});

  Favorito.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    produto =
        json['produto'] != null ? new Produto.fromJson(json['produto']) : null;
    cliente =
        json['cliente'] != null ? new Cliente.fromJson(json['cliente']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    if (this.produto != null) {
      data['produto'] = this.produto.toJson();
    }
    if (this.cliente != null) {
      data['cliente'] = this.cliente.toJson();
    }
    return data;
  }
}
