import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/blocs/registro_usuarios_bloc.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  bool terminosCondiciones = false;
  String verificarClave = "";
  Usuario usuario = Usuario();
  RegistroUsuariosBloc regUsuarioBloc;

  @override
  Widget build(BuildContext context) {
    regUsuarioBloc = Provider.registroUsuarioBloc(context);
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
            padding: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 2.0,
                )
              ],
            ),
            child: Column(
              children: [
                Text('Registro', style: TextStyle(fontSize: 20.0)),
                _crearNombreApellido(),
                _crearNombreUsuario(),
                _crearEmail(),
                _crearTelefono(),
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
          onChanged: (value) => usuario.usuarioCorreo = value,
        ),
      ),
      SizedBox(height: 20.0)
    ]);
  }

  Widget _crearTelefono() {
    return Column(children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            icon: Icon(Icons.phone),
            hintText: 'Teléfono',
            labelText: 'Teléfono',
          ),
          onChanged: (value) => usuario.usuarioCelular = value,
        ),
      ),
      SizedBox(height: 20.0)
    ]);
  }

  Widget _crearNombreApellido() {
    return Column(children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          decoration: InputDecoration(
            icon: Icon(Icons.supervised_user_circle_sharp),
            hintText: 'Apellidos y Nombres',
            labelText: 'Apellidos y Nombres',
          ),
          onChanged: (value) => usuario.usuarioNombre = value,
        ),
      ),
      SizedBox(height: 20.0)
    ]);
  }

  Widget _crearNombreUsuario() {
    return Column(children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          decoration: InputDecoration(
            icon: Icon(Icons.supervised_user_circle_sharp),
            hintText: 'Usuario',
            labelText: 'Nombre de Usuario',
          ),
          onChanged: (value) => usuario.usuarioNic = value,
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
          onChanged: (value) => usuario.usuarioContrasenia = value,
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
          onChanged: (value) => verificarClave = value,
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
              padding: EdgeInsets.only(left: 10.0),
              child: Checkbox(
                value: terminosCondiciones,
                onChanged: (value) {
                  setState(() {
                    terminosCondiciones = value;
                  });
                },
              )),
          Flexible(
            child: Text(
              'Acepto los términos y condiciones',
            ),
          )
        ]),
        SizedBox(height: 20.0)
      ],
    );
  }

  Widget _crearBotonRegistrar() {
    final size = MediaQuery.of(context).size;
    return RaisedButton(
        child: Text('Registrar'),
        padding: EdgeInsets.only(right: size.width * 0.25, left: size.width * 0.25),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 0.0,
        color: Colors.blueAccent,
        textColor: Colors.white,
        onPressed: _registro);
  }

  Widget _crearbotonLogin(BuildContext context) {
    return FlatButton(
        onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
        child: Text(
          '¿Ya tienes cuenta? Inicia Sesión!',
          style: TextStyle(color: Colors.blue),
        ));
  }

  _registro() {
    String mensaje = '';
    String titulo = '';
    //TODO: CONTROLAR VACIOS
    if (usuario.usuarioContrasenia == verificarClave) {
      if (terminosCondiciones) {
        print('REGISTRO CORRECTO');
        // regUsuarioBloc.registrarUsuario(usuario);
        Navigator.pushReplacementNamed(context, 'login');
      } else {
        titulo = 'Alerta';
        mensaje = 'Debe aceptar los terminos y condiciones para continuar';
        mostrarAlerta(context, mensaje, titulo);
      }
    } else {
      print('las claves no coinciden');
    }
  }

  void mostrarAlerta(BuildContext context, String mensaje, String titulo) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(mensaje),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              )
            ],
          );
        });
  }
}
