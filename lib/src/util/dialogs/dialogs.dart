import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class Dialogs {
  information(BuildContext context, String title) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text(title)),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                CircularProgressor(),
                Divider(),
                Center(
                  child: Text("aguarde um momento..."),
                )
              ],
            ),
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "CANCELAR",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
