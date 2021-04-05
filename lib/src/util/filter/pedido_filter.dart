class PedidoFilter {
  int id;
  String descricao;
  int cliente;
  int loja;
  String dataRegistro;
  String dataEntrega;
  bool status;
  String pedidoStatus;

  PedidoFilter({
    this.id,
    this.descricao,
    this.cliente,
    this.dataRegistro,
    this.dataEntrega,
    this.status,
    this.pedidoStatus,
  });
}
