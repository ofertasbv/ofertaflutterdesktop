// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cliente_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ClienteController on ClienteControllerBase, Store {
  final _$clientesAtom = Atom(name: 'ClienteControllerBase.clientes');

  @override
  List<Cliente> get clientes {
    _$clientesAtom.reportRead();
    return super.clientes;
  }

  @override
  set clientes(List<Cliente> value) {
    _$clientesAtom.reportWrite(value, super.clientes, () {
      super.clientes = value;
    });
  }

  final _$clienteAtom = Atom(name: 'ClienteControllerBase.cliente');

  @override
  int get cliente {
    _$clienteAtom.reportRead();
    return super.cliente;
  }

  @override
  set cliente(int value) {
    _$clienteAtom.reportWrite(value, super.cliente, () {
      super.cliente = value;
    });
  }

  final _$formDataAtom = Atom(name: 'ClienteControllerBase.formData');

  @override
  dynamic get formData {
    _$formDataAtom.reportRead();
    return super.formData;
  }

  @override
  set formData(dynamic value) {
    _$formDataAtom.reportWrite(value, super.formData, () {
      super.formData = value;
    });
  }

  final _$senhaVisivelAtom = Atom(name: 'ClienteControllerBase.senhaVisivel');

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

  final _$clienteSelecionadoAtom =
      Atom(name: 'ClienteControllerBase.clienteSelecionado');

  @override
  Cliente get clienteSelecionado {
    _$clienteSelecionadoAtom.reportRead();
    return super.clienteSelecionado;
  }

  @override
  set clienteSelecionado(Cliente value) {
    _$clienteSelecionadoAtom.reportWrite(value, super.clienteSelecionado, () {
      super.clienteSelecionado = value;
    });
  }

  final _$arquivoAtom = Atom(name: 'ClienteControllerBase.arquivo');

  @override
  String get arquivo {
    _$arquivoAtom.reportRead();
    return super.arquivo;
  }

  @override
  set arquivo(String value) {
    _$arquivoAtom.reportWrite(value, super.arquivo, () {
      super.arquivo = value;
    });
  }

  final _$errorAtom = Atom(name: 'ClienteControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'ClienteControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'ClienteControllerBase.mensagem');

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

  final _$getAllAsyncAction = AsyncAction('ClienteControllerBase.getAll');

  @override
  Future<List<Cliente>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$getAllByNomeAsyncAction =
      AsyncAction('ClienteControllerBase.getAllByNome');

  @override
  Future<List<Cliente>> getAllByNome(String nome) {
    return _$getAllByNomeAsyncAction.run(() => super.getAllByNome(nome));
  }

  final _$getByIdAsyncAction = AsyncAction('ClienteControllerBase.getById');

  @override
  Future<Cliente> getById(int id) {
    return _$getByIdAsyncAction.run(() => super.getById(id));
  }

  final _$getAllByIdAsyncAction =
      AsyncAction('ClienteControllerBase.getAllById');

  @override
  Future<List<Cliente>> getAllById(int id) {
    return _$getAllByIdAsyncAction.run(() => super.getAllById(id));
  }

  final _$createAsyncAction = AsyncAction('ClienteControllerBase.create');

  @override
  Future<int> create(Cliente p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('ClienteControllerBase.update');

  @override
  Future<int> update(int id, Cliente p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  final _$uploadAsyncAction = AsyncAction('ClienteControllerBase.upload');

  @override
  Future<String> upload(File foto, String fileName) {
    return _$uploadAsyncAction.run(() => super.upload(foto, fileName));
  }

  final _$deleteFotoAsyncAction =
      AsyncAction('ClienteControllerBase.deleteFoto');

  @override
  Future<void> deleteFoto(String foto) {
    return _$deleteFotoAsyncAction.run(() => super.deleteFoto(foto));
  }

  final _$ClienteControllerBaseActionController =
      ActionController(name: 'ClienteControllerBase');

  @override
  dynamic visualizarSenha() {
    final _$actionInfo = _$ClienteControllerBaseActionController.startAction(
        name: 'ClienteControllerBase.visualizarSenha');
    try {
      return super.visualizarSenha();
    } finally {
      _$ClienteControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
clientes: ${clientes},
cliente: ${cliente},
formData: ${formData},
senhaVisivel: ${senhaVisivel},
clienteSelecionado: ${clienteSelecionado},
arquivo: ${arquivo},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem}
    ''';
  }
}
