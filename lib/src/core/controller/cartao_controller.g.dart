// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartao_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CartaoController on CartaoControllerBase, Store {
  final _$cartoesAtom = Atom(name: 'CartaoControllerBase.cartoes');

  @override
  List<Cartao> get cartoes {
    _$cartoesAtom.reportRead();
    return super.cartoes;
  }

  @override
  set cartoes(List<Cartao> value) {
    _$cartoesAtom.reportWrite(value, super.cartoes, () {
      super.cartoes = value;
    });
  }

  final _$cartaoAtom = Atom(name: 'CartaoControllerBase.cartao');

  @override
  int get cartao {
    _$cartaoAtom.reportRead();
    return super.cartao;
  }

  @override
  set cartao(int value) {
    _$cartaoAtom.reportWrite(value, super.cartao, () {
      super.cartao = value;
    });
  }

  final _$errorAtom = Atom(name: 'CartaoControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'CartaoControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'CartaoControllerBase.mensagem');

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

  final _$getAllAsyncAction = AsyncAction('CartaoControllerBase.getAll');

  @override
  Future<List<Cartao>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$createAsyncAction = AsyncAction('CartaoControllerBase.create');

  @override
  Future<int> create(Cartao p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('CartaoControllerBase.update');

  @override
  Future<int> update(int id, Cartao p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  @override
  String toString() {
    return '''
cartoes: ${cartoes},
cartao: ${cartao},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem}
    ''';
  }
}
