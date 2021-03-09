import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/vendedor_controller.dart';
import 'package:nosso/src/core/model/vendedor.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';

class DialogVendedor extends StatefulWidget {
  Vendedor vendedor;

  DialogVendedor(this.vendedor);

  @override
  _DialogVendedorState createState() => _DialogVendedorState(this.vendedor);
}

class _DialogVendedorState extends State<DialogVendedor> {
  _DialogVendedorState(this.vendedor);

  var vendedorController = GetIt.I.get<VendedorController>();

  Vendedor vendedor;

  @override
  void initState() {
    vendedorController.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return builderConteudoListvendedors();
  }

  builderConteudoListvendedors() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Vendedor> vendedores = vendedorController.vendedores;
          if (vendedorController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (vendedores == null) {
            return CircularProgressorMini();
          }

          return builderListvendedors(vendedores);
        },
      ),
    );
  }

  builderListvendedors(List<Vendedor> vendedores) {
    double containerWidth = 160;
    double containerHeight = 20;

    return ListView.builder(
      itemCount: vendedores.length,
      itemBuilder: (context, index) {
        Vendedor c = vendedores[index];

        return Column(
          children: [
            GestureDetector(
              child: ListTile(
                leading: Container(
                  padding: EdgeInsets.all(1),
                  decoration: new BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.grey[900]],
                    ),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: c.foto != null
                      ? CircleAvatar(
                          backgroundColor: Colors.grey[100],
                          radius: 20,
                          backgroundImage: NetworkImage(
                            "${vendedorController.arquivo + c.foto}",
                          ),
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.grey[100],
                          radius: 20,
                          child: Icon(Icons.photo),
                        ),
                ),
                title: Text(c.nome),
              ),
              onTap: () {
                vendedorController.vendedoreSelecionado = c;
                print(
                    "vendedor: ${vendedorController.vendedoreSelecionado.nome}");
                Navigator.of(context).pop();
              },
            ),
            Divider()
          ],
        );
      },
    );
  }
}

class AlertVendedor {
  alert(BuildContext context, Vendedor vendedor) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 300.0,
            child: DialogVendedor(vendedor),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("ok"),
            )
          ],
        );
      },
    );
  }
}
