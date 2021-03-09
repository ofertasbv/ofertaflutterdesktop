class ProdutoFilter {
  int id;
  String nomeProduto;
  int subCategoria;
  int marca;
  int origem;
  int promocao;
  int loja;
  int cidade;
  double valorMinimo;
  double valorMaximo;

  ProdutoFilter({
    this.id,
    this.nomeProduto,
    this.subCategoria,
    this.marca,
    this.origem,
    this.promocao,
    this.loja,
    this.cidade,
    this.valorMinimo,
    this.valorMaximo,
  });
}
