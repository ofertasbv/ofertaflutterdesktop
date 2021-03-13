// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendedor_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VendedorController on VendedorControllerBase, Store {
  final _$vendedoresAtom = Atom(name: 'VendedorControllerBase.vendedores');

  @override
  List<Vendedor> get vendedores {
    _$vendedoresAtom.reportRead();
    return super.vendedores;
  }

  @override
  set vendedores(List<Vendedor> value) {
    _$vendedoresAtom.reportWrite(value, super.vendedores, () {
      super.vendedores = value;
    });
  }

  final _$vendedorAtom = Atom(name: 'VendedorControllerBase.vendedor');

  @override
  int get vendedor {
    _$vendedorAtom.reportRead();
    return super.vendedor;
  }

  @override
  set vendedor(int value) {
    _$vendedorAtom.reportWrite(value, super.vendedor, () {
      super.vendedor = value;
    });
  }

  final _$formDataAtom = Atom(name: 'VendedorControllerBase.formData');

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

  final _$senhaVisivelAtom = Atom(name: 'VendedorControllerBase.senhaVisivel');

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

  final _$vendedoreSelecionadoAtom =
      Atom(name: 'VendedorControllerBase.vendedoreSelecionado');

  @override
  Vendedor get vendedoreSelecionado {
    _$vendedoreSelecionadoAtom.reportRead();
    return super.vendedoreSelecionado;
  }

  @override
  set vendedoreSelecionado(Vendedor value) {
    _$vendedoreSelecionadoAtom.reportWrite(value, super.vendedoreSelecionado,
        () {
      super.vendedoreSelecionado = value;
    });
  }

  final _$arquivoAtom = Atom(name: 'VendedorControllerBase.arquivo');

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

  final _$errorAtom = Atom(name: 'VendedorControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'VendedorControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'VendedorControllerBase.mensagem');

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

  final _$getAllAsyncAction = AsyncAction('VendedorControllerBase.getAll');

  @override
  Future<List<Vendedor>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$getAllByNomeAsyncAction =
      AsyncAction('VendedorControllerBase.getAllByNome');

  @override
  Future<List<Vendedor>> getAllByNome(String nome) {
    return _$getAllByNomeAsyncAction.run(() => super.getAllByNome(nome));
  }

  final _$getByIdAsyncAction = AsyncAction('VendedorControllerBase.getById');

  @override
  Future<Vendedor> getById(int id) {
    return _$getByIdAsyncAction.run(() => super.getById(id));
  }

  final _$getAllByIdAsyncAction =
      AsyncAction('VendedorControllerBase.getAllById');

  @override
  Future<List<Vendedor>> getAllById(int id) {
    return _$getAllByIdAsyncAction.run(() => super.getAllById(id));
  }

  final _$createAsyncAction = AsyncAction('VendedorControllerBase.create');

  @override
  Future<int> create(Vendedor p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('VendedorControllerBase.update');

  @override
  Future<int> update(int id, Vendedor p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  final _$uploadAsyncAction = AsyncAction('VendedorControllerBase.upload');

  @override
  Future<String> upload(File foto, String fileName) {
    return _$uploadAsyncAction.run(() => super.upload(foto, fileName));
  }

  final _$deleteFotoAsyncAction =
      AsyncAction('VendedorControllerBase.deleteFoto');

  @override
  Future<void> deleteFoto(String foto) {
    return _$deleteFotoAsyncAction.run(() => super.deleteFoto(foto));
  }

  final _$VendedorControllerBaseActionController =
      ActionController(name: 'VendedorControllerBase');

  @override
  dynamic visualizarSenha() {
    final _$actionInfo = _$VendedorControllerBaseActionController.startAction(
        name: 'VendedorControllerBase.visualizarSenha');
    try {
      return super.visualizarSenha();
    } finally {
      _$VendedorControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
vendedores: ${vendedores},
vendedor: ${vendedor},
formData: ${formData},
senhaVisivel: ${senhaVisivel},
vendedoreSelecionado: ${vendedoreSelecionado},
arquivo: ${arquivo},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem}
    ''';
  }
}
