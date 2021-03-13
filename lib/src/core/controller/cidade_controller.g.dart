// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cidade_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CidadeController on CidadeControllerBase, Store {
  final _$cidadesAtom = Atom(name: 'CidadeControllerBase.cidades');

  @override
  List<Cidade> get cidades {
    _$cidadesAtom.reportRead();
    return super.cidades;
  }

  @override
  set cidades(List<Cidade> value) {
    _$cidadesAtom.reportWrite(value, super.cidades, () {
      super.cidades = value;
    });
  }

  final _$cidadeAtom = Atom(name: 'CidadeControllerBase.cidade');

  @override
  int get cidade {
    _$cidadeAtom.reportRead();
    return super.cidade;
  }

  @override
  set cidade(int value) {
    _$cidadeAtom.reportWrite(value, super.cidade, () {
      super.cidade = value;
    });
  }

  final _$errorAtom = Atom(name: 'CidadeControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'CidadeControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'CidadeControllerBase.mensagem');

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

  final _$getAllAsyncAction = AsyncAction('CidadeControllerBase.getAll');

  @override
  Future<List<Cidade>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$getAllByIdAsyncAction =
      AsyncAction('CidadeControllerBase.getAllById');

  @override
  Future<List<Cidade>> getAllById(int id) {
    return _$getAllByIdAsyncAction.run(() => super.getAllById(id));
  }

  final _$getAllByEstadoIdAsyncAction =
      AsyncAction('CidadeControllerBase.getAllByEstadoId');

  @override
  Future<List<Cidade>> getAllByEstadoId(int id) {
    return _$getAllByEstadoIdAsyncAction.run(() => super.getAllByEstadoId(id));
  }

  final _$createAsyncAction = AsyncAction('CidadeControllerBase.create');

  @override
  Future<int> create(Cidade p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('CidadeControllerBase.update');

  @override
  Future<int> update(int id, Cidade p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  @override
  String toString() {
    return '''
cidades: ${cidades},
cidade: ${cidade},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem}
    ''';
  }
}
