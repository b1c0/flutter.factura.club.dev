import 'package:app_factura_club_dev/src/blocs/producto_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/models/Argumentos.dart';
import 'package:app_factura_club_dev/src/models/Bodega.dart';
import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:app_factura_club_dev/src/models/Producto.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductosPage extends StatefulWidget {
  @override
  _ProductosPageState createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  @override
  Widget build(BuildContext context) {
    final Argumentos arg = ModalRoute.of(context).settings.arguments;
    final Empresa empresa = arg.empresa;
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
                Producto producto = Producto();
                Argumentos arg = Argumentos.producto(empresa, bodega, usuario, producto, 'navFromProductos');
                Navigator.pushNamed(context, 'nuevo_producto', arguments: arg).then((value) => setState(() {}));
              })
        ],
      ),
      body: _listarProductos(productoBloc, arg),
    );
  }

  //===========================================================================WIDGETS
  Widget _listarProductos(ProductoBloc productoBloc, Argumentos arg) {
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
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        padding: EdgeInsets.only(right: 30),
        color: Colors.red,
        child: Align(
          child: Icon(Icons.delete, color: Colors.white),
          alignment: Alignment.centerRight,
        ),
      ),
      onDismissed: (direction) {
        mostrarAlertaEliminar(context, productoBloc, producto);
        setState(() {});
      },
      child: Card(
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
                  leading: Icon(Icons.category_rounded, color: Colors.white, size: 40.0),
                  title: Text(producto.productoNombre, style: TextStyle(color: Colors.white)),
                  subtitle: Text(producto.productoBodegaPrecio.toString(), style: TextStyle(color: Colors.white)),

                  // trailing: _crearPopupMenuButton(bodega, arg.usuario),
                  onTap: () {
                    Argumentos a = Argumentos.producto(arg.empresa, arg.bodega, arg.usuario, producto, 'navFromProductos');
                    Navigator.pushNamed(context, 'nuevo_producto', arguments: a).then((value) {
                      setState(() {});
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }

  //===========================================================================MÉTODOS
  void _eliminarBodega(ProductoBloc productoBloc, Producto producto) {
    productoBloc.eliminarProducto(producto.usuarioId, producto.productoBodegaId);
  }

  void mostrarAlertaEliminar(BuildContext context, ProductoBloc productoBloc, Producto producto) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Eliminar'),
            content: Text('¿Esta seguro que desea eliminar el producto: "${producto.productoNombre}"?'),
            actions: [
              CupertinoButton(
                onPressed: () => {
                  Navigator.pop(context),
                },
                child: Text('Cancelar'),
              ),
              CupertinoButton(
                  child: Text('OK'),
                  onPressed: () => {
                        _eliminarBodega(productoBloc, producto),
                        Navigator.pop(context),
                        setState(() {}),
                      })
            ],
          );
        });
  }
}
