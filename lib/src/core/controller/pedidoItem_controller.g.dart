// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pedidoItem_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PedidoItemController on PedidoItemControllerBase, Store {
  final _$quantidadeAtom = Atom(name: 'PedidoItemControllerBase.quantidade');

  @override
  int get quantidade {
    _$quantidadeAtom.reportRead();
    return super.quantidade;
  }

  @override
  set quantidade(int value) {
    _$quantidadeAtom.reportWrite(value, super.quantidade, () {
      super.quantidade = value;
    });
  }

  final _$valorUnitarioAtom =
      Atom(name: 'PedidoItemControllerBase.valorUnitario');

  @override
  double get valorUnitario {
    _$valorUnitarioAtom.reportRead();
    return super.valorUnitario;
  }

  @override
  set valorUnitario(double value) {
    _$valorUnitarioAtom.reportWrite(value, super.valorUnitario, () {
      super.valorUnitario = value;
    });
  }

  final _$valorTotalAtom = Atom(name: 'PedidoItemControllerBase.valorTotal');

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

  final _$descontoAtom = Atom(name: 'PedidoItemControllerBase.desconto');

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

  final _$totalAtom = Atom(name: 'PedidoItemControllerBase.total');

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

  final _$totalDescontoAtom =
      Atom(name: 'PedidoItemControllerBase.totalDesconto');

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

  final _$pedidoItensAtom = Atom(name: 'PedidoItemControllerBase.pedidoItens');

  @override
  List<PedidoItem> get pedidoItens {
    _$pedidoItensAtom.reportRead();
    return super.pedidoItens;
  }

  @override
  set pedidoItens(List<PedidoItem> value) {
    _$pedidoItensAtom.reportWrite(value, super.pedidoItens, () {
      super.pedidoItens = value;
    });
  }

  final _$itensAtom = Atom(name: 'PedidoItemControllerBase.itens');

  @override
  List<PedidoItem> get itens {
    _$itensAtom.reportRead();
    return super.itens;
  }

  @override
  set itens(List<PedidoItem> value) {
    _$itensAtom.reportWrite(value, super.itens, () {
      super.itens = value;
    });
  }

  final _$pedidoitemAtom = Atom(name: 'PedidoItemControllerBase.pedidoitem');

  @override
  int get pedidoitem {
    _$pedidoitemAtom.reportRead();
    return super.pedidoitem;
  }

  @override
  set pedidoitem(int value) {
    _$pedidoitemAtom.reportWrite(value, super.pedidoitem, () {
      super.pedidoitem = value;
    });
  }

  final _$errorAtom = Atom(name: 'PedidoItemControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'PedidoItemControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'PedidoItemControllerBase.mensagem');

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

  final _$getAllAsyncAction = AsyncAction('PedidoItemControllerBase.getAll');

  @override
  Future<List<PedidoItem>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$createAsyncAction = AsyncAction('PedidoItemControllerBase.create');

  @override
  Future<int> create(PedidoItem p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('PedidoItemControllerBase.update');

  @override
  Future<int> update(int id, PedidoItem p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  final _$PedidoItemControllerBaseActionController =
      ActionController(name: 'PedidoItemControllerBase');

  @override
  List<PedidoItem> pedidosItens() {
    final _$actionInfo = _$PedidoItemControllerBaseActionController.startAction(
        name: 'PedidoItemControllerBase.pedidosItens');
    try {
      return super.pedidosItens();
    } finally {
      _$PedidoItemControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic adicionar(PedidoItem item) {
    final _$actionInfo = _$PedidoItemControllerBaseActionController.startAction(
        name: 'PedidoItemControllerBase.adicionar');
    try {
      return super.adicionar(item);
    } finally {
      _$PedidoItemControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic isExisteItem(PedidoItem item) {
    final _$actionInfo = _$PedidoItemControllerBaseActionController.startAction(
        name: 'PedidoItemControllerBase.isExisteItem');
    try {
      return super.isExisteItem(item);
    } finally {
      _$PedidoItemControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic incremento(PedidoItem item) {
    final _$actionInfo = _$PedidoItemControllerBaseActionController.startAction(
        name: 'PedidoItemControllerBase.incremento');
    try {
      return super.incremento(item);
    } finally {
      _$PedidoItemControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic decremento(PedidoItem item) {
    final _$actionInfo = _$PedidoItemControllerBaseActionController.startAction(
        name: 'PedidoItemControllerBase.decremento');
    try {
      return super.decremento(item);
    } finally {
      _$PedidoItemControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic remove(PedidoItem item) {
    final _$actionInfo = _$PedidoItemControllerBaseActionController.startAction(
        name: 'PedidoItemControllerBase.remove');
    try {
      return super.remove(item);
    } finally {
      _$PedidoItemControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic calculateTotal() {
    final _$actionInfo = _$PedidoItemControllerBaseActionController.startAction(
        name: 'PedidoItemControllerBase.calculateTotal');
    try {
      return super.calculateTotal();
    } finally {
      _$PedidoItemControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic calculateDesconto() {
    final _$actionInfo = _$PedidoItemControllerBaseActionController.startAction(
        name: 'PedidoItemControllerBase.calculateDesconto');
    try {
      return super.calculateDesconto();
    } finally {
      _$PedidoItemControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
quantidade: ${quantidade},
valorUnitario: ${valorUnitario},
valorTotal: ${valorTotal},
desconto: ${desconto},
total: ${total},
totalDesconto: ${totalDesconto},
pedidoItens: ${pedidoItens},
itens: ${itens},
pedidoitem: ${pedidoitem},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem}
    ''';
  }
}
