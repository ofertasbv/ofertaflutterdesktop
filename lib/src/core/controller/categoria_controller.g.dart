// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoria_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategoriaController on CategoriaControllerBase, Store {
  final _$categoriasAtom = Atom(name: 'CategoriaControllerBase.categorias');

  @override
  List<Categoria> get categorias {
    _$categoriasAtom.reportRead();
    return super.categorias;
  }

  @override
  set categorias(List<Categoria> value) {
    _$categoriasAtom.reportWrite(value, super.categorias, () {
      super.categorias = value;
    });
  }

  final _$categoriaAtom = Atom(name: 'CategoriaControllerBase.categoria');

  @override
  int get categoria {
    _$categoriaAtom.reportRead();
    return super.categoria;
  }

  @override
  set categoria(int value) {
    _$categoriaAtom.reportWrite(value, super.categoria, () {
      super.categoria = value;
    });
  }

  final _$formDataAtom = Atom(name: 'CategoriaControllerBase.formData');

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

  final _$errorAtom = Atom(name: 'CategoriaControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'CategoriaControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'CategoriaControllerBase.mensagem');

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

  final _$categoriaSelecionadaAtom =
      Atom(name: 'CategoriaControllerBase.categoriaSelecionada');

  @override
  Categoria get categoriaSelecionada {
    _$categoriaSelecionadaAtom.reportRead();
    return super.categoriaSelecionada;
  }

  @override
  set categoriaSelecionada(Categoria value) {
    _$categoriaSelecionadaAtom.reportWrite(value, super.categoriaSelecionada,
        () {
      super.categoriaSelecionada = value;
    });
  }

  final _$arquivoAtom = Atom(name: 'CategoriaControllerBase.arquivo');

  @override
  String get arquivo {
    _$arquivoAtom.reportRead();
    return super.arquivo;
  }

  @override
  set arquivo(String value) {
    _$arquivoAtom.reportWrite(value, super.arquivo, () {
      super.arquivo = value;
    });
  }

  final _$getAllAsyncAction = AsyncAction('CategoriaControllerBase.getAll');

  @override
  Future<List<Categoria>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$getAllByNomeAsyncAction =
      AsyncAction('CategoriaControllerBase.getAllByNome');

  @override
  Future<List<Categoria>> getAllByNome(String nome) {
    return _$getAllByNomeAsyncAction.run(() => super.getAllByNome(nome));
  }

  final _$createAsyncAction = AsyncAction('CategoriaControllerBase.create');

  @override
  Future<int> create(Categoria p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('CategoriaControllerBase.update');

  @override
  Future<int> update(int id, Categoria p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  final _$uploadAsyncAction = AsyncAction('CategoriaControllerBase.upload');

  @override
  Future<String> upload(File foto, String fileName) {
    return _$uploadAsyncAction.run(() => super.upload(foto, fileName));
  }

  final _$deleteFotoAsyncAction =
      AsyncAction('CategoriaControllerBase.deleteFoto');

  @override
  Future<void> deleteFoto(String foto) {
    return _$deleteFotoAsyncAction.run(() => super.deleteFoto(foto));
  }

  @override
  String toString() {
    return '''
categorias: ${categorias},
categoria: ${categoria},
formData: ${formData},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem},
categoriaSelecionada: ${categoriaSelecionada},
arquivo: ${arquivo}
    ''';
  }
}
