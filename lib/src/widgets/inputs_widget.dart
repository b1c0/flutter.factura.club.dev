import 'package:flutter/material.dart';

class InputWidget {
  Widget crearEmail() {
    return Column(children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: Icon(Icons.alternate_email),
            hintText: 'ejemplo@email.com',
            labelText: 'Correo electrónico',
          ),
        ),
      ),
      SizedBox(height: 20.0)
    ]);
  }

  Widget crearNombreUsuario() {
    return Column(children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          decoration: InputDecoration(
            icon: Icon(Icons.supervised_user_circle_sharp),
            hintText: 'Usuario',
            labelText: 'Nombre de Usuario',
          ),
        ),
      ),
      SizedBox(height: 20.0)
    ]);
  }

  Widget crearPassword() {
    return Column(children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(Icons.lock_outline),
            hintText: 'Contraseña',
            labelText: 'Contraseña',
          ),
        ),
      ),
      SizedBox(height: 20.0)
    ]);
  }

  Widget crearInputText(String texto, String hint) {
    return TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: hint,
        labelText: texto,
      ),
    );
  }

  Widget crearInputNumber(String texto, String hint) {
    return TextField(
      // autofocus: true,
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: hint,
        labelText: texto,
      ),
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropDown(List<String> opciones) {
    List<DropdownMenuItem<String>> lista = List();
    opciones.forEach((poder) {
      lista.add(DropdownMenuItem(
        child: Text(poder),
        value: poder,
      ));
    });
    return lista;
  }

  Widget crearDropDown(String opcionSeleccionada, List<String> opciones) {
    return Row(
      children: [
        SizedBox(width: 10.0),
        Expanded(
          child: DropdownButton(
              value: opcionSeleccionada,
              items: getOpcionesDropDown(opciones),
              onChanged: (opt) {
                opcionSeleccionada = opt;
              }),
        )
      ],
    );
  }
}