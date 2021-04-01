import 'dart:async';

import 'package:app_factura_club_dev/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

//CLASE PARA VALIDACIONES EN TIEMPO REAL EN LA VISTA DE LOGIN
class ValidatorBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _usernameController = BehaviorSubject<String>();

  //recuperar los datos del stream
  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);
  Stream<String> get usernameStream => _usernameController.stream.transform(validarUsername);
  Stream<bool> get formValidStream => Rx.combineLatest3(emailStream, passwordStream, usernameStream, (e, p, u) => true);

  //Insertar valores al stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeUserName => _usernameController.sink.add;

  //obtener el ultimo valor ingresado a los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get username => _usernameController.value;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
    _usernameController?.close();
  }
}
