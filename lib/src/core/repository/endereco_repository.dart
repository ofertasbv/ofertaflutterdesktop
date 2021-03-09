import 'package:dio/dio.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/endereco.dart';

class EnderecoRepository {
  CustonDio dio = CustonDio();

  Future<List<Endereco>> getAll() async {
    try {
      print("carregando enderecos");
      var response = await dio.client.get("/enderecos");
      return (response.data as List).map((c) => Endereco.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Endereco>> getAllById(int id) async {
    try {
      print("carregando enderecos by id");
      var response = await dio.client.get("/enderecos/${id}");
      return (response.data as List).map((c) => Endereco.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Endereco>> getAllByPessoa(int id) async {
    try {
      print("carregando enderecos by pessoa");
      var response = await dio.client.get("/enderecos/pessoa/${id}");
      return (response.data as List).map((c) => Endereco.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<Endereco> getByCep(String cep) async {
    try {
      print("carregando enderecos by cep");
      var response = await dio.client.get("/enderecos/$cep");
      return Endereco.fromJson(response.data);
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/enderecos/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/enderecos/update/$id", data: data);
    return response.statusCode;
  }
}
