// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UsuarioController on UsuarioControllerBase, Store {
  final _$usuariosAtom = Atom(name: 'UsuarioControllerBase.usuarios');

  @override
  List<Usuario> get usuarios {
    _$usuariosAtom.reportRead();
    return super.usuarios;
  }

  @override
  set usuarios(List<Usuario> value) {
    _$usuariosAtom.reportWrite(value, super.usuarios, () {
      super.usuarios = value;
    });
  }

  final _$usuarioAtom = Atom(name: 'UsuarioControllerBase.usuario');

  @override
  int get usuario {
    _$usuarioAtom.reportRead();
    return super.usuario;
  }

  @override
  set usuario(int value) {
    _$usuarioAtom.reportWrite(value, super.usuario, () {
      super.usuario = value;
    });
  }

  final _$errorAtom = Atom(name: 'UsuarioControllerBase.error');

  @override
  Exception get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(Exception value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$dioErrorAtom = Atom(name: 'UsuarioControllerBase.dioError');

  @override
  DioError get dioError {
    _$dioErrorAtom.reportRead();
    return super.dioError;
  }

  @override
  set dioError(DioError value) {
    _$dioErrorAtom.reportWrite(value, super.dioError, () {
      super.dioError = value;
    });
  }

  final _$mensagemAtom = Atom(name: 'UsuarioControllerBase.mensagem');

  @override
  String get mensagem {
    _$mensagemAtom.reportRead();
    return super.mensagem;
  }

  @override
  set mensagem(String value) {
    _$mensagemAtom.reportWrite(value, super.mensagem, () {
      super.mensagem = value;
    });
  }

  final _$usuarioSelecionadoAtom =
      Atom(name: 'UsuarioControllerBase.usuarioSelecionado');

  @override
  Usuario get usuarioSelecionado {
    _$usuarioSelecionadoAtom.reportRead();
    return super.usuarioSelecionado;
  }

  @override
  set usuarioSelecionado(Usuario value) {
    _$usuarioSelecionadoAtom.reportWrite(value, super.usuarioSelecionado, () {
      super.usuarioSelecionado = value;
    });
  }

  final _$senhaVisivelAtom = Atom(name: 'UsuarioControllerBase.senhaVisivel');

  @override
  bool get senhaVisivel {
    _$senhaVisivelAtom.reportRead();
    return super.senhaVisivel;
  }

  @override
  set senhaVisivel(bool value) {
    _$senhaVisivelAtom.reportWrite(value, super.senhaVisivel, () {
      super.senhaVisivel = value;
    });
  }

  final _$getAllAsyncAction = AsyncAction('UsuarioControllerBase.getAll');

  @override
  Future<List<Usuario>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$getEmailAsyncAction = AsyncAction('UsuarioControllerBase.getEmail');

  @override
  Future<Usuario> getEmail(String email) {
    return _$getEmailAsyncAction.run(() => super.getEmail(email));
  }

  final _$getLoginAsyncAction = AsyncAction('UsuarioControllerBase.getLogin');

  @override
  Future<Usuario> getLogin(String email, String senha) {
    return _$getLoginAsyncAction.run(() => super.getLogin(email, senha));
  }

  final _$loginTokenAsyncAction =
      AsyncAction('UsuarioControllerBase.loginToken');

  @override
  Future<int> loginToken(Usuario p) {
    return _$loginTokenAsyncAction.run(() => super.loginToken(p));
  }

  final _$createAsyncAction = AsyncAction('UsuarioControllerBase.create');

  @override
  Future<int> create(Usuario p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('UsuarioControllerBase.update');

  @override
  Future<int> update(int id, Usuario p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  final _$UsuarioControllerBaseActionController =
      ActionController(name: 'UsuarioControllerBase');

  @override
  dynamic visualizarSenha() {
    final _$actionInfo = _$UsuarioControllerBaseActionController.startAction(
        name: 'UsuarioControllerBase.visualizarSenha');
    try {
      return super.visualizarSenha();
    } finally {
      _$UsuarioControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
usuarios: ${usuarios},
usuario: ${usuario},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem},
usuarioSelecionado: ${usuarioSelecionado},
senhaVisivel: ${senhaVisivel}
    ''';
  }
}
