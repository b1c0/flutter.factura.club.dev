import 'package:app_factura_club_dev/src/models/Argumentos.dart';
import 'package:rxdart/rxdart.dart';

class ArgumentosBloc {
  final _argumentosController = BehaviorSubject<Argumentos>();

  Stream<Argumentos> get argumentosStream => _argumentosController.stream;

  void crearArgumentos(Argumentos argumentos) {
    _argumentosController.sink.add(argumentos);
  }

  void dispose() {
    _argumentosController?.close();
  }
}
