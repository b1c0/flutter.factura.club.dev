import 'package:app_factura_club_dev/src/blocs/navbar_bloc.dart';
import 'package:app_factura_club_dev/src/pages/productos_servicios/tab1_productos_page.dart';
import 'package:app_factura_club_dev/src/pages/productos_servicios/tab2_servicios_page.dart';
import 'package:flutter/material.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  NavBarBloc _navBarBloc;

  @override
  void initState() {
    super.initState();
    _navBarBloc = NavBarBloc();
  }

  @override
  void dispose() {
    _navBarBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<NavBarItem>(
        stream: _navBarBloc.itemStream,
        initialData: _navBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          switch (snapshot.data) {
            case NavBarItem.Productos:
              return TabProductos();
            case NavBarItem.Servicios:
              return TabServicios();
            default:
              return Container();
          }
        },
      ),
      bottomNavigationBar: StreamBuilder(
        stream: _navBarBloc.itemStream,
        initialData: _navBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return BottomNavigationBar(
            fixedColor: Colors.blueAccent,
            currentIndex: snapshot.data.index,
            onTap: _navBarBloc.pickItem,
            items: [
              BottomNavigationBarItem(label: 'Productos', icon: Icon(Icons.category)),
              BottomNavigationBarItem(label: 'Servicios', icon: Icon(Icons.business_center)),
            ],
          );
        },
      ),
    );
  }
}
