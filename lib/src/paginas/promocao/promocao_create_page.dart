import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/controller/loja_controller.dart';
import 'package:nosso/src/core/controller/promocao_controller.dart';
import 'package:nosso/src/core/controller/promocaotipo_controller.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/core/model/promocao.dart';
import 'package:nosso/src/core/model/promocaotipo.dart';
import 'package:nosso/src/core/model/uploadFileResponse.dart';
import 'package:nosso/src/paginas/promocao/promocao_page.dart';
import 'package:nosso/src/util/componentes/image_source_sheet.dart';
import 'package:nosso/src/util/dialogs/dialogs.dart';
import 'package:nosso/src/util/dropdown/dropdown_loja.dart';
import 'package:nosso/src/util/dropdown/dropdown_promocaotipo.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';
import 'package:nosso/src/util/upload/upload_response.dart';
import 'package:nosso/src/util/validador/validador_promocao.dart';

class PromocaoCreatePage extends StatefulWidget {
  Promocao promocao;

  PromocaoCreatePage({Key key, this.promocao}) : super(key: key);

  @override
  _PromocaoCreatePageState createState() =>
      _PromocaoCreatePageState(p: promocao);
}

class _PromocaoCreatePageState extends State<PromocaoCreatePage>
    with ValidadorPromocao {
  _PromocaoCreatePageState({this.p});

  var promocaoController = GetIt.I.get<PromoCaoController>();
  var promocaoTipoController = GetIt.I.get<PromocaoTipoController>();
  var lojaController = GetIt.I.get<LojaController>();
  var uploadFileResponse = UploadFileResponse();
  var response = UploadRespnse();

  Dialogs dialogs = Dialogs();

  Promocao p;
  PromocaoTipo promocaoTipo;
  Loja lojaSelecionada;
  File file;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  var descontoController = TextEditingController();

  @override
  void initState() {
    if (p == null) {
      p = Promocao();
    } else {
      descontoController.text = p.desconto.toStringAsFixed(2);
      lojaController.lojaSelecionada = p.loja;
    }

    promocaoController.getAll();
    super.initState();
  }

  Controller controller;

  @override
  void didChangeDependencies() {
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
      var url = await promocaoController.upload(file, p.foto);

      print("url: ${url}");

      print("========= UPLOAD FILE RESPONSE ========= ");

      uploadFileResponse = response.response(uploadFileResponse, url);

      print("fileName: ${uploadFileResponse.fileName}");
      print("fileDownloadUri: ${uploadFileResponse.fileDownloadUri}");
      print("fileType: ${uploadFileResponse.fileType}");
      print("size: ${uploadFileResponse.size}");

      p.foto = uploadFileResponse.fileName;

      showSnackbar(context, "Arquivo anexada com sucesso!");
    }
  }

  showToast(String cardTitle) {
    Fluttertoast.showToast(
      msg: "$cardTitle",
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
        title: p.nome == null ? Text("Cadastro de promoção") : Text(p.nome),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 100, right: 100, top: 10),
        child: Observer(
          builder: (context) {
            if (promocaoController.dioError == null) {
              return buildListViewForm(context);
            } else {
              print("Erro: ${promocaoController.mensagem}");
              showToast("${promocaoController.mensagem}");
              return buildListViewForm(context);
            }
          },
        ),
      ),
    );
  }

  buildListViewForm(BuildContext context) {
    var focus = FocusScope.of(context);
    var dateFormat = DateFormat('dd/MM/yyyy');
    var numberFormat = NumberFormat("00.00");

    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                                : p.foto != null
                                    ? CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(
                                          promocaoController.arquivo + p.foto,
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
                  color: Colors.grey[300],
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RaisedButton(
                              child: Icon(Icons.delete_forever),
                              shape: new CircleBorder(),
                              onPressed: isEnabledDelete
                                  ? () => promocaoController.deleteFoto(p.foto)
                                  : null,
                            ),
                            RaisedButton(
                              child: Icon(Icons.photo),
                              shape: new CircleBorder(),
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
                            RaisedButton(
                              child: Icon(Icons.check),
                              shape: new CircleBorder(),
                              onPressed: isEnabledEnviar
                                  ? () => onClickUpload()
                                  : null,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ExpansionTile(
                  title: Text("Descrição"),
                  children: [
                    uploadFileResponse.fileName != null
                        ? Container(
                            height: 400,
                            padding: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: ListTile(
                                    title: Text("fileName"),
                                    subtitle:
                                        Text("${uploadFileResponse.fileName}"),
                                  ),
                                ),
                                Container(
                                  child: ListTile(
                                    title: Text("fileDownloadUri"),
                                    subtitle: Text(
                                        "${uploadFileResponse.fileDownloadUri}"),
                                  ),
                                ),
                                Container(
                                  child: ListTile(
                                    title: Text("fileType"),
                                    subtitle:
                                        Text("${uploadFileResponse.fileType}"),
                                  ),
                                ),
                                Container(
                                  child: ListTile(
                                    title: Text("size"),
                                    subtitle:
                                        Text("${uploadFileResponse.size}"),
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
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        initialValue: p.nome,
                        onSaved: (value) => p.nome = value,
                        validator: validateNome,
                        decoration: InputDecoration(
                          labelText: "Título",
                          hintText: "título promoção",
                          prefixIcon: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(Icons.close),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple[900]),
                            gapPadding: 1,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType: TextInputType.text,
                        maxLength: 100,
                        maxLines: null,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        initialValue: p.descricao,
                        onSaved: (value) => p.descricao = value,
                        validator: validateDescricao,
                        decoration: InputDecoration(
                          labelText: "Descrição",
                          hintText: "descrição promoção",
                          prefixIcon: Icon(
                            Icons.description,
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(Icons.close),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple[900]),
                            gapPadding: 1,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        maxLength: 100,
                        maxLines: null,
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: descontoController,
                        onSaved: (value) => p.desconto = double.tryParse(value),
                        validator: validateDesconto,
                        decoration: InputDecoration(
                          labelText: "Percentual de desconto",
                          hintText: "deconto",
                          prefixIcon: Icon(
                            Icons.monetization_on,
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(Icons.close),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple[900]),
                            gapPadding: 1,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        maxLength: 10,
                      ),
                      SizedBox(height: 10),
                      DateTimeField(
                        initialValue: p.dataRegistro,
                        format: dateFormat,
                        validator: validateDateRegsitro,
                        onSaved: (value) => p.dataRegistro = value,
                        decoration: InputDecoration(
                          labelText: "data registro",
                          hintText: "99-09-9999",
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(Icons.close),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple[900]),
                            gapPadding: 1,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            initialDate: currentValue ?? DateTime.now(),
                            locale: Locale('pt', 'BR'),
                            lastDate: DateTime(2030),
                          );
                        },
                        maxLength: 10,
                      ),
                      SizedBox(height: 10),
                      DateTimeField(
                        initialValue: p.dataInicio,
                        format: dateFormat,
                        validator: validateDateInicio,
                        onSaved: (value) => p.dataInicio = value,
                        decoration: InputDecoration(
                          labelText: "data inicio",
                          hintText: "99-09-9999",
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(Icons.close),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple[900]),
                            gapPadding: 1,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            initialDate: currentValue ?? DateTime.now(),
                            locale: Locale('pt', 'BR'),
                            lastDate: DateTime(2030),
                          );
                        },
                        maxLength: 10,
                      ),
                      SizedBox(height: 10),
                      DateTimeField(
                        initialValue: p.dataFinal,
                        format: dateFormat,
                        validator: validateDateFinal,
                        onSaved: (value) => p.dataFinal = value,
                        decoration: InputDecoration(
                          labelText: "data encerramento",
                          hintText: "99-09-9999",
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(Icons.close),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple[900]),
                            gapPadding: 1,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            initialDate: currentValue ?? DateTime.now(),
                            locale: Locale('pt', 'BR'),
                            lastDate: DateTime(2030),
                          );
                        },
                        maxLength: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0),
                DropDownPromocaoTipo(promocaoTipo),
                Observer(
                  builder: (context) {
                    if (promocaoTipoController.promocaoTipoSelecionada ==
                        null) {
                      return Container(
                        padding: EdgeInsets.only(left: 25),
                        child: Container(
                          child: promocaoTipoController.mensagem == null
                              ? Text(
                                  "campo obrigatório *",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                )
                              : Text(
                                  "${lojaController.mensagem}",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                        ),
                      );
                    }
                    return Container(
                      padding: EdgeInsets.only(left: 25),
                      child: Container(
                        child: Icon(Icons.check_outlined, color: Colors.green),
                      ),
                    );
                  },
                ),
                DropDownLoja(lojaSelecionada),
                Observer(
                  builder: (context) {
                    if (lojaController.lojaSelecionada == null) {
                      return Container(
                        padding: EdgeInsets.only(left: 25),
                        child: Container(
                          child: lojaController.mensagem == null
                              ? Text(
                                  "campo obrigatório *",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                )
                              : Text(
                                  "${lojaController.mensagem}",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                        ),
                      );
                    }
                    return Container(
                      padding: EdgeInsets.only(left: 25),
                      child: Container(
                        child: Icon(Icons.check_outlined, color: Colors.green),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 0),
        Container(
          padding: EdgeInsets.all(15),
          child: RaisedButton.icon(
              label: Text("Enviar formulário"),
              icon: Icon(Icons.check),
              onPressed: () {
                if (controller.validate()) {
                  // if (p.foto == null) {
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
                  if (p.id == null) {
                    dialogs.information(context, "prepando para o cadastro...");
                    Timer(Duration(seconds: 3), () {
                      p.loja = lojaController.lojaSelecionada;
                      p.promocaoTipo =
                          promocaoTipoController.promocaoTipoSelecionada;

                      print("Loja: ${p.loja.nome}");
                      print("Promoção tipo: ${p.promocaoTipo.descricao}");
                      print("Nome: ${p.nome}");
                      print("Descrição: ${p.descricao}");
                      print("Foto: ${p.foto}");
                      print("Desconto: ${p.desconto}");
                      print("Resgistro: ${dateFormat.format(p.dataRegistro)}");
                      print("Início: ${dateFormat.format(p.dataInicio)}");
                      print("Final: ${dateFormat.format(p.dataFinal)}");

                      promocaoController.create(p).then((value) {
                        print("resultado : ${value}");
                      });
                      Navigator.of(context).pop();
                      buildPush(context);
                    });
                  } else {
                    dialogs.information(
                        context, "preparando para o alteração...");
                    Timer(Duration(seconds: 3), () {
                      p.loja = lojaController.lojaSelecionada;
                      p.promocaoTipo =
                          promocaoTipoController.promocaoTipoSelecionada;

                      print("Loja: ${p.loja.nome}");
                      print("Promoção tipo: ${p.promocaoTipo.descricao}");
                      print("Nome: ${p.nome}");
                      print("Descrição: ${p.descricao}");
                      print("Foto: ${p.foto}");
                      print("Desconto: ${p.desconto}");
                      print("Resgistro: ${dateFormat.format(p.dataRegistro)}");
                      print("Início: ${dateFormat.format(p.dataInicio)}");
                      print("Final: ${dateFormat.format(p.dataFinal)}");

                      promocaoController.update(p.id, p);
                      Navigator.of(context).pop();
                      buildPush(context);
                    });
                  }
                }
              }
              // },
              ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  buildPush(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PromocaoPage(),
      ),
    );
  }

  alertSelectLojas(BuildContext context, Loja c) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 300.0,
            child: builderConteudoList(),
          ),
        );
      },
    );
  }

  builderConteudoList() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Loja> categorias = lojaController.lojas;
          if (lojaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (categorias == null) {
            return CircularProgressorMini();
          }

          return builderListCategorias(categorias);
        },
      ),
    );
  }

  builderListCategorias(List<Loja> lojas) {
    double containerWidth = 160;
    double containerHeight = 20;

    return ListView.separated(
      itemCount: lojas.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) {
        Loja c = lojas[index];

        return GestureDetector(
          child: ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                "${ConstantApi.urlArquivoLoja + c.foto}",
              ),
            ),
            title: Text(c.nome),
          ),
          onTap: () {
            setState(() {
              lojaSelecionada = c;
              print("${lojaSelecionada.nome}");
            });
            Navigator.of(context).pop();
          },
        );
      },
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
