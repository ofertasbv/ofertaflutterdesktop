import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/subcategoria_controller.dart';
import 'package:nosso/src/core/model/subcategoria.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';

class DialogSubCategoria extends StatefulWidget {
  SubCategoria subCategoria;
  DialogSubCategoria(this.subCategoria);
  @override
  _DialogSubCategoriaState createState() =>
      _DialogSubCategoriaState(this.subCategoria);
}

class _DialogSubCategoriaState extends State<DialogSubCategoria> {
  _DialogSubCategoriaState(this.subCategoria);

  var subCategoriaController = GetIt.I.get<SubCategoriaController>();

  SubCategoria subCategoria;

  @override
  void initState() {
    subCategoriaController.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return builderConteudoListSubCategorias();
  }

  builderConteudoListSubCategorias() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<SubCategoria> subCategorias =
              subCategoriaController.subCategorias;
          if (subCategoriaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (subCategorias == null) {
            return CircularProgressorMini();
          }

          return builderListSubCategorias(subCategorias);
        },
      ),
    );
  }

  builderListSubCategorias(List<SubCategoria> subCategorias) {
    double containerWidth = 160;
    double containerHeight = 20;

    return ListView.builder(
      itemCount: subCategorias.length,
      itemBuilder: (context, index) {
        SubCategoria c = subCategorias[index];

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
                subCategoriaController.subCategoriaSelecionada = c;
                print(
                    "SubCategoria: ${subCategoriaController.subCategoriaSelecionada.nome}");
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

class AlertSubCategoria {
  alert(BuildContext context, SubCategoria subCategoria) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 300.0,
            child: DialogSubCategoria(subCategoria),
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
