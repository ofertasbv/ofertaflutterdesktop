class PromocaoFilter {
  int id;
  String nomePromocao;
  int promocaoTipo;
  int loja;
  DateTime dataInicio;
  DateTime dataEncerramento;

  PromocaoFilter({
    this.id,
    this.nomePromocao,
    this.promocaoTipo,
    this.loja,
    this.dataInicio,
    this.dataEncerramento,
  });
}
