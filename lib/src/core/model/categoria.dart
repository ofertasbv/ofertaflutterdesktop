import 'package:nosso/src/core/model/seguimento.dart';
import 'package:nosso/src/core/model/subcategoria.dart';

class Categoria {
  int id;
  String nome;
  String foto;
  String color;
  Seguimento seguimento;
  List<SubCategoria> subCategorias;

  Categoria({
    this.id,
    this.nome,
    this.foto,
    this.color,
    this.seguimento,
    this.subCategorias,
  });

  Categoria.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    foto = json['foto'];
    color = json['color'];

    seguimento = json['seguimento'] != null
        ? new Seguimento.fromJson(json['seguimento'])
        : null;

    if (json['subCategorias'] != null) {
      subCategorias = new List<SubCategoria>();
      json['subCategorias'].forEach((v) {
        subCategorias.add(new SubCategoria.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['foto'] = this.foto;
    data['color'] = this.color;

    if (this.seguimento != null) {
      data['seguimento'] = this.seguimento.toJson();
    }

    if (this.subCategorias != null) {
      data['subCategorias'] =
          this.subCategorias.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
