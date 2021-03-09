// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tamanho_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TamanhoController on TamanhoControllerBase, Store {
  final _$tamanhosAtom = Atom(name: 'TamanhoControllerBase.tamanhos');

  @override
  List<Tamanho> get tamanhos {
    _$tamanhosAtom.reportRead();
    return super.tamanhos;
  }

  @override
  set tamanhos(List<Tamanho> value) {
    _$tamanhosAtom.reportWrite(value, super.tamanhos, () {
      super.tamanhos = value;
    });
  }

  final _$tamanhoAtom = Atom(name: 'TamanhoControllerBase.tamanho');

  @override
  int get tamanho {
    _$tamanhoAtom.reportRead();
    return super.tamanho;
  }

  @override
  set tamanho(int value) {
    _$tamanhoAtom.reportWrite(value, super.tamanho, () {
      super.tamanho = value;
    });
  }

  final _$errorAtom = Atom(name: 'TamanhoControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'TamanhoControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'TamanhoControllerBase.mensagem');

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

  final _$getAllAsyncAction = AsyncAction('TamanhoControllerBase.getAll');

  @override
  Future<List<Tamanho>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$createAsyncAction = AsyncAction('TamanhoControllerBase.create');

  @override
  Future<int> create(Tamanho p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('TamanhoControllerBase.update');

  @override
  Future<int> update(int id, Tamanho p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  @override
  String toString() {
    return '''
tamanhos: ${tamanhos},
tamanho: ${tamanho},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem}
    ''';
  }
}
