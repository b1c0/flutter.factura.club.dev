import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/blocs/registro_usuarios_bloc.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:app_factura_club_dev/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _formKey = GlobalKey<FormState>();

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
          _formulario(context),
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

  Widget _formulario(BuildContext context) {
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
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _crearNombreApellido(),
                        _crearNombreUsuario(),
                        _crearEmail(),
                        _crearTelefono(),
                        _crearPassword(),
                        _crearVerificarPassword(),
                      ],
                    )),
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email),
          hintText: 'ejemplo@ejemplo.com',
          labelText: 'Correo electrónico',
        ),
        validator: (value) {
          if (value.isNotEmpty) {
            if (RegExp(
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                .hasMatch(value)) {
              return null;
            } else {
              return 'Correo Invalido';
            }
          } else {
            return 'El campo no debe estar vacio';
          }
        },
        onChanged: (value) => usuario.usuarioCorreo = value,
      ),
    );
  }

  Widget _crearTelefono() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          icon: Icon(Icons.phone),
          hintText: 'Teléfono',
          labelText: 'Teléfono (Opcional)',
        ),
        onChanged: (value) => usuario.usuarioCelular = value,
      ),
    );
  }

  Widget _crearNombreApellido() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(Icons.supervised_user_circle_sharp),
          hintText: 'Apellidos y Nombres',
          labelText: 'Apellidos y Nombres',
        ),
        validator: (value) {
          if (value.isNotEmpty) {
            return null;
          } else {
            return 'El campo no debe estar vacio';
          }
        },
        onChanged: (value) => usuario.usuarioNombre = value,
      ),
    );
  }

  Widget _crearNombreUsuario() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(Icons.supervised_user_circle_sharp),
          hintText: 'Nombre de Usuario',
          labelText: 'Nombre de Usuario',
        ),
        validator: (value) {
          if (value.isNotEmpty && value.length >= 4) {
            return null;
          } else {
            return 'El nombre de usuario debe ser \nde por lo menos 4 caracteres';
          }
        },
        onChanged: (value) => usuario.usuarioNic = value,
      ),
    );
  }

  Widget _crearPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline),
          hintText: 'Contraseña',
          labelText: 'Contraseña',
        ),
        validator: (value) {
          if (value.isNotEmpty && value.length > 5) {
            return null;
          } else {
            return 'la contraseña debe ser de por lo menos 6 caracteres';
          }
        },
        onChanged: (value) => usuario.usuarioContrasenia = value,
      ),
    );
  }

  Widget _crearVerificarPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline),
          hintText: 'Verificar Contraseña',
          labelText: 'Verificar Contraseña',
        ),
        validator: (value) {
          if (usuario.usuarioContrasenia == value) {
            return null;
          } else {
            return 'Las contraseñas no coinciden';
          }
        },
        onChanged: (value) => verificarClave = value,
      ),
    );
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
    // final size = MediaQuery.of(context).size;
    return CupertinoButton(
      child: Text('Registrar'),
      borderRadius: BorderRadius.circular(15),
      color: Colors.blueAccent,
      onPressed: _registro,
    );
  }

  Widget _crearbotonLogin(BuildContext context) {
    return CupertinoButton(
        onPressed: () => Navigator.pop(context),
        child: Text(
          '¿Ya tienes cuenta? Inicia Sesión!',
          style: TextStyle(color: Colors.blue),
        ));
  }

  void _registro() async {
    if (!_formKey.currentState.validate()) return;
    if (terminosCondiciones) {
      print('REGISTRando');
      Map info = await regUsuarioBloc.registrarUsuario(usuario);
      if (info['ok']) {
        Navigator.pop(context, info['mensaje']);
      } else {
        mostrarAlerta(
          context,
          'Alerta',
          info['mensaje'],
        );
      }
    } else {
      mostrarAlerta(
        context,
        'Alerta',
        'Debe aceptar los terminos y condiciones para continuar',
      );
    }
  }
}
