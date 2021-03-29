import 'dart:async';
import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nosso/src/util/webview/web_view_site.dart';

class LeitorQRCode extends StatefulWidget {
  @override
  _LeitorQRCodeState createState() => new _LeitorQRCodeState();
}

class _LeitorQRCodeState extends State<LeitorQRCode> {
  String barcode = "";
  String urlSite;

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  File galleryFile;

  imageSelectorGallery() async {
    // galleryFile = await ImagePicker.pickImage(
    //   source: ImageSource.gallery,
    //   // maxHeight: 50.0,
    //   // maxWidth: 50.0,
    // );
    print("You selected gallery image : " + galleryFile.path);
    setState(() {});
  }

  void showToast(String cardTitle) {
    Fluttertoast.showToast(
      msg: "Atenção: $cardTitle",
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leitor qr code'),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (urlSite == null) {
                showToast("endereço de navegação vazio!");
                print("nada");
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return WebViewSite(urlSite);
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.grey[200],
                  Colors.grey[300],
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff676B76).withOpacity(0.2),
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                urlSite != null
                    ? Text(urlSite)
                    : ListTile(
                        title: Text(
                          "USE O SCANNER PARA LER O QR CODE",
                          style: TextStyle(color: Colors.black),
                        ),
                        leading: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.black,
                        ),
                        onTap: () {
                          barcodeScanning();
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 10,
        label: Text("Scanner"),
        icon: Icon(Icons.camera_enhance),
        onPressed: () {
          barcodeScanning();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  displayImage() {
    return new SizedBox(
      height: 300.0,
      width: 400.0,
      child: galleryFile == null
          ? Text('Sorry nothing to display')
          : Image.file(galleryFile),
    );
  }

// Method for scanning barcode....
  Future barcodeScanning() async {
    //imageSelectorGallery();
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        this.barcode = barcode;
        urlSite = this.barcode;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'Permissão negada!';
        });
      } else {
        setState(() => this.barcode = 'Ops! erro: $e');
      }
    } on FormatException {
      setState(() => this.barcode = 'Nada capturado.');
    } catch (e) {
      setState(() => this.barcode = 'Erros: $e');
    }
  }
}
