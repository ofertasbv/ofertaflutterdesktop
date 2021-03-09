import 'package:nosso/src/core/model/arquivo.dart';
import 'package:nosso/src/core/model/cor.dart';
import 'package:nosso/src/core/model/estoque.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/core/model/marca.dart';
import 'package:nosso/src/core/model/promocao.dart';
import 'package:nosso/src/core/model/subcategoria.dart';
import 'package:nosso/src/core/model/tamanho.dart';

class Produto {
  int id;
  String sku;
  String nome;
  String descricao;
  String foto;
  String codigoBarra;
  bool status;
  bool novo;
  bool destaque;
  String medida;
  String origem;
  double valorTotal;
  SubCategoria subCategoria;
  Promocao promocao;
  Loja loja;
  List<Arquivo> arquivos = new List<Arquivo>();
  List<Tamanho> tamanhos = new  List<Tamanho>();
  List<Cor> cores = new List<Cor>();
  Estoque estoque = new Estoque();
  Marca marca;

  Produto(
      {this.id,
      this.sku,
      this.nome,
      this.descricao,
      this.foto,
      this.codigoBarra,
      this.status,
      this.novo,
      this.destaque,
      this.medida,
      this.origem,
      this.valorTotal,
      this.subCategoria,
      this.promocao,
      this.loja,
      this.arquivos,
      this.tamanhos,
      this.cores,
      this.estoque,
      this.marca});

  Produto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    nome = json['nome'];
    descricao = json['descricao'];
    foto = json['foto'];
    codigoBarra = json['codigoBarra'];
    status = json['status'];
    novo = json['novo'];
    destaque = json['destaque'];
    medida = json['medida'];
    origem = json['origem'];
    valorTotal = json['valorTotal'];

    subCategoria = json['subCategoria'] != null
        ? new SubCategoria.fromJson(json['subCategoria'])
        : null;

    promocao = json['promocao'] != null
        ? new Promocao.fromJson(json['promocao'])
        : null;

    loja = json['loja'] != null ? new Loja.fromJson(json['loja']) : null;

    if (json['arquivos'] != null) {
      arquivos = new List<Arquivo>();
      json['arquivos'].forEach((v) {
        arquivos.add(new Arquivo.fromJson(v));
      });
    }

    if (json['tamanhos'] != null) {
      tamanhos = new List<Tamanho>();
      json['tamanhos'].forEach((v) {
        tamanhos.add(new Tamanho.fromJson(v));
      });
    }

    if (json['cores'] != null) {
      cores = new List<Cor>();
      json['cores'].forEach((v) {
        cores.add(new Cor.fromJson(v));
      });
    }

    estoque =
        json['estoque'] != null ? new Estoque.fromJson(json['estoque']) : null;
    marca = json['marca'] != null ? new Marca.fromJson(json['marca']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sku'] = this.sku;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['foto'] = this.foto;
    data['codigoBarra'] = this.codigoBarra;
    data['status'] = this.status;
    data['novo'] = this.novo;
    data['destaque'] = this.destaque;
    data['medida'] = this.medida;
    data['origem'] = this.origem;
    data['valorTotal'] = this.valorTotal;

    if (this.subCategoria != null) {
      data['subCategoria'] = this.subCategoria.toJson();
    }
    if (this.promocao != null) {
      data['promocao'] = this.promocao.toJson();
    }
    if (this.loja != null) {
      data['loja'] = this.loja.toJson();
    }
    if (this.arquivos != null) {
      data['arquivos'] = this.arquivos.map((v) => v.toJson()).toList();
    }

    if (this.tamanhos != null) {
      data['tamanhos'] = this.tamanhos.map((v) => v.toJson()).toList();
    }

    if (this.cores != null) {
      data['cores'] = this.cores.map((v) => v.toJson()).toList();
    }

    if (this.estoque != null) {
      data['estoque'] = this.estoque.toJson();
    }
    if (this.marca != null) {
      data['marca'] = this.marca.toJson();
    }
    return data;
  }
}
