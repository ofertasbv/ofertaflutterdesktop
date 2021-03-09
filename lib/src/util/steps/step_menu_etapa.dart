import 'package:flutter/material.dart';
import 'package:steps/steps.dart';

class StepMenuEtapa extends StatelessWidget {
  Color colorPedido;
  Color colorPagamento;
  Color colorConfirmacao;

  StepMenuEtapa({this.colorPedido, this.colorPagamento, this.colorConfirmacao});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Container(
        height: 70,
        alignment: Alignment.topCenter,
        child: Steps(
          direction: Axis.horizontal,
          size: 10.0,
          path: {'color': Colors.orangeAccent, 'width': 2.0},
          steps: [
            {
              'color': Colors.white,
              'background': colorPedido,
              'label': '1',
              'content': Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Pedido',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            },
            {
              'color': Colors.white,
              'background': colorPagamento,
              'label': '2',
              'content': Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Pagamento',
                    style: TextStyle(fontSize: 10.0),
                  ),
                ],
              )
            },
            {
              'color': Colors.white,
              'background': colorConfirmacao,
              'label': '3',
              'content': Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Confirmação',
                    style: TextStyle(fontSize: 10.0),
                  ),
                ],
              )
            }
          ],
        ),
      ),
    );
  }
}
