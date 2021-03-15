import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/controller/categoria_controller.dart';
import 'package:nosso/src/core/model/categoria.dart';
import 'package:nosso/src/core/model/uploadFileResponse.dart';
import 'package:nosso/src/paginas/categoria/categoria_page.dart';
import 'package:nosso/src/util/componentes/image_source_sheet.dart';
import 'package:nosso/src/util/dialogs/dialogs.dart';
import 'package:nosso/src/util/upload/upload_response.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CategoriaCreatePage extends StatefulWidget {
  Categoria categoria;

  CategoriaCreatePage({Key key, this.categoria}) : super(key: key);

  @override
  _CategoriaCreatePageState createState() =>
      _CategoriaCreatePageState(c: categoria);
}

class _CategoriaCreatePageState extends State<CategoriaCreatePage> {
  var categoriaController = GetIt.I.get<CategoriaController>();
  Dialogs dialogs = Dialogs();

  Categoria c;
  File file;
  bool isButtonDesable = false;

  var uploadFileResponse = UploadFileResponse();
  var response = UploadRespnse();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  _CategoriaCreatePageState({this.c});

  var controllerNome = TextEditingController();

  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
      c.color = pickerColor.toString();
      print("Cor selecionada: ${c.color}");
    });
  }

  @override
  void initState() {
    categoriaController.getAll();
    if (c == null) {
      c = Categoria();
    }
    super.initState();
  }

  Controller controller;

  @override
  didChangeDependencies() {
    controller = Controller();
    super.didChangeDependencies();
  }

  bool isEnabledEnviar = false;
  bool isEnabledDelete = false;

  enableButton() {
    setState(() {
      isEnabledEnviar = true;
    });
  }

  disableButton() {
    setState(() {
      isEnabledDelete = true;
    });
  }

  onClickUpload() async {
    if (file != null) {
      var url = await categoriaController.upload(file, c.foto);

      print("url: ${url}");

      print("========= UPLOAD FILE RESPONSE ========= ");

      uploadFileResponse = response.response(uploadFileResponse, url);

      print("fileName: ${uploadFileResponse.fileName}");
      print("fileDownloadUri: ${uploadFileResponse.fileDownloadUri}");
      print("fileType: ${uploadFileResponse.fileType}");
      print("size: ${uploadFileResponse.size}");

      c.foto = uploadFileResponse.fileName;

      setState(() {
        uploadFileResponse;
      });

      showSnackbar(context, "Arquivo anexada com sucesso!");
    }
  }

  showToast(String descricao) {
    Fluttertoast.showToast(
      msg: descricao,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 10,
      fontSize: 16.0,
    );
  }

  showSnackbar(BuildContext context, String content) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(content),
        action: SnackBarAction(
          label: "OK",
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 50,
        title: c.nome == null ? Text("Cadastro de categoria") : Text(c.nome),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 100, right: 100, top: 10),
        child: Observer(
          builder: (context) {
            if (categoriaController.dioError == null) {
              return buildListViewForm(context);
            } else {
              print("Erro: ${categoriaController.mensagem}");
              showToast("${categoriaController.mensagem}");
              return buildListViewForm(context);
            }
          },
        ),
      ),
    );
  }

  ListView buildListViewForm(BuildContext context) {
    var focus = FocusScope.of(context);
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0),
          color: Colors.grey[300],
          child: Form(
            key: controller.formKey,
            child: Column(
              children: <Widget>[
                Container(
                  height: 350,
                  color: Colors.grey[400],
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => ImageSourceSheet(
                          onImageSelected: (image) {
                            setState(() {
                              Navigator.of(context).pop();
                              file = image;
                              String arquivo = file.path.split('/').last;
                              print("Image: ${arquivo}");
                              enableButton();
                            });
                          },
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.grey[600],
                      padding: EdgeInsets.all(5),
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            file != null
                                ? Image.file(
                                    file,
                                    fit: BoxFit.fitWidth,
                                    width: double.infinity,
                                    height: 340,
                                  )
                                : c.foto != null
                                    ? CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(
                                          categoriaController.arquivo + c.foto,
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 50,
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                        ),
                                      ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CircleAvatar(
                              child: IconButton(
                                splashColor: Colors.black,
                                icon: Icon(Icons.delete_forever),
                                onPressed: isEnabledDelete
                                    ? () =>
                                        categoriaController.deleteFoto(c.foto)
                                    : null,
                              ),
                            ),
                            CircleAvatar(
                              child: IconButton(
                                splashColor: Colors.black,
                                icon: Icon(Icons.photo),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => ImageSourceSheet(
                                      onImageSelected: (image) {
                                        setState(() {
                                          Navigator.of(context).pop();
                                          file = image;
                                          String arquivo =
                                              file.path.split('/').last;
                                          print("Image: ${arquivo}");
                                          enableButton();
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                            CircleAvatar(
                              child: IconButton(
                                splashColor: Colors.black,
                                icon: Icon(Icons.check),
                                onPressed: isEnabledEnviar
                                    ? () => onClickUpload()
                                    : null,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        initialValue: c.nome,
                        onSaved: (value) => c.nome = value,
                        validator: (value) =>
                            value.isEmpty ? "campo obrigatório" : null,
                        decoration: InputDecoration(
                          labelText: "Nome",
                          hintText: "entre com o nome",
                          prefixIcon: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lime[900]),
                            gapPadding: 1,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType: TextInputType.text,
                        maxLength: 50,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        ColorPicker(
          pickerColor: pickerColor,
          onColorChanged: changeColor,
          showLabel: true,
          pickerAreaHeightPercent: 0.8,
        ),
        ExpansionTile(
          title: Text("Descrição"),
          children: [
            uploadFileResponse.fileName != null
                ? Container(
                    height: 300,
                    padding: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: ListTile(
                            title: Text("fileName"),
                            subtitle: Text("${uploadFileResponse.fileName}"),
                          ),
                        ),
                        Container(
                          child: ListTile(
                            title: Text("fileDownloadUri"),
                            subtitle:
                                Text("${uploadFileResponse.fileDownloadUri}"),
                          ),
                        ),
                        Container(
                          child: ListTile(
                            title: Text("fileType"),
                            subtitle: Text("${uploadFileResponse.fileType}"),
                          ),
                        ),
                        Container(
                          child: ListTile(
                            title: Text("size"),
                            subtitle: Text("${uploadFileResponse.size}"),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(15),
                    child: Text("Deve anexar uma foto"),
                    alignment: Alignment.bottomLeft,
                  ),
          ],
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(15),
          child: RaisedButton.icon(
              label: Text("Enviar formulário"),
              icon: Icon(Icons.check),
              onPressed: () {
                if (controller.validate()) {
                  // if (c.foto == null) {
                  //   showModalBottomSheet(
                  //     context: context,
                  //     builder: (context) => ImageSourceSheet(
                  //       onImageSelected: (image) {
                  //         setState(() {
                  //           Navigator.of(context).pop();
                  //           file = image;
                  //           String arquivo = file.path.split('/').last;
                  //           print("Image: ${arquivo}");
                  //           enableButton();
                  //         });
                  //       },
                  //     ),
                  //   );
                  // } else {
                  if (c.id == null) {
                    dialogs.information(context, "prepando para o cadastro...");
                    Timer(Duration(seconds: 3), () {
                      categoriaController.create(c).then((value) {
                        print("resultado : ${value}");
                      });
                      Navigator.of(context).pop();
                      buildPush(context);
                    });
                  } else {
                    dialogs.information(
                        context, "preparando para o alteração...");
                    Timer(Duration(seconds: 3), () {
                      categoriaController.update(c.id, c);
                      Navigator.of(context).pop();
                      buildPush(context);
                    });
                  }
                }
              }
              // },
              ),
        ),
      ],
    );
  }

  buildPush(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoriaPage(),
      ),
    );
  }
}

class Controller {
  var formKey = GlobalKey<FormState>();

  bool validate() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else
      return false;
  }
}
