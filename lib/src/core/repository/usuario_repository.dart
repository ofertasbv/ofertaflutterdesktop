import 'package:dio/dio.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/usuario.dart';

class UsuarioRepository {
  CustonDio dio = CustonDio();

  Future<List<Usuario>> getAllById(int id) async {
    try {
      print("carregando usuarios by id");
      var response = await dio.client.get("/usuarios/${id}");
      return (response.data as List).map((c) => Usuario.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Usuario>> getAll() async {
    try {
      print("carregando usuarios");
      var response = await dio.client.get("/usuarios");
      return (response.data as List).map((c) => Usuario.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<Usuario> getByEmail(String email) async {
    try {
      print("carregando usuarios by email");
      var response = await dio.client.get("/usuarios/email/$email");
      return Usuario.fromJson(response.data);
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<Usuario> getByLogin(String email, String senha) async {
    try {
      print("carregando usuario by login");
      var response = await dio.client.get("/usuarios/login/$email/$senha");
      print("Status login: ${response.statusCode}");
      return Usuario.fromJson(response.data);
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/usuarios/update/$id", data: data);
    return response.statusCode;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/usuarios/create", data: data);
    return response.statusCode;
  }

  Future<int> loginToken(Usuario usuario) async {
    var body = {
      "client": "mobile",
      "username": usuario.email,
      "password": usuario.senha,
      "grant_type": "password",
    };

    var response = await dio.client.post(
      "/oauth/token",
      options: Options(
        headers: {
          "Content-type": "application/x-www-form-urlencoded",
          "Authorization": "Basic bW9iaWxlOm0wYjFsMzA="
        },
      ),
      data: body,
    );

    print(response.data);
    print(response.headers);
    print(response.statusCode);

    return response.statusCode;
  }
}
