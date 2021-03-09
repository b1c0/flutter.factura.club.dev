import 'package:app_factura_club_dev/src/blocs/producto_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/models/Argumentos.dart';
import 'package:app_factura_club_dev/src/models/Bodega.dart';
import 'package:app_factura_club_dev/src/models/Producto.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:flutter/material.dart';

class TabProductos extends StatefulWidget {
  @override
  _TabProductosState createState() => _TabProductosState();
}

class _TabProductosState extends State<TabProductos> {
  @override
  Widget build(BuildContext context) {
    final Argumentos arg = ModalRoute.of(context).settings.arguments;
    final Usuario usuario = arg.usuario;
    final Bodega bodega = arg.bodega;
    final productoBloc = Provider.crearProductoBloc(context);
    productoBloc.cargarProductos(bodega.bodegaId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, 'nuevo_producto', arguments: arg);
              })
        ],
      ),
      body: _listarProductos(productoBloc, arg),
    );
  }

  _listarProductos(ProductoBloc productoBloc, Argumentos arg) {
    return StreamBuilder(
      stream: productoBloc.productosStream,
      builder: (BuildContext context, AsyncSnapshot<List<Producto>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;
          return ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, i) {
                productos[i].usuarioId = arg.usuario.idUser;
                return _crearItem(context, productoBloc, productos[i], arg);
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _crearItem(BuildContext context, ProductoBloc productoBloc, Producto producto, Argumentos arg) {
    return
// Dismissible(
//       key: UniqueKey(),
//       background: Container(
//         padding: EdgeInsets.only(right: 30),
//         color: Colors.red,
//         child: Align(
//           child: Icon(Icons.delete, color: Colors.white),
//           alignment: Alignment.centerRight,
//         ),
//       ),
//       onDismissed: (direction) {
//         mostrarAlertaEliminar(context, bodegaBloc, bodega);
//         setState(() {});
//       },
//       child:
        Card(
      margin: EdgeInsets.all(5.0),
      color: Colors.blue[300],
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: [
          Container(
            color: Colors.purple,
            padding: EdgeInsets.all(5.0),
            child: ListTile(
                leading: Icon(Icons.business_sharp, color: Colors.white, size: 40.0),
                title: Text(producto.productoNombre, style: TextStyle(color: Colors.white)),
                subtitle: Text(producto.productoBodegaPrecio.toString(), style: TextStyle(color: Colors.white)),

                // trailing: _crearPopupMenuButton(bodega, arg.usuario),
                onTap: () {
                  // Argumentos a = Argumentos.bodega(arg.empresa, arg.usuario, bodega);
                  // Navigator.pushNamed(context, 'nueva-bodega', arguments: a).then((value) {
                  // setState(() {});
                  // });
                }),
          ),
        ],
      ),
      // ),
    );
  }
}
