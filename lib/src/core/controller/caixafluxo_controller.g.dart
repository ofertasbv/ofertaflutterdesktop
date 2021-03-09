// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caixafluxo_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CaixafluxoController on CaixafluxoControllerBase, Store {
  final _$caixaFluxosAtom = Atom(name: 'CaixafluxoControllerBase.caixaFluxos');

  @override
  List<CaixaFluxo> get caixaFluxos {
    _$caixaFluxosAtom.reportRead();
    return super.caixaFluxos;
  }

  @override
  set caixaFluxos(List<CaixaFluxo> value) {
    _$caixaFluxosAtom.reportWrite(value, super.caixaFluxos, () {
      super.caixaFluxos = value;
    });
  }

  final _$caixaFluxoAtom = Atom(name: 'CaixafluxoControllerBase.caixaFluxo');

  @override
  int get caixaFluxo {
    _$caixaFluxoAtom.reportRead();
    return super.caixaFluxo;
  }

  @override
  set caixaFluxo(int value) {
    _$caixaFluxoAtom.reportWrite(value, super.caixaFluxo, () {
      super.caixaFluxo = value;
    });
  }

  final _$errorAtom = Atom(name: 'CaixafluxoControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'CaixafluxoControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'CaixafluxoControllerBase.mensagem');

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

  final _$getAllAsyncAction = AsyncAction('CaixafluxoControllerBase.getAll');

  @override
  Future<List<CaixaFluxo>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$createAsyncAction = AsyncAction('CaixafluxoControllerBase.create');

  @override
  Future<int> create(CaixaFluxo p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('CaixafluxoControllerBase.update');

  @override
  Future<int> update(int id, CaixaFluxo p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  @override
  String toString() {
    return '''
caixaFluxos: ${caixaFluxos},
caixaFluxo: ${caixaFluxo},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem}
    ''';
  }
}
