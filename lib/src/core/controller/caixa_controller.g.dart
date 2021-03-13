// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caixa_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CaixaController on CaixaControllerBase, Store {
  final _$caixasAtom = Atom(name: 'CaixaControllerBase.caixas');

  @override
  List<Caixa> get caixas {
    _$caixasAtom.reportRead();
    return super.caixas;
  }

  @override
  set caixas(List<Caixa> value) {
    _$caixasAtom.reportWrite(value, super.caixas, () {
      super.caixas = value;
    });
  }

  final _$caixaAtom = Atom(name: 'CaixaControllerBase.caixa');

  @override
  int get caixa {
    _$caixaAtom.reportRead();
    return super.caixa;
  }

  @override
  set caixa(int value) {
    _$caixaAtom.reportWrite(value, super.caixa, () {
      super.caixa = value;
    });
  }

  final _$caixaSelecionadoAtom =
      Atom(name: 'CaixaControllerBase.caixaSelecionado');

  @override
  Caixa get caixaSelecionado {
    _$caixaSelecionadoAtom.reportRead();
    return super.caixaSelecionado;
  }

  @override
  set caixaSelecionado(Caixa value) {
    _$caixaSelecionadoAtom.reportWrite(value, super.caixaSelecionado, () {
      super.caixaSelecionado = value;
    });
  }

  final _$errorAtom = Atom(name: 'CaixaControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'CaixaControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'CaixaControllerBase.mensagem');

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

  final _$getAllAsyncAction = AsyncAction('CaixaControllerBase.getAll');

  @override
  Future<List<Caixa>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$createAsyncAction = AsyncAction('CaixaControllerBase.create');

  @override
  Future<int> create(Caixa p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('CaixaControllerBase.update');

  @override
  Future<int> update(int id, Caixa p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  @override
  String toString() {
    return '''
caixas: ${caixas},
caixa: ${caixa},
caixaSelecionado: ${caixaSelecionado},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem}
    ''';
  }
}
