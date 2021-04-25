import 'dart:async';
import 'dart:core';

import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/arquivo_controller.dart';
import 'package:nosso/src/core/model/arquivo.dart';
import 'package:nosso/src/core/model/uploadFileResponse.dart';
import 'package:nosso/src/paginas/arquivo/arquivo_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nosso/src/util/dialogs/dialogs.dart';
import 'package:nosso/src/util/upload/upload_response.dart';

class ArquivoCreatePage extends StatefulWidget {
  Arquivo arquivo;

  ArquivoCreatePage({Key key, this.arquivo}) : super(key: key);

  @override
  _ArquivoCreatePageState createState() => _ArquivoCreatePageState(a: arquivo);
}

class _ArquivoCreatePageState extends State<ArquivoCreatePage> {
  var arquivoController = GetIt.I.get<ArquivoController>();
  Dialogs dialogs = Dialogs();

  Arquivo a;
  File arquivo;
  var picker = ImagePicker();
  PickedFile pickedFile;
  bool isButtonDesable = false;

  var uploadFileResponse = UploadFileResponse();
  var response = UploadRespnse();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  _ArquivoCreatePageState({this.a});

  var controllerNome = TextEditingController();

  @override
  void initState() {
    arquivoController.getAll();
    if (a == null) {
      a = Arquivo();
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

  Future<void> teste() async {
    final FileSystem fs = MemoryFileSystem();
    final Directory tmp = await fs.systemTempDirectory.createTemp('example_');
    final File outputFile = tmp.childFile('output');
    await outputFile.writeAsString('Hello world!');
    print(outputFile.readAsStringSync());
  }

  // onClickUpload() async {
  //   if (file != null) {
  //     var url = await arquivoController.upload(file, a.foto);
  //
  //     print("url: ${url}");
  //
  //     print("========= UPLOAD FILE RESPONSE ========= ");
  //
  //     uploadFileResponse = response.response(uploadFileResponse, url);
  //
  //     print("fileName: ${uploadFileResponse.fileName}");
  //     print("fileDownloadUri: ${uploadFileResponse.fileDownloadUri}");
  //     print("fileType: ${uploadFileResponse.fileType}");
  //     print("size: ${uploadFileResponse.size}");
  //
  //     a.foto = uploadFileResponse.fileName;
  //
  //     setState(() {
  //       uploadFileResponse;
  //     });
  //
  //     showSnackbar(context, "Arquivo anexada com sucesso!");
  //   }
  // }

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
        title: Text("Arquivos cadastros"),
      ),
      // body: Observer(
      //   builder: (context) {
      //     if (arquivoController.dioError == null) {
      //       return buildListViewForm(context);
      //     } else {
      //       print("Erro: ${arquivoController.mensagem}");
      //       showToast("${arquivoController.mensagem}");
      //       return buildListViewForm(context);
      //     }
      //   },
      // ),
      body: Text("arquivo vazio"),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          // result = await FilePicker.platform.pickFiles();
          //
          // if (result != null) {
          //   file = result.files.first;
          //   // arquivo.writeAsBytes(file.bytes);
          //
          //   print(file.name);
          //   print(file.size);
          //   print(file.extension);
          //   print(file.path);
          // } else {}
          arquivo = ImagePicker().getImage(source: ImageSource.gallery) as File;
          print("picker: ${arquivo.absolute}");
        },
      ),
    );
  }

  // buildListViewForm(BuildContext context) {
  //   return ListView(
  //     children: <Widget>[
  //       Container(
  //         padding: EdgeInsets.all(0),
  //         color: Colors.grey[300],
  //         child: Form(
  //           key: controller.formKey,
  //           child: Column(
  //             children: <Widget>[
  //               Container(
  //                 height: 350,
  //                 color: Colors.grey[400],
  //                 child: GestureDetector(
  //                   onTap: () {
  //                     showModalBottomSheet(
  //                       context: context,
  //                       builder: (context) => ImageSourceSheet(
  //                         onImageSelected: (image) {
  //                           setState(() {
  //                             Navigator.of(context).pop();
  //                             file = image;
  //                             String arquivo = file.path.split('/').last;
  //                             print("Image: ${arquivo}");
  //                             enableButton();
  //                           });
  //                         },
  //                       ),
  //                     );
  //                   },
  //                   child: Container(
  //                     color: Colors.grey[600],
  //                     padding: EdgeInsets.all(5),
  //                     child: Container(
  //                       width: double.infinity,
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: <Widget>[
  //                           file != null
  //                               ? Image.file(
  //                                   file,
  //                                   fit: BoxFit.fitWidth,
  //                                   width: double.infinity,
  //                                   height: 340,
  //                                 )
  //                               : a.foto != null
  //                                   ? CircleAvatar(
  //                                       radius: 50,
  //                                       backgroundImage: NetworkImage(
  //                                         arquivoController.arquivoFoto +
  //                                             a.foto,
  //                                       ),
  //                                     )
  //                                   : CircleAvatar(
  //                                       radius: 50,
  //                                       child: Icon(
  //                                         Icons.camera_alt_outlined,
  //                                       ),
  //                                     ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 padding: EdgeInsets.all(5),
  //                 child: Column(
  //                   children: <Widget>[
  //                     Container(
  //                       padding: EdgeInsets.all(10),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: <Widget>[
  //                           CircleAvatar(
  //                             child: IconButton(
  //                               splashColor: Colors.black,
  //                               icon: Icon(Icons.delete_forever),
  //                               onPressed: isEnabledDelete
  //                                   ? () => arquivoController.deleteFoto(a.foto)
  //                                   : null,
  //                             ),
  //                           ),
  //                           CircleAvatar(
  //                             child: IconButton(
  //                               splashColor: Colors.black,
  //                               icon: Icon(Icons.photo),
  //                               onPressed: () {
  //                                 showModalBottomSheet(
  //                                   context: context,
  //                                   builder: (context) => ImageSourceSheet(
  //                                     onImageSelected: (image) {
  //                                       setState(() {
  //                                         Navigator.of(context).pop();
  //                                         file = image;
  //                                         String arquivo =
  //                                             file.path.split('/').last;
  //                                         print("Image: ${arquivo}");
  //                                         enableButton();
  //                                       });
  //                                     },
  //                                   ),
  //                                 );
  //                               },
  //                             ),
  //                           ),
  //                           CircleAvatar(
  //                             child: IconButton(
  //                               splashColor: Colors.black,
  //                               icon: Icon(Icons.check),
  //                               onPressed: isEnabledEnviar
  //                                   ? () => onClickUpload()
  //                                   : null,
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       ExpansionTile(
  //         title: Text("Descrição"),
  //         children: [
  //           uploadFileResponse.fileName != null
  //               ? Container(
  //                   height: 300,
  //                   padding: EdgeInsets.all(5),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Container(
  //                         child: ListTile(
  //                           title: Text("fileName"),
  //                           subtitle: Text("${uploadFileResponse.fileName}"),
  //                         ),
  //                       ),
  //                       Container(
  //                         child: ListTile(
  //                           title: Text("fileDownloadUri"),
  //                           subtitle:
  //                               Text("${uploadFileResponse.fileDownloadUri}"),
  //                         ),
  //                       ),
  //                       Container(
  //                         child: ListTile(
  //                           title: Text("fileType"),
  //                           subtitle: Text("${uploadFileResponse.fileType}"),
  //                         ),
  //                       ),
  //                       Container(
  //                         child: ListTile(
  //                           title: Text("size"),
  //                           subtitle: Text("${uploadFileResponse.size}"),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               : Container(
  //                   padding: EdgeInsets.all(15),
  //                   child: Text("Deve anexar uma foto"),
  //                   alignment: Alignment.bottomLeft,
  //                 ),
  //         ],
  //       ),
  //       SizedBox(height: 20),
  //       Container(
  //         padding: EdgeInsets.all(15),
  //         child: RaisedButton.icon(
  //           label: Text("Enviar formulário"),
  //           icon: Icon(Icons.check),
  //           onPressed: () {
  //             if (controller.validate()) {
  //               if (a.foto == null) {
  //                 showModalBottomSheet(
  //                   context: context,
  //                   builder: (context) => ImageSourceSheet(
  //                     onImageSelected: (image) {
  //                       setState(() {
  //                         Navigator.of(context).pop();
  //                         file = image;
  //                         String arquivo = file.path.split('/').last;
  //                         print("Image: ${arquivo}");
  //                         enableButton();
  //                       });
  //                     },
  //                   ),
  //                 );
  //               } else {
  //                 if (a.id == null) {
  //                   dialogs.information(context, "prepando para o cadastro...");
  //                   Timer(Duration(seconds: 3), () {
  //                     print("Foto : ${a.foto}");
  //
  //                     arquivoController.create(a).then((value) {
  //                       print("resultado : ${value}");
  //                     });
  //                     Navigator.of(context).pop();
  //                     buildPush(context);
  //                   });
  //                 } else {
  //                   dialogs.information(
  //                       context, "preparando para o alteração...");
  //                   Timer(Duration(seconds: 3), () {
  //                     print("Foto : ${a.foto}");
  //
  //                     arquivoController.update(a.id, a);
  //                     Navigator.of(context).pop();
  //                     buildPush(context);
  //                   });
  //                 }
  //               }
  //             }
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  buildPush(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArquivoPage(),
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
