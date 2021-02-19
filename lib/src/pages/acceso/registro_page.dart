import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  bool terminosCondiciones = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _fondo(context),
          _formularioLogin(context),
        ],
      ),
    );
  }

  Widget _fondo(BuildContext context) {
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
      ],
    );
  }

  Widget _formularioLogin(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(child: Container(height: size.height * 0.03)),
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
                Text('Registro', style: TextStyle(fontSize: 20.0)),
                _crearEmail(),
                _crearUsuario(),
                _crearPassword(),
                _crearVerificarPassword(),
                _crearTerminosCondiciones(),
                _crearBotonRegistrar(),
                _crearbotonLogin(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearEmail() {
    return Column(children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: Icon(Icons.alternate_email),
            hintText: 'ejemplo@ejemplo.com',
            labelText: 'Correo electrónico',
          ),
        ),
      ),
      SizedBox(height: 20.0)
    ]);
  }

  Widget _crearUsuario() {
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

  Widget _crearPassword() {
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

  Widget _crearVerificarPassword() {
    return Column(children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(Icons.lock_outline),
            hintText: 'Verificar Contraseña',
            labelText: 'Verificar Contraseña',
          ),
        ),
      ),
      SizedBox(height: 20.0)
    ]);
  }

  Widget _crearTerminosCondiciones() {
    return Column(
      children: [
        Row(children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Checkbox(
                value: terminosCondiciones,
                onChanged: (value) {
                  setState(() {
                    terminosCondiciones = value;
                  });
                },
              )),
          Text(
            'Acepto los términos y condiciones',
            overflow: TextOverflow.visible,
          )
        ]),
        SizedBox(height: 20.0)
      ],
    );
  }

  Widget _crearBotonRegistrar() {
    return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 85.0, vertical: 15.0),
          child: Text('Registrar', style: TextStyle(fontSize: 18)),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 0.0,
        color: Colors.blueAccent,
        textColor: Colors.white,
        onPressed: _registro);
  }

  Widget _crearbotonLogin(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.0),
        FlatButton(
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
            child: Text(
              '¿Ya tienes cuenta? Inicia Sesión!',
              style: TextStyle(color: Colors.blue, fontSize: 16.0),
            ))
      ],
    );
  }

  _registro() {
    print('registrando');
  }
}
