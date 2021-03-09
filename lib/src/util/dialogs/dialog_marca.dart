import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/marca_controller.dart';
import 'package:nosso/src/core/model/marca.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';

class DialogMarca extends StatefulWidget {
  Marca marca;
  DialogMarca(this.marca);

  @override
  _DialogMarcaState createState() => _DialogMarcaState(this.marca);
}

class _DialogMarcaState extends State<DialogMarca> {
  _DialogMarcaState(this.marca);

  var marcaController = GetIt.I.get<MarcaController>();

  Marca marca;

  @override
  void initState() {
    marcaController.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return builderConteudoListMarca();
  }

  builderConteudoListMarca() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Marca> marcas = marcaController.marcas;
          if (marcaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (marcas == null) {
            return CircularProgressorMini();
          }

          return builderListMarcas(marcas);
        },
      ),
    );
  }

  builderListMarcas(List<Marca> marcas) {
    double containerWidth = 160;
    double containerHeight = 20;

    return ListView.builder(
      itemCount: marcas.length,
      itemBuilder: (context, index) {
        Marca c = marcas[index];

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
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    radius: 15,
                    child: Text(
                      c.nome.substring(0, 1).toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                title: Text(c.nome),
              ),
              onTap: () {
                marcaController.marcaSelecionada = c;
                print("Marca: ${marcaController.marcaSelecionada.nome}");
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

class AlertMarca {
  alert(BuildContext context, Marca marca) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 300.0,
            child: DialogMarca(marca),
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
