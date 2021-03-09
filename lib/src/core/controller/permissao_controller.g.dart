// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permissao_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PermissaoController on PermissaoControllerBase, Store {
  final _$permissoesAtom = Atom(name: 'PermissaoControllerBase.permissoes');

  @override
  List<Permissao> get permissoes {
    _$permissoesAtom.reportRead();
    return super.permissoes;
  }

  @override
  set permissoes(List<Permissao> value) {
    _$permissoesAtom.reportWrite(value, super.permissoes, () {
      super.permissoes = value;
    });
  }

  final _$permissaoAtom = Atom(name: 'PermissaoControllerBase.permissao');

  @override
  int get permissao {
    _$permissaoAtom.reportRead();
    return super.permissao;
  }

  @override
  set permissao(int value) {
    _$permissaoAtom.reportWrite(value, super.permissao, () {
      super.permissao = value;
    });
  }

  final _$errorAtom = Atom(name: 'PermissaoControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'PermissaoControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'PermissaoControllerBase.mensagem');

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

  final _$getAllAsyncAction = AsyncAction('PermissaoControllerBase.getAll');

  @override
  Future<List<Permissao>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$createAsyncAction = AsyncAction('PermissaoControllerBase.create');

  @override
  Future<int> create(Permissao p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('PermissaoControllerBase.update');

  @override
  Future<int> update(int id, Permissao p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  @override
  String toString() {
    return '''
permissoes: ${permissoes},
permissao: ${permissao},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem}
    ''';
  }
}
