import 'package:nosso/src/core/enum/fatura_status.dart';
import 'package:nosso/src/core/model/pagamento.dart';

class Fatura {
  int id;
  String numeroFatura;
  DateTime dataRegistro;
  DateTime dataEmissao;
  DateTime dataPagamento;
  DateTime dataPedidoCancelamento;
  double valorPago;
  FaturaStatus faturaStatus;
  Pagamento pagamento;

  Fatura({
    this.id,
    this.numeroFatura,
    this.dataRegistro,
    this.dataEmissao,
    this.dataPagamento,
    this.dataPedidoCancelamento,
    this.valorPago,
    this.faturaStatus,
    this.pagamento,
  });

  Fatura.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    numeroFatura = json['numeroFatura'];
    dataRegistro = DateTime.tryParse(json['dataRegistro'].toString());
    dataEmissao = DateTime.tryParse(json['dataEmissao'].toString());
    dataPagamento = DateTime.tryParse(json['dataPagamento'].toString());
    dataPedidoCancelamento =
        DateTime.tryParse(json['dataPedidoCancelamento'].toString());
    valorPago = json['valorPago'];
    faturaStatus = json['faturaStatus'];

    pagamento = json['pagamento'] != null
        ? new Pagamento.fromJson(json['pagamento'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['numeroFatura'] = this.numeroFatura;
    data['dataRegistro'] = this.dataRegistro.toIso8601String();
    data['dataEmissao'] = this.dataEmissao.toIso8601String();
    data['dataPagamento'] = this.dataPagamento.toIso8601String();
    data['dataPedidoCancelamento'] =
        this.dataPedidoCancelamento.toIso8601String();
    data['valorPago'] = this.valorPago;
    data['faturaStatus'] = this.faturaStatus;

    if (this.pagamento != null) {
      data['pagamento'] = this.pagamento.toJson();
    }
    return data;
  }
}
