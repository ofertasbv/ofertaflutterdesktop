// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promocao_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PromoCaoController on PromoCaoControllerBase, Store {
  final _$promocoesAtom = Atom(name: 'PromoCaoControllerBase.promocoes');

  @override
  List<Promocao> get promocoes {
    _$promocoesAtom.reportRead();
    return super.promocoes;
  }

  @override
  set promocoes(List<Promocao> value) {
    _$promocoesAtom.reportWrite(value, super.promocoes, () {
      super.promocoes = value;
    });
  }

  final _$promocoesByLojaAtom =
      Atom(name: 'PromoCaoControllerBase.promocoesByLoja');

  @override
  List<Promocao> get promocoesByLoja {
    _$promocoesByLojaAtom.reportRead();
    return super.promocoesByLoja;
  }

  @override
  set promocoesByLoja(List<Promocao> value) {
    _$promocoesByLojaAtom.reportWrite(value, super.promocoesByLoja, () {
      super.promocoesByLoja = value;
    });
  }

  final _$promocaoAtom = Atom(name: 'PromoCaoControllerBase.promocao');

  @override
  int get promocao {
    _$promocaoAtom.reportRead();
    return super.promocao;
  }

  @override
  set promocao(int value) {
    _$promocaoAtom.reportWrite(value, super.promocao, () {
      super.promocao = value;
    });
  }

  final _$formDataAtom = Atom(name: 'PromoCaoControllerBase.formData');

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

  final _$errorAtom = Atom(name: 'PromoCaoControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'PromoCaoControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'PromoCaoControllerBase.mensagem');

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

  final _$promocaoSelecionadaAtom =
      Atom(name: 'PromoCaoControllerBase.promocaoSelecionada');

  @override
  Promocao get promocaoSelecionada {
    _$promocaoSelecionadaAtom.reportRead();
    return super.promocaoSelecionada;
  }

  @override
  set promocaoSelecionada(Promocao value) {
    _$promocaoSelecionadaAtom.reportWrite(value, super.promocaoSelecionada, () {
      super.promocaoSelecionada = value;
    });
  }

  final _$arquivoAtom = Atom(name: 'PromoCaoControllerBase.arquivo');

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

  final _$getAllAsyncAction = AsyncAction('PromoCaoControllerBase.getAll');

  @override
  Future<List<Promocao>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$getAllByNomeAsyncAction =
      AsyncAction('PromoCaoControllerBase.getAllByNome');

  @override
  Future<List<Promocao>> getAllByNome(String nome) {
    return _$getAllByNomeAsyncAction.run(() => super.getAllByNome(nome));
  }

  final _$getAllByLojaAsyncAction =
      AsyncAction('PromoCaoControllerBase.getAllByLoja');

  @override
  Future<List<Promocao>> getAllByLoja(int id) {
    return _$getAllByLojaAsyncAction.run(() => super.getAllByLoja(id));
  }

  final _$createAsyncAction = AsyncAction('PromoCaoControllerBase.create');

  @override
  Future<int> create(Promocao p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('PromoCaoControllerBase.update');

  @override
  Future<int> update(int id, Promocao p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  final _$uploadAsyncAction = AsyncAction('PromoCaoControllerBase.upload');

  @override
  Future<String> upload(File foto, String fileName) {
    return _$uploadAsyncAction.run(() => super.upload(foto, fileName));
  }

  final _$deleteFotoAsyncAction =
      AsyncAction('PromoCaoControllerBase.deleteFoto');

  @override
  Future<void> deleteFoto(String foto) {
    return _$deleteFotoAsyncAction.run(() => super.deleteFoto(foto));
  }

  @override
  String toString() {
    return '''
promocoes: ${promocoes},
promocoesByLoja: ${promocoesByLoja},
promocao: ${promocao},
formData: ${formData},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem},
promocaoSelecionada: ${promocaoSelecionada},
arquivo: ${arquivo}
    ''';
  }
}
