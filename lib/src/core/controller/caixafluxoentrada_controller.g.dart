// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caixafluxoentrada_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CaixafluxoentradaController on CaixafluxoentradaControllerBase, Store {
  final _$caixaEntradasAtom =
      Atom(name: 'CaixafluxoentradaControllerBase.caixaEntradas');

  @override
  List<CaixaFluxoEntrada> get caixaEntradas {
    _$caixaEntradasAtom.reportRead();
    return super.caixaEntradas;
  }

  @override
  set caixaEntradas(List<CaixaFluxoEntrada> value) {
    _$caixaEntradasAtom.reportWrite(value, super.caixaEntradas, () {
      super.caixaEntradas = value;
    });
  }

  final _$caixaEntradaAtom =
      Atom(name: 'CaixafluxoentradaControllerBase.caixaEntrada');

  @override
  int get caixaEntrada {
    _$caixaEntradaAtom.reportRead();
    return super.caixaEntrada;
  }

  @override
  set caixaEntrada(int value) {
    _$caixaEntradaAtom.reportWrite(value, super.caixaEntrada, () {
      super.caixaEntrada = value;
    });
  }

  final _$errorAtom = Atom(name: 'CaixafluxoentradaControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'CaixafluxoentradaControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'CaixafluxoentradaControllerBase.mensagem');

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

  final _$getAllAsyncAction =
      AsyncAction('CaixafluxoentradaControllerBase.getAll');

  @override
  Future<List<CaixaFluxoEntrada>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$createAsyncAction =
      AsyncAction('CaixafluxoentradaControllerBase.create');

  @override
  Future<int> create(CaixaFluxoEntrada p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction =
      AsyncAction('CaixafluxoentradaControllerBase.update');

  @override
  Future<int> update(int id, CaixaFluxoEntrada p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  @override
  String toString() {
    return '''
caixaEntradas: ${caixaEntradas},
caixaEntrada: ${caixaEntrada},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem}
    ''';
  }
}
