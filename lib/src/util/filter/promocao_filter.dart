class PromocaoFilter {
  int id;
  String nomePromocao;
  int promocaoTipo;
  int loja;
  String dataInicio;
  String dataFinal;
  bool status;

  PromocaoFilter({
    this.id,
    this.nomePromocao,
    this.promocaoTipo,
    this.loja,
    this.dataInicio,
    this.dataFinal,
    this.status,
  });
}
