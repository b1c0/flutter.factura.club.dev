import 'dart:async';

class Validators {
  //VALIDACIONES PARA LA VISTA LOGIN

  final validarEmail = StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);

    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Email no valido');
    }
  });

  final validarPassword = StreamTransformer<String, String>.fromHandlers(handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError('Más de 5 caracteres por favor');
    }
  });

  final validarUsername = StreamTransformer<String, String>.fromHandlers(handleData: (username, sink) {
    if (username.length >= 4) {
      sink.add(username);
    } else {
      sink.addError('Más de 3 caracteres por favor');
    }
  });
}
