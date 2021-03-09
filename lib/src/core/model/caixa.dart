class Caixa {
  int id;
  String descricao;
  String referencia;
  DateTime dataRegistro;
  String caixaStatus;
  bool status;

  Caixa({
    this.id,
    this.descricao,
    this.referencia,
    this.dataRegistro,
    this.caixaStatus,
    this.status,
  });

  Caixa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    referencia = json['referencia'];
    dataRegistro = DateTime.tryParse(json['dataRegistro'].toString());
    caixaStatus = json['caixaStatus'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    data['referencia'] = this.referencia;
    data['dataRegistro'] = this.dataRegistro.toIso8601String();

    data['caixaStatus'] = this.caixaStatus;
    data['status'] = this.status;
    return data;
  }
}
