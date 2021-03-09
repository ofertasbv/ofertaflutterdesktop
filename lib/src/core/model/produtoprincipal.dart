import 'package:nosso/src/core/model/produto.dart';

class ProdutoPrincipal {
  Info info;
  List<Produto> produtos;

  ProdutoPrincipal({this.info, this.produtos});

  ProdutoPrincipal.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    if (json['results'] != null) {
      produtos = <Produto>[];
      json['results'].forEach((v) {
        produtos.add(Produto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (info != null) {
      data['info'] = info.toJson();
    }
    if (produtos != null) {
      data['results'] = produtos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Info {
  int count;
  int pages;
  String next;
  String prev;

  Info({this.count, this.pages, this.next, this.prev});

  Info.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    pages = json['pages'];
    next = json['next'];
    prev = json['prev'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['count'] = count;
    data['pages'] = pages;
    data['next'] = next;
    data['prev'] = prev;
    return data;
  }
}
