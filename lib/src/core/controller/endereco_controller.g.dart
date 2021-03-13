// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'endereco_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EnderecoController on EnderecoControllerBase, Store {
  final _$enderecosAtom = Atom(name: 'EnderecoControllerBase.enderecos');

  @override
  List<Endereco> get enderecos {
    _$enderecosAtom.reportRead();
    return super.enderecos;
  }

  @override
  set enderecos(List<Endereco> value) {
    _$enderecosAtom.reportWrite(value, super.enderecos, () {
      super.enderecos = value;
    });
  }

  final _$enderecoAtom = Atom(name: 'EnderecoControllerBase.endereco');

  @override
  int get endereco {
    _$enderecoAtom.reportRead();
    return super.endereco;
  }

  @override
  set endereco(int value) {
    _$enderecoAtom.reportWrite(value, super.endereco, () {
      super.endereco = value;
    });
  }

  final _$errorAtom = Atom(name: 'EnderecoControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'EnderecoControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'EnderecoControllerBase.mensagem');

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

  final _$enderecoSelecionadoAtom =
      Atom(name: 'EnderecoControllerBase.enderecoSelecionado');

  @override
  Endereco get enderecoSelecionado {
    _$enderecoSelecionadoAtom.reportRead();
    return super.enderecoSelecionado;
  }

  @override
  set enderecoSelecionado(Endereco value) {
    _$enderecoSelecionadoAtom.reportWrite(value, super.enderecoSelecionado, () {
      super.enderecoSelecionado = value;
    });
  }

  final _$getAllAsyncAction = AsyncAction('EnderecoControllerBase.getAll');

  @override
  Future<List<Endereco>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$getAllByPessoaAsyncAction =
      AsyncAction('EnderecoControllerBase.getAllByPessoa');

  @override
  Future<List<Endereco>> getAllByPessoa(int id) {
    return _$getAllByPessoaAsyncAction.run(() => super.getAllByPessoa(id));
  }

  final _$getCepAsyncAction = AsyncAction('EnderecoControllerBase.getCep');

  @override
  Future<Endereco> getCep(String cep) {
    return _$getCepAsyncAction.run(() => super.getCep(cep));
  }

  final _$createAsyncAction = AsyncAction('EnderecoControllerBase.create');

  @override
  Future<int> create(Endereco p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('EnderecoControllerBase.update');

  @override
  Future<int> update(int id, Endereco p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  @override
  String toString() {
    return '''
enderecos: ${enderecos},
endereco: ${endereco},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem},
enderecoSelecionado: ${enderecoSelecionado}
    ''';
  }
}
