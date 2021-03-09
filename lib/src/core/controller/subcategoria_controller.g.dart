// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subcategoria_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SubCategoriaController on SubCategoriaControllerBase, Store {
  final _$subCategoriasAtom =
      Atom(name: 'SubCategoriaControllerBase.subCategorias');

  @override
  List<SubCategoria> get subCategorias {
    _$subCategoriasAtom.reportRead();
    return super.subCategorias;
  }

  @override
  set subCategorias(List<SubCategoria> value) {
    _$subCategoriasAtom.reportWrite(value, super.subCategorias, () {
      super.subCategorias = value;
    });
  }

  final _$subCategoriaAtom =
      Atom(name: 'SubCategoriaControllerBase.subCategoria');

  @override
  int get subCategoria {
    _$subCategoriaAtom.reportRead();
    return super.subCategoria;
  }

  @override
  set subCategoria(int value) {
    _$subCategoriaAtom.reportWrite(value, super.subCategoria, () {
      super.subCategoria = value;
    });
  }

  final _$errorAtom = Atom(name: 'SubCategoriaControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'SubCategoriaControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'SubCategoriaControllerBase.mensagem');

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
      Atom(name: 'SubCategoriaControllerBase.categoriaSelecionada');

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

  final _$subCategoriaSelecionadaAtom =
      Atom(name: 'SubCategoriaControllerBase.subCategoriaSelecionada');

  @override
  SubCategoria get subCategoriaSelecionada {
    _$subCategoriaSelecionadaAtom.reportRead();
    return super.subCategoriaSelecionada;
  }

  @override
  set subCategoriaSelecionada(SubCategoria value) {
    _$subCategoriaSelecionadaAtom
        .reportWrite(value, super.subCategoriaSelecionada, () {
      super.subCategoriaSelecionada = value;
    });
  }

  final _$getAllAsyncAction = AsyncAction('SubCategoriaControllerBase.getAll');

  @override
  Future<List<SubCategoria>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$getAllByNomeAsyncAction =
      AsyncAction('SubCategoriaControllerBase.getAllByNome');

  @override
  Future<List<SubCategoria>> getAllByNome(String nome) {
    return _$getAllByNomeAsyncAction.run(() => super.getAllByNome(nome));
  }

  final _$getAllByCategoriaByIdAsyncAction =
      AsyncAction('SubCategoriaControllerBase.getAllByCategoriaById');

  @override
  Future<List<SubCategoria>> getAllByCategoriaById(int id) {
    return _$getAllByCategoriaByIdAsyncAction
        .run(() => super.getAllByCategoriaById(id));
  }

  final _$createAsyncAction = AsyncAction('SubCategoriaControllerBase.create');

  @override
  Future<int> create(SubCategoria p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('SubCategoriaControllerBase.update');

  @override
  Future<int> update(int id, SubCategoria p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  @override
  String toString() {
    return '''
subCategorias: ${subCategorias},
subCategoria: ${subCategoria},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem},
categoriaSelecionada: ${categoriaSelecionada},
subCategoriaSelecionada: ${subCategoriaSelecionada}
    ''';
  }
}
