import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/core/model/usuario.dart';
import 'package:nosso/src/core/repository/usuario_repository.dart';

part 'usuario_controller.g.dart';

class UsuarioController = UsuarioControllerBase with _$UsuarioController;

abstract class UsuarioControllerBase with Store {
  UsuarioRepository usuarioRepository;

  UsuarioControllerBase() {
    usuarioRepository = UsuarioRepository();
  }

  @observable
  List<Usuario> usuarios;

  @observable
  int usuario;

  @observable
  Exception error;

  @observable
  DioError dioError;

  @observable
  String mensagem;

  @observable
  Usuario usuarioSelecionado;

  @observable
  bool senhaVisivel = false;

  @action
  visualizarSenha() {
    senhaVisivel = !senhaVisivel;
  }

  @action
  Future<List<Usuario>> getAll() async {
    try {
      usuarios = await usuarioRepository.getAll();
      return usuarios;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<Usuario> getEmail(String email) async {
    try {
      usuarioSelecionado = await usuarioRepository.getByEmail(email);
      return usuarioSelecionado;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<Usuario> getLogin(String email, String senha) async {
    try {
      usuarioSelecionado = await usuarioRepository.getByLogin(email, senha);
      if (usuarioSelecionado == null) {
        mensagem = "usuário vazio";
      } else {
        return usuarioSelecionado;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> loginToken(Usuario p) async {
    try {
      usuario = await usuarioRepository.login(p.toJson());
      if (usuario == null) {
        mensagem = "usuário vazio";
      } else {
        return usuario;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> create(Usuario p) async {
    try {
      usuario = await usuarioRepository.create(p.toJson());
      if (usuario == null) {
        mensagem = "usuário vazio";
      } else {
        return usuario;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> update(int id, Usuario p) async {
    try {
      usuario = await usuarioRepository.update(id, p.toJson());
      return usuario;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }
}
