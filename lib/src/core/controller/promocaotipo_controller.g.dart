// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promocaotipo_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PromocaoTipoController on PromocaoTipoControllerBase, Store {
  final _$promocaoTiposAtom =
      Atom(name: 'PromocaoTipoControllerBase.promocaoTipos');

  @override
  List<PromocaoTipo> get promocaoTipos {
    _$promocaoTiposAtom.reportRead();
    return super.promocaoTipos;
  }

  @override
  set promocaoTipos(List<PromocaoTipo> value) {
    _$promocaoTiposAtom.reportWrite(value, super.promocaoTipos, () {
      super.promocaoTipos = value;
    });
  }

  final _$promocaoTipoAtom =
      Atom(name: 'PromocaoTipoControllerBase.promocaoTipo');

  @override
  int get promocaoTipo {
    _$promocaoTipoAtom.reportRead();
    return super.promocaoTipo;
  }

  @override
  set promocaoTipo(int value) {
    _$promocaoTipoAtom.reportWrite(value, super.promocaoTipo, () {
      super.promocaoTipo = value;
    });
  }

  final _$promocaoTipoSelecionadaAtom =
      Atom(name: 'PromocaoTipoControllerBase.promocaoTipoSelecionada');

  @override
  PromocaoTipo get promocaoTipoSelecionada {
    _$promocaoTipoSelecionadaAtom.reportRead();
    return super.promocaoTipoSelecionada;
  }

  @override
  set promocaoTipoSelecionada(PromocaoTipo value) {
    _$promocaoTipoSelecionadaAtom
        .reportWrite(value, super.promocaoTipoSelecionada, () {
      super.promocaoTipoSelecionada = value;
    });
  }

  final _$errorAtom = Atom(name: 'PromocaoTipoControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'PromocaoTipoControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'PromocaoTipoControllerBase.mensagem');

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

  final _$getAllAsyncAction = AsyncAction('PromocaoTipoControllerBase.getAll');

  @override
  Future<List<PromocaoTipo>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$createAsyncAction = AsyncAction('PromocaoTipoControllerBase.create');

  @override
  Future<int> create(PromocaoTipo p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('PromocaoTipoControllerBase.update');

  @override
  Future<int> update(int id, PromocaoTipo p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  @override
  String toString() {
    return '''
promocaoTipos: ${promocaoTipos},
promocaoTipo: ${promocaoTipo},
promocaoTipoSelecionada: ${promocaoTipoSelecionada},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem}
    ''';
  }
}
