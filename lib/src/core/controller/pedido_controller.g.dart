// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pedido_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PedidoController on PedidoControllerBase, Store {
  final _$valorTotalAtom = Atom(name: 'PedidoControllerBase.valorTotal');

  @override
  double get valorTotal {
    _$valorTotalAtom.reportRead();
    return super.valorTotal;
  }

  @override
  set valorTotal(double value) {
    _$valorTotalAtom.reportWrite(value, super.valorTotal, () {
      super.valorTotal = value;
    });
  }

  final _$descontoAtom = Atom(name: 'PedidoControllerBase.desconto');

  @override
  double get desconto {
    _$descontoAtom.reportRead();
    return super.desconto;
  }

  @override
  set desconto(double value) {
    _$descontoAtom.reportWrite(value, super.desconto, () {
      super.desconto = value;
    });
  }

  final _$totalAtom = Atom(name: 'PedidoControllerBase.total');

  @override
  double get total {
    _$totalAtom.reportRead();
    return super.total;
  }

  @override
  set total(double value) {
    _$totalAtom.reportWrite(value, super.total, () {
      super.total = value;
    });
  }

  final _$totalDescontoAtom = Atom(name: 'PedidoControllerBase.totalDesconto');

  @override
  double get totalDesconto {
    _$totalDescontoAtom.reportRead();
    return super.totalDesconto;
  }

  @override
  set totalDesconto(double value) {
    _$totalDescontoAtom.reportWrite(value, super.totalDesconto, () {
      super.totalDesconto = value;
    });
  }

  final _$pedidosAtom = Atom(name: 'PedidoControllerBase.pedidos');

  @override
  List<Pedido> get pedidos {
    _$pedidosAtom.reportRead();
    return super.pedidos;
  }

  @override
  set pedidos(List<Pedido> value) {
    _$pedidosAtom.reportWrite(value, super.pedidos, () {
      super.pedidos = value;
    });
  }

  final _$pedidoAtom = Atom(name: 'PedidoControllerBase.pedido');

  @override
  int get pedido {
    _$pedidoAtom.reportRead();
    return super.pedido;
  }

  @override
  set pedido(int value) {
    _$pedidoAtom.reportWrite(value, super.pedido, () {
      super.pedido = value;
    });
  }

  final _$errorAtom = Atom(name: 'PedidoControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'PedidoControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'PedidoControllerBase.mensagem');

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

  final _$getAllAsyncAction = AsyncAction('PedidoControllerBase.getAll');

  @override
  Future<List<Pedido>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$createAsyncAction = AsyncAction('PedidoControllerBase.create');

  @override
  Future<int> create(Pedido p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('PedidoControllerBase.update');

  @override
  Future<int> update(int id, Pedido p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  final _$PedidoControllerBaseActionController =
      ActionController(name: 'PedidoControllerBase');

  @override
  double calculateDesconto() {
    final _$actionInfo = _$PedidoControllerBaseActionController.startAction(
        name: 'PedidoControllerBase.calculateDesconto');
    try {
      return super.calculateDesconto();
    } finally {
      _$PedidoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
valorTotal: ${valorTotal},
desconto: ${desconto},
total: ${total},
totalDesconto: ${totalDesconto},
pedidos: ${pedidos},
pedido: ${pedido},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem}
    ''';
  }
}
