// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produto_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProdutoController on ProdutoControllerBase, Store {
  final _$produtosAtom = Atom(name: 'ProdutoControllerBase.produtos');

  @override
  List<Produto> get produtos {
    _$produtosAtom.reportRead();
    return super.produtos;
  }

  @override
  set produtos(List<Produto> value) {
    _$produtosAtom.reportWrite(value, super.produtos, () {
      super.produtos = value;
    });
  }

  final _$produtosByLojaAtom =
      Atom(name: 'ProdutoControllerBase.produtosByLoja');

  @override
  List<Produto> get produtosByLoja {
    _$produtosByLojaAtom.reportRead();
    return super.produtosByLoja;
  }

  @override
  set produtosByLoja(List<Produto> value) {
    _$produtosByLojaAtom.reportWrite(value, super.produtosByLoja, () {
      super.produtosByLoja = value;
    });
  }

  final _$produtoAtom = Atom(name: 'ProdutoControllerBase.produto');

  @override
  int get produto {
    _$produtoAtom.reportRead();
    return super.produto;
  }

  @override
  set produto(int value) {
    _$produtoAtom.reportWrite(value, super.produto, () {
      super.produto = value;
    });
  }

  final _$produtoSelecionadoAtom =
      Atom(name: 'ProdutoControllerBase.produtoSelecionado');

  @override
  Produto get produtoSelecionado {
    _$produtoSelecionadoAtom.reportRead();
    return super.produtoSelecionado;
  }

  @override
  set produtoSelecionado(Produto value) {
    _$produtoSelecionadoAtom.reportWrite(value, super.produtoSelecionado, () {
      super.produtoSelecionado = value;
    });
  }

  final _$arquivoAtom = Atom(name: 'ProdutoControllerBase.arquivo');

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

  final _$formDataAtom = Atom(name: 'ProdutoControllerBase.formData');

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

  final _$errorAtom = Atom(name: 'ProdutoControllerBase.error');

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

  final _$dioErrorAtom = Atom(name: 'ProdutoControllerBase.dioError');

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

  final _$mensagemAtom = Atom(name: 'ProdutoControllerBase.mensagem');

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

  final _$corSelecionadasAtom =
      Atom(name: 'ProdutoControllerBase.corSelecionadas');

  @override
  List<Cor> get corSelecionadas {
    _$corSelecionadasAtom.reportRead();
    return super.corSelecionadas;
  }

  @override
  set corSelecionadas(List<Cor> value) {
    _$corSelecionadasAtom.reportWrite(value, super.corSelecionadas, () {
      super.corSelecionadas = value;
    });
  }

  final _$tamanhoSelecionadosAtom =
      Atom(name: 'ProdutoControllerBase.tamanhoSelecionados');

  @override
  List<Tamanho> get tamanhoSelecionados {
    _$tamanhoSelecionadosAtom.reportRead();
    return super.tamanhoSelecionados;
  }

  @override
  set tamanhoSelecionados(List<Tamanho> value) {
    _$tamanhoSelecionadosAtom.reportWrite(value, super.tamanhoSelecionados, () {
      super.tamanhoSelecionados = value;
    });
  }

  final _$statusAtom = Atom(name: 'ProdutoControllerBase.status');

  @override
  bool get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(bool value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$getAllAsyncAction = AsyncAction('ProdutoControllerBase.getAll');

  @override
  Future<List<Produto>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$getFilterAsyncAction = AsyncAction('ProdutoControllerBase.getFilter');

  @override
  Future<List<Produto>> getFilter(ProdutoFilter filter) {
    return _$getFilterAsyncAction.run(() => super.getFilter(filter));
  }

  final _$getAllByNomeAsyncAction =
      AsyncAction('ProdutoControllerBase.getAllByNome');

  @override
  Future<List<Produto>> getAllByNome(String nome) {
    return _$getAllByNomeAsyncAction.run(() => super.getAllByNome(nome));
  }

  final _$getAllBySubCategoriaByIdAsyncAction =
      AsyncAction('ProdutoControllerBase.getAllBySubCategoriaById');

  @override
  Future<List<Produto>> getAllBySubCategoriaById(int id) {
    return _$getAllBySubCategoriaByIdAsyncAction
        .run(() => super.getAllBySubCategoriaById(id));
  }

  final _$getAllByLojaByIdAsyncAction =
      AsyncAction('ProdutoControllerBase.getAllByLojaById');

  @override
  Future<List<Produto>> getAllByLojaById(int id) {
    return _$getAllByLojaByIdAsyncAction.run(() => super.getAllByLojaById(id));
  }

  final _$getCodigoBarraAsyncAction =
      AsyncAction('ProdutoControllerBase.getCodigoBarra');

  @override
  Future<Produto> getCodigoBarra(String codBarra) {
    return _$getCodigoBarraAsyncAction
        .run(() => super.getCodigoBarra(codBarra));
  }

  final _$createAsyncAction = AsyncAction('ProdutoControllerBase.create');

  @override
  Future<int> create(Produto p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('ProdutoControllerBase.update');

  @override
  Future<int> update(int id, Produto p) {
    return _$updateAsyncAction.run(() => super.update(id, p));
  }

  final _$uploadAsyncAction = AsyncAction('ProdutoControllerBase.upload');

  @override
  Future<String> upload(File foto, String fileName) {
    return _$uploadAsyncAction.run(() => super.upload(foto, fileName));
  }

  final _$deleteFotoAsyncAction =
      AsyncAction('ProdutoControllerBase.deleteFoto');

  @override
  Future<void> deleteFoto(String foto) {
    return _$deleteFotoAsyncAction.run(() => super.deleteFoto(foto));
  }

  final _$ProdutoControllerBaseActionController =
      ActionController(name: 'ProdutoControllerBase');

  @override
  dynamic favoritar() {
    final _$actionInfo = _$ProdutoControllerBaseActionController.startAction(
        name: 'ProdutoControllerBase.favoritar');
    try {
      return super.favoritar();
    } finally {
      _$ProdutoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addCores(Cor cor) {
    final _$actionInfo = _$ProdutoControllerBaseActionController.startAction(
        name: 'ProdutoControllerBase.addCores');
    try {
      return super.addCores(cor);
    } finally {
      _$ProdutoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addTamanhos(Tamanho tamanho) {
    final _$actionInfo = _$ProdutoControllerBaseActionController.startAction(
        name: 'ProdutoControllerBase.addTamanhos');
    try {
      return super.addTamanhos(tamanho);
    } finally {
      _$ProdutoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removerCores(Cor cor) {
    final _$actionInfo = _$ProdutoControllerBaseActionController.startAction(
        name: 'ProdutoControllerBase.removerCores');
    try {
      return super.removerCores(cor);
    } finally {
      _$ProdutoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removerTamanhos(Tamanho tamanho) {
    final _$actionInfo = _$ProdutoControllerBaseActionController.startAction(
        name: 'ProdutoControllerBase.removerTamanhos');
    try {
      return super.removerTamanhos(tamanho);
    } finally {
      _$ProdutoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void limparCores() {
    final _$actionInfo = _$ProdutoControllerBaseActionController.startAction(
        name: 'ProdutoControllerBase.limparCores');
    try {
      return super.limparCores();
    } finally {
      _$ProdutoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void limparTamanhos() {
    final _$actionInfo = _$ProdutoControllerBaseActionController.startAction(
        name: 'ProdutoControllerBase.limparTamanhos');
    try {
      return super.limparTamanhos();
    } finally {
      _$ProdutoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
produtos: ${produtos},
produtosByLoja: ${produtosByLoja},
produto: ${produto},
produtoSelecionado: ${produtoSelecionado},
arquivo: ${arquivo},
formData: ${formData},
error: ${error},
dioError: ${dioError},
mensagem: ${mensagem},
corSelecionadas: ${corSelecionadas},
tamanhoSelecionados: ${tamanhoSelecionados},
status: ${status}
    ''';
  }
}
