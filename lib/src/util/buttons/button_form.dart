import 'package:flutter/material.dart';

class ButtonForm extends StatelessWidget {
  Function enviarForm;

  ButtonForm(this.enviarForm);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: RaisedButton.icon(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        label: Text(
          "Enviar formulário",
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.check,
          color: Colors.white,
        ),
        textColor: Colors.white,
        splashColor: Colors.red,
        color: Colors.black,
        onPressed: () {
          this.enviarForm;
        },
      ),
    );
  }
}
