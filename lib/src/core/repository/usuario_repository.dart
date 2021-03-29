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

  Future<int> loginToken(Map<String, dynamic> data) async {
    var response = await dio.client
        .post("/oauth/token", data: data, options: Options(headers: {}));

    print(response.data);
    print(response.headers);
    // print(response.request);
    print(response.statusCode);

    return response.statusCode;
  }

  Future<int> login(Map<String, dynamic> data) async {
    // Dio dio = Dio();
    Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded",
      // "Accept": "application/json",
      "Authorization": "Basic bW9iaWxlOm0wYjFsMzA=",
    };

    var data = {
      // "client" : "mobile",
      "username": "projetogdados@gmail.com",
      "password": "frctads",
      "grant_type": "password"
    };

    var response = await dio.client.post(
      "/oauth/token",
      data: data,
      options: Options(headers: headers),
    );

    return response.statusCode;
    //     .then((res) async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   await prefs.setString('token', res.data['token']);
    // }).catchError((err) {
    //   throw Exception('Login ou senha inválidos');
    // });
  }
}
