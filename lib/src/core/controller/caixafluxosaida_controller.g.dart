// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caixafluxosaida_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CaixafluxosaidaController on CaixafluxosaidaControllerBase, Store {
  final _$caixaSaidasAtom =
      Atom(name: 'CaixafluxosaidaControllerBase.caixaSaidas');

  @override
  List<CaixaFluxoSaida> get caixaSaidas {
    _$caixaSaidasAtom.reportRead();
    return super.caixaSaidas;
  }

  @override
  set caixaSaidas(List<CaixaFluxoSaida> value) {
    _$caixaSaidasAtom.reportWrite(value, super.caixaSaidas, () {
      super.caixaSaidas = value;
    });
  }

  final _$caixaSaidaAtom =
      Atom(name: 'CaixafluxosaidaControllerBase.caixaSaida');

  @override
  int get caixaSaida {
    _$caixaSaidaAtom.reportRead();
    return super.caixaSaida;
  }

  @override
  set caixaSaida(int value) {
    _$caixaSaidaAtom.reportWrite(value, super.caixaSaida, () {
      super.caixaSaida = value;
    });
  }

  final _$errorAtom = Atom(name: 'CaixafluxosaidaControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'CaixafluxosaidaControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'CaixafluxosaidaControllerBase.mensagem');

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
      AsyncAction('CaixafluxosaidaControllerBase.getAll');

  @override
  Future<List<CaixaFluxoSaida>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$createAsyncAction =
      AsyncAction('CaixafluxosaidaControllerBase.create');

  @override
  Future<int> create(CaixaFluxoSaida p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction =
      AsyncAction('CaixafluxosaidaControllerBase.update');

  @override
  Future<int> update(int id, CaixaFluxoSaida p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  @override
  String toString() {
    return '''
caixaSaidas: ${caixaSaidas},
caixaSaida: ${caixaSaida},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem}
    ''';
  }
}
