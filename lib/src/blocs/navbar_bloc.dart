import 'dart:async';

enum NavBarItem { Productos, Servicios }

class NavBarBloc {
  final StreamController<NavBarItem> _navBarController = StreamController<NavBarItem>.broadcast();
  NavBarItem defaultItem = NavBarItem.Productos;

  Stream<NavBarItem> get itemStream => _navBarController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarController.sink.add(NavBarItem.Productos);
        break;
      case 1:
        _navBarController.sink.add(NavBarItem.Servicios);
        break;
    }
  }

  dispose() {
    _navBarController?.close();
  }
}
