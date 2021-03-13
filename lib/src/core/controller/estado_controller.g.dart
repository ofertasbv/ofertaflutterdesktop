// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estado_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EstadoController on EstadoControllerBase, Store {
  final _$estadosAtom = Atom(name: 'EstadoControllerBase.estados');

  @override
  List<Estado> get estados {
    _$estadosAtom.reportRead();
    return super.estados;
  }

  @override
  set estados(List<Estado> value) {
    _$estadosAtom.reportWrite(value, super.estados, () {
      super.estados = value;
    });
  }

  final _$estadoAtom = Atom(name: 'EstadoControllerBase.estado');

  @override
  int get estado {
    _$estadoAtom.reportRead();
    return super.estado;
  }

  @override
  set estado(int value) {
    _$estadoAtom.reportWrite(value, super.estado, () {
      super.estado = value;
    });
  }

  final _$errorAtom = Atom(name: 'EstadoControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'EstadoControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'EstadoControllerBase.mensagem');

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

  final _$getAllAsyncAction = AsyncAction('EstadoControllerBase.getAll');

  @override
  Future<List<Estado>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$createAsyncAction = AsyncAction('EstadoControllerBase.create');

  @override
  Future<int> create(Estado p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('EstadoControllerBase.update');

  @override
  Future<int> update(int id, Estado p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  @override
  String toString() {
    return '''
estados: ${estados},
estado: ${estado},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem}
    ''';
  }
}
