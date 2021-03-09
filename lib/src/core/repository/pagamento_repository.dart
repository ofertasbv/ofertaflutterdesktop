import 'package:dio/dio.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/pagamento.dart';

class PagamentoRepository {
  CustonDio dio = CustonDio();

  Future<List<Pagamento>> getAllById(int id) async {
    try {
      print("carregando pagamentos by id");
      var response = await dio.client.get("/pagamentos/${id}");
      return (response.data as List).map((c) => Pagamento.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Pagamento>> getAll() async {
    try {
      print("carregando pagamentos");
      var response = await dio.client.get("/pagamentos");
      return (response.data as List).map((c) => Pagamento.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/pagamentos/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/pagamentos/update/$id", data: data);
    return response.statusCode;
  }
}
