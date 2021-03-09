import 'package:nosso/src/core/model/content.dart';
import 'package:nosso/src/core/model/pageable.dart';
import 'package:nosso/src/core/model/sort.dart';

class ProdutoData {
  List<Content> content;
  Pageable pageable;
  int totalPages;
  int totalElements;
  bool last;
  bool first;
  Sort sort;
  int number;
  int numberOfElements;
  int size;
  bool empty;

  ProdutoData(
      {this.content,
      this.pageable,
      this.totalPages,
      this.totalElements,
      this.last,
      this.first,
      this.sort,
      this.number,
      this.numberOfElements,
      this.size,
      this.empty});

  ProdutoData.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = new List<Content>();
      json['content'].forEach((v) {
        content.add(new Content.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    last = json['last'];
    first = json['first'];
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    number = json['number'];
    numberOfElements = json['numberOfElements'];
    size = json['size'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable.toJson();
    }
    data['totalPages'] = this.totalPages;
    data['totalElements'] = this.totalElements;
    data['last'] = this.last;
    data['first'] = this.first;
    if (this.sort != null) {
      data['sort'] = this.sort.toJson();
    }
    data['number'] = this.number;
    data['numberOfElements'] = this.numberOfElements;
    data['size'] = this.size;
    data['empty'] = this.empty;
    return data;
  }
}
