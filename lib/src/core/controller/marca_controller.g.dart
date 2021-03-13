// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marca_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MarcaController on MarcaControllerBase, Store {
  final _$marcasAtom = Atom(name: 'MarcaControllerBase.marcas');

  @override
  List<Marca> get marcas {
    _$marcasAtom.reportRead();
    return super.marcas;
  }

  @override
  set marcas(List<Marca> value) {
    _$marcasAtom.reportWrite(value, super.marcas, () {
      super.marcas = value;
    });
  }

  final _$marcaAtom = Atom(name: 'MarcaControllerBase.marca');

  @override
  int get marca {
    _$marcaAtom.reportRead();
    return super.marca;
  }

  @override
  set marca(int value) {
    _$marcaAtom.reportWrite(value, super.marca, () {
      super.marca = value;
    });
  }

  final _$errorAtom = Atom(name: 'MarcaControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'MarcaControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'MarcaControllerBase.mensagem');

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

  final _$marcaSelecionadaAtom =
      Atom(name: 'MarcaControllerBase.marcaSelecionada');

  @override
  Marca get marcaSelecionada {
    _$marcaSelecionadaAtom.reportRead();
    return super.marcaSelecionada;
  }

  @override
  set marcaSelecionada(Marca value) {
    _$marcaSelecionadaAtom.reportWrite(value, super.marcaSelecionada, () {
      super.marcaSelecionada = value;
    });
  }

  final _$getAllAsyncAction = AsyncAction('MarcaControllerBase.getAll');

  @override
  Future<List<Marca>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$getAllByNomeAsyncAction =
      AsyncAction('MarcaControllerBase.getAllByNome');

  @override
  Future<List<Marca>> getAllByNome(String nome) {
    return _$getAllByNomeAsyncAction.run(() => super.getAllByNome(nome));
  }

  final _$createAsyncAction = AsyncAction('MarcaControllerBase.create');

  @override
  Future<int> create(Marca p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('MarcaControllerBase.update');

  @override
  Future<int> update(int id, Marca p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  @override
  String toString() {
    return '''
marcas: ${marcas},
marca: ${marca},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem},
marcaSelecionada: ${marcaSelecionada}
    ''';
  }
}
