// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arquivo_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ArquivoController on ArquivoControllerBase, Store {
  final _$arquivosAtom = Atom(name: 'ArquivoControllerBase.arquivos');

  @override
  List<Arquivo> get arquivos {
    _$arquivosAtom.reportRead();
    return super.arquivos;
  }

  @override
  set arquivos(List<Arquivo> value) {
    _$arquivosAtom.reportWrite(value, super.arquivos, () {
      super.arquivos = value;
    });
  }

  final _$arquivoAtom = Atom(name: 'ArquivoControllerBase.arquivo');

  @override
  int get arquivo {
    _$arquivoAtom.reportRead();
    return super.arquivo;
  }

  @override
  set arquivo(int value) {
    _$arquivoAtom.reportWrite(value, super.arquivo, () {
      super.arquivo = value;
    });
  }

  final _$formDataAtom = Atom(name: 'ArquivoControllerBase.formData');

  @override
  dynamic get formData {
    _$formDataAtom.reportRead();
    return super.formData;
  }

  @override
  set formData(dynamic value) {
    _$formDataAtom.reportWrite(value, super.formData, () {
      super.formData = value;
    });
  }

  final _$errorAtom = Atom(name: 'ArquivoControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'ArquivoControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'ArquivoControllerBase.mensagem');

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

  final _$arquivoFotoAtom = Atom(name: 'ArquivoControllerBase.arquivoFoto');

  @override
  String get arquivoFoto {
    _$arquivoFotoAtom.reportRead();
    return super.arquivoFoto;
  }

  @override
  set arquivoFoto(String value) {
    _$arquivoFotoAtom.reportWrite(value, super.arquivoFoto, () {
      super.arquivoFoto = value;
    });
  }

  final _$getAllAsyncAction = AsyncAction('ArquivoControllerBase.getAll');

  @override
  Future<List<Arquivo>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$createAsyncAction = AsyncAction('ArquivoControllerBase.create');

  @override
  Future<int> create(Arquivo p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('ArquivoControllerBase.update');

  @override
  Future<int> update(int id, Arquivo p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  final _$uploadAsyncAction = AsyncAction('ArquivoControllerBase.upload');

  @override
  Future<String> upload(File foto, String fileName) {
    return _$uploadAsyncAction.run(() => super.upload(foto, fileName));
  }

  final _$deleteFotoAsyncAction =
      AsyncAction('ArquivoControllerBase.deleteFoto');

  @override
  Future<void> deleteFoto(String foto) {
    return _$deleteFotoAsyncAction.run(() => super.deleteFoto(foto));
  }

  @override
  String toString() {
    return '''
arquivos: ${arquivos},
arquivo: ${arquivo},
formData: ${formData},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem},
arquivoFoto: ${arquivoFoto}
    ''';
  }
}
