import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/blocs/validator_bloc.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:app_factura_club_dev/src/services/usuarios_service.dart';
import 'package:app_factura_club_dev/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usuarioService = UsuarioService();
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
    final bloc = Provider.of(context);

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
                _inputEmail(bloc),
                SizedBox(height: 20.0),
                _inputNombreUsuario(bloc),
                SizedBox(height: 20.0),
                _inputClave(bloc),
                SizedBox(height: 20.0),
                _botonIngresar(context, bloc),
                _botonRegistrar(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

//===========================================================================INPUTS
  Widget _inputEmail(ValidatorBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.alternate_email),
                hintText: 'ejemplo@email.com',
                labelText: 'Correo electrónico',
                errorText: snapshot.error,
              ),
              onChanged: bloc.changeEmail,
            ),
          );
        });
  }

  Widget _inputNombreUsuario(ValidatorBloc bloc) {
    return StreamBuilder(
        stream: bloc.usernameStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.supervised_user_circle_sharp),
                hintText: 'Usuario',
                labelText: 'Nombre de Usuario',
                errorText: snapshot.error,
              ),
              onChanged: bloc.changeUserName,
            ),
          );
        });
  }

  Widget _inputClave(ValidatorBloc bloc) {
    return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock_outline),
                hintText: 'Contraseña',
                labelText: 'Contraseña',
                errorText: snapshot.error,
              ),
              onChanged: bloc.changePassword,
            ),
          );
        });
  }

//===========================================================================BOTONES
  Widget _botonIngresar(BuildContext context, ValidatorBloc bloc) {
    // final size = MediaQuery.of(context).size;
    return CupertinoButton(
      child: Text('Ingresar', style: TextStyle(color: Colors.white)),
      borderRadius: BorderRadius.circular(15),
      color: Colors.blueAccent,
      onPressed: () => _actionLogin(context, bloc),
    );
  }

  Widget _botonRegistrar(BuildContext context) {
    return CupertinoButton(
        child: Text(
          '¿No tienes cuenta? Registrate!',
          style: TextStyle(color: Colors.blue),
        ),
        onPressed: () => {
              Navigator.pushNamed(context, 'registro'),
            });
  }

//===========================================================================MÉTODOS
  void _actionLogin(BuildContext context, ValidatorBloc bloc) async {
    Map info = await usuarioService.login(bloc.email, bloc.username, bloc.password);
    if (info['ok']) {
      // Duration(milliseconds: 5);
      print('Existe');
      Usuario usuario = info['usuario'];
      Navigator.pushReplacementNamed(context, 'home', arguments: usuario);
    } else {
      mostrarAlerta(context, 'Error', info['mensaje']);
      print('error');
    }
  }
}
