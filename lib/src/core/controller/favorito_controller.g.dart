// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorito_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FavoritoController on FavoritoControllerBase, Store {
  final _$favoritosAtom = Atom(name: 'FavoritoControllerBase.favoritos');

  @override
  List<Favorito> get favoritos {
    _$favoritosAtom.reportRead();
    return super.favoritos;
  }

  @override
  set favoritos(List<Favorito> value) {
    _$favoritosAtom.reportWrite(value, super.favoritos, () {
      super.favoritos = value;
    });
  }

  final _$favoritoAtom = Atom(name: 'FavoritoControllerBase.favorito');

  @override
  int get favorito {
    _$favoritoAtom.reportRead();
    return super.favorito;
  }

  @override
  set favorito(int value) {
    _$favoritoAtom.reportWrite(value, super.favorito, () {
      super.favorito = value;
    });
  }

  final _$errorAtom = Atom(name: 'FavoritoControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'FavoritoControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'FavoritoControllerBase.mensagem');

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

  final _$getAllAsyncAction = AsyncAction('FavoritoControllerBase.getAll');

  @override
  Future<List<Favorito>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$createAsyncAction = AsyncAction('FavoritoControllerBase.create');

  @override
  Future<int> create(Favorito p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('FavoritoControllerBase.update');

  @override
  Future<int> update(int id, Favorito p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  @override
  String toString() {
    return '''
favoritos: ${favoritos},
favorito: ${favorito},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem}
    ''';
  }
}
