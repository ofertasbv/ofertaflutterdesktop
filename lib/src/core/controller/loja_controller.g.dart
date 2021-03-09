// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loja_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LojaController on LojaControllerBase, Store {
  final _$lojasAtom = Atom(name: 'LojaControllerBase.lojas');

  @override
  List<Loja> get lojas {
    _$lojasAtom.reportRead();
    return super.lojas;
  }

  @override
  set lojas(List<Loja> value) {
    _$lojasAtom.reportWrite(value, super.lojas, () {
      super.lojas = value;
    });
  }

  final _$lojaAtom = Atom(name: 'LojaControllerBase.loja');

  @override
  int get loja {
    _$lojaAtom.reportRead();
    return super.loja;
  }

  @override
  set loja(int value) {
    _$lojaAtom.reportWrite(value, super.loja, () {
      super.loja = value;
    });
  }

  final _$formDataAtom = Atom(name: 'LojaControllerBase.formData');

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

  final _$senhaVisivelAtom = Atom(name: 'LojaControllerBase.senhaVisivel');

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

  final _$errorAtom = Atom(name: 'LojaControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'LojaControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'LojaControllerBase.mensagem');

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

  final _$lojaSelecionadaAtom =
      Atom(name: 'LojaControllerBase.lojaSelecionada');

  @override
  Loja get lojaSelecionada {
    _$lojaSelecionadaAtom.reportRead();
    return super.lojaSelecionada;
  }

  @override
  set lojaSelecionada(Loja value) {
    _$lojaSelecionadaAtom.reportWrite(value, super.lojaSelecionada, () {
      super.lojaSelecionada = value;
    });
  }

  final _$arquivoAtom = Atom(name: 'LojaControllerBase.arquivo');

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

  final _$getByIdAsyncAction = AsyncAction('LojaControllerBase.getById');

  @override
  Future<Loja> getById(int id) {
    return _$getByIdAsyncAction.run(() => super.getById(id));
  }

  final _$getAllByIdAsyncAction = AsyncAction('LojaControllerBase.getAllById');

  @override
  Future<List<Loja>> getAllById(int id) {
    return _$getAllByIdAsyncAction.run(() => super.getAllById(id));
  }

  final _$getAllByNomeAsyncAction =
      AsyncAction('LojaControllerBase.getAllByNome');

  @override
  Future<List<Loja>> getAllByNome(String nome) {
    return _$getAllByNomeAsyncAction.run(() => super.getAllByNome(nome));
  }

  final _$getAllAsyncAction = AsyncAction('LojaControllerBase.getAll');

  @override
  Future<List<Loja>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$createAsyncAction = AsyncAction('LojaControllerBase.create');

  @override
  Future<int> create(Loja p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('LojaControllerBase.update');

  @override
  Future<int> update(int id, Loja p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  final _$uploadAsyncAction = AsyncAction('LojaControllerBase.upload');

  @override
  Future<String> upload(File foto, String fileName) {
    return _$uploadAsyncAction.run(() => super.upload(foto, fileName));
  }

  final _$deleteFotoAsyncAction = AsyncAction('LojaControllerBase.deleteFoto');

  @override
  Future<void> deleteFoto(String foto) {
    return _$deleteFotoAsyncAction.run(() => super.deleteFoto(foto));
  }

  final _$LojaControllerBaseActionController =
      ActionController(name: 'LojaControllerBase');

  @override
  dynamic visualizarSenha() {
    final _$actionInfo = _$LojaControllerBaseActionController.startAction(
        name: 'LojaControllerBase.visualizarSenha');
    try {
      return super.visualizarSenha();
    } finally {
      _$LojaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
lojas: ${lojas},
loja: ${loja},
formData: ${formData},
senhaVisivel: ${senhaVisivel},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem},
lojaSelecionada: ${lojaSelecionada},
arquivo: ${arquivo}
    ''';
  }
}
