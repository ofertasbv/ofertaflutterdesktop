class PromocaoFilter {
  int id;
  String nomePromocao;
  int promocaoTipo;
  int loja;
  String dataInicio;
  String dataFinal;

  PromocaoFilter({
    this.id,
    this.nomePromocao,
    this.promocaoTipo,
    this.loja,
    this.dataInicio,
    this.dataFinal,
  });

  // PromocaoFilter.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   nomePromocao = json['nomePromocao'];
  //   promocaoTipo = json['promocaoTipo'];
  //   loja = json['loja'];
  //
  //   dataInicio = DateTime.tryParse(json['dataInicio'].toString());
  //   dataFinal = DateTime.tryParse(json['dataFinal'].toString());
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['nomePromocao'] = this.nomePromocao;
  //   data['promocaoTipo'] = this.promocaoTipo;
  //   data['loja'] = this.loja;
  //
  //   data['dataInicio'] = this.dataInicio.toIso8601String();
  //   data['dataFinal'] = this.dataFinal.toIso8601String();
  //
  //   return data;
  // }
}
