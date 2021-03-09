// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagamento_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PagamentoController on PagamentoControllerBase, Store {
  final _$pagamentosAtom = Atom(name: 'PagamentoControllerBase.pagamentos');

  @override
  List<Pagamento> get pagamentos {
    _$pagamentosAtom.reportRead();
    return super.pagamentos;
  }

  @override
  set pagamentos(List<Pagamento> value) {
    _$pagamentosAtom.reportWrite(value, super.pagamentos, () {
      super.pagamentos = value;
    });
  }

  final _$pagamentoAtom = Atom(name: 'PagamentoControllerBase.pagamento');

  @override
  int get pagamento {
    _$pagamentoAtom.reportRead();
    return super.pagamento;
  }

  @override
  set pagamento(int value) {
    _$pagamentoAtom.reportWrite(value, super.pagamento, () {
      super.pagamento = value;
    });
  }

  final _$errorAtom = Atom(name: 'PagamentoControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'PagamentoControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'PagamentoControllerBase.mensagem');

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

  final _$getAllAsyncAction = AsyncAction('PagamentoControllerBase.getAll');

  @override
  Future<List<Pagamento>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$createAsyncAction = AsyncAction('PagamentoControllerBase.create');

  @override
  Future<int> create(Pagamento p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('PagamentoControllerBase.update');

  @override
  Future<int> update(int id, Pagamento p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  @override
  String toString() {
    return '''
pagamentos: ${pagamentos},
pagamento: ${pagamento},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem}
    ''';
  }
}
