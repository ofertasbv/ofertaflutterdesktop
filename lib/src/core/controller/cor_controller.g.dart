// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cor_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CorController on CorControllerBase, Store {
  final _$coresAtom = Atom(name: 'CorControllerBase.cores');

  @override
  List<Cor> get cores {
    _$coresAtom.reportRead();
    return super.cores;
  }

  @override
  set cores(List<Cor> value) {
    _$coresAtom.reportWrite(value, super.cores, () {
      super.cores = value;
    });
  }

  final _$corAtom = Atom(name: 'CorControllerBase.cor');

  @override
  int get cor {
    _$corAtom.reportRead();
    return super.cor;
  }

  @override
  set cor(int value) {
    _$corAtom.reportWrite(value, super.cor, () {
      super.cor = value;
    });
  }

  final _$errorAtom = Atom(name: 'CorControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'CorControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'CorControllerBase.mensagem');

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

  final _$getAllAsyncAction = AsyncAction('CorControllerBase.getAll');

  @override
  Future<List<Cor>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$createAsyncAction = AsyncAction('CorControllerBase.create');

  @override
  Future<int> create(Cor p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('CorControllerBase.update');

  @override
  Future<int> update(int id, Cor p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  @override
  String toString() {
    return '''
cores: ${cores},
cor: ${cor},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem}
    ''';
  }
}
