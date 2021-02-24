import 'dart:ui';

import 'package:app_factura_club_dev/src/widgets/inputs_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  InputWidget input = InputWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _fondoLogin(context),
          _formularioLogin(context),
        ],
      ),
    );
  }

  Widget _fondoLogin(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //variable donde se almacena el degradado del fondo
    final fondo = Container(
      height: size.height,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: <Color>[
          Color.fromRGBO(119, 149, 248, 1.0),
          Color.fromRGBO(103, 115, 194, 1.0),
        ],
      )),
    );
    //varibale donde se almacenan los circulos de decoración
    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.06),
      ),
    );

    return Stack(
      children: [
        fondo,
        Positioned(child: circulo, top: 100.0, left: 10.0),
        Positioned(child: circulo, top: 20.0, right: 30.0),
        Positioned(child: circulo, top: 200.0, right: 80.0),
        Positioned(child: circulo, top: 160.0, right: 30.0),
        Positioned(child: circulo, bottom: 200.0, left: 50.0),
        Positioned(child: circulo, bottom: 20.0, right: 20.0),
        Container(
          padding: EdgeInsets.only(top: 50.0),
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Image(
              image: AssetImage('assets/img/white.png'),
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }

  Widget _formularioLogin(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(child: Container(height: size.height * 0.2)),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 10.0),
            padding: EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0), boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
                blurRadius: 3.0,
                offset: Offset(0.0, 5.0),
                spreadRadius: 2.0,
              )
            ]),
            child: Column(
              children: [
                Text('Iniciar Sesión', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 30.0),
                input.crearEmail(),
                input.crearNombreUsuario(),
                input.crearPassword(),
                _botonIngresar(context),
                _botonRegistrar(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _botonIngresar(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return RaisedButton(
      child: Text('Ingresar'),
      padding: EdgeInsets.only(right: size.width * 0.25, left: size.width * 0.25),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 0.0,
      color: Colors.blueAccent,
      textColor: Colors.white,
      onPressed: () => _login(context),
    );
  }

  Widget _botonRegistrar(BuildContext context) {
    return FlatButton(
        child: Text(
          '¿No tienes cuenta? Registrate!',
          style: TextStyle(color: Colors.blue),
        ),
        onPressed: () => {
              Navigator.pushReplacementNamed(context, 'registro'),
            });
  }

  _login(BuildContext context) {
    //TODO: Validar el login
    Navigator.pushReplacementNamed(context, 'home');
  }
}
