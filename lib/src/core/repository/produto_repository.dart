import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:nosso/src/core/model/produtopage.dart';
import 'package:nosso/src/core/model/produtoprincipal.dart';
import 'package:nosso/src/util/filter/produto_filter.dart';

class ProdutoRepository {
  CustonDio dio = CustonDio();

  Future<List<ProdutoPrincipal>> nextPageProduto() async {
    try {
      var response = await dio.client.get("/produtos");
      return (response.data).map((c) => Produto.fromJson(c)).toList();
    } on Exception catch (error) {
      print(error);
      return null;
    }
  }

  Future<List<Produto>> getAllById(int id) async {
    try {
      print("carregando produtos by id");
      var response = await dio.client.get("/produtos/${id}");
      print("resposta: ${response}");
      return (response.data as List).map((c) => Produto.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Produto>> getAllByNome(String nome) async {
    try {
      print("carregando produtos by nome");
      var response = await dio.client.get("/produtos/nome/${nome}");
      return (response.data as List).map((c) => Produto.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Produto>> getAll() async {
    try {
      print("carregando produtos");
      var response = await dio.client.get("/produtos");
      return (response.data as List).map((c) => Produto.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<ProdutoData> getAllPageable(
      ProdutoFilter filter, int size, int page) async {
    try {
      return dio.client
          .get(
              "/produtos?nomeProduto=${filter.nomeProduto}&size=${size}&page=${page}")
          .then((p) => ProdutoData.fromJson(p.data));
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Produto>> getFilter(ProdutoFilter filter) async {
    try {
      print("carregando produtos filtrados");
      var response = await dio.client.get(
        "/produtos/filter",
        queryParameters: {
          "nomeProduto": filter.nomeProduto,
          "subCategoria": filter.subCategoria,
          "loja": filter.loja,
          "marca": filter.marca,
          "promocao": filter.promocao,
        },
      );
      return (response.data as List).map((c) => Produto.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Produto>> getAllBySubCategoriaById(int id) async {
    try {
      print("carregando produtos da subcategoria");
      var response = await dio.client.get("/produtos/subcategoria/$id");
      return (response.data as List).map((c) => Produto.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Produto>> getAllByLojaById(int id) async {
    try {
      print("carregando produtos da loja");
      var response = await dio.client.get("/produtos/loja/$id");
      return (response.data as List).map((c) => Produto.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<Produto> getByCodBarra(String codigoBarra) async {
    try {
      print("carregando produtos by codigo de barra");
      var response = await dio.client.get("/produtos/codigobarra/$codigoBarra");
      return Produto.fromJson(response.data);
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/produtos/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/produtos/update/$id", data: data);
    return response.statusCode;
  }

  Future<void> deleteFoto(String foto) async {
    try {
      var response = await dio.client.delete("/produtos/delete/foto/$foto");
      return response.statusCode;
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  Future<String> upload(File file, String fileName) async {
    var arquivo = file.path;

    var paramentros = {
      "foto": await MultipartFile.fromFile(arquivo, filename: fileName)
    };

    FormData formData = FormData.fromMap(paramentros);
    var response = await dio.client
        .post(ConstantApi.urlList + "/produtos/upload", data: formData);
    return response.toString();
  }
}
