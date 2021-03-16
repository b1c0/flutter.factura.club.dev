import 'package:app_factura_club_dev/src/blocs/producto_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/models/Argumentos.dart';
import 'package:app_factura_club_dev/src/models/Bodega.dart';
import 'package:app_factura_club_dev/src/models/Producto.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NuevoProductoPage extends StatefulWidget {
  @override
  _NuevoProductoPage createState() => _NuevoProductoPage();
}

class _NuevoProductoPage extends State<NuevoProductoPage> {
  // String _opcionSeleccionada = 'Selecione impuesto Iva';
  // List<String> _opciones = ['Selecione impuesto Iva', 'Iva 0%', 'Iva 12%', 'Iva 14%'];
  final formKey = GlobalKey<FormState>();
  String navFrom;
  bool esServicio = false;
  bool iva = false;
  bool rice = false;
  Producto producto = Producto.sinId();
  ProductoBloc productoBloc;
  @override
  Widget build(BuildContext context) {
    productoBloc = Provider.crearProductoBloc(context);

    final Argumentos arg = ModalRoute.of(context).settings.arguments;
    final Usuario usuario = arg.usuario;
    final Bodega bodega = arg.bodega;
    final Producto data = arg.producto;
    navFrom = arg.navFrom;
    print(navFrom);

    if (data != null) {
      producto = data;
    }

    producto.bodegaId = bodega.bodegaId;
    producto.usuarioId = usuario.idUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Producto'),
      ),
      body: _formulario(arg),
    );
  }

  Widget _formulario(Argumentos arg) {
    return Form(
      key: formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        children: [
          _inputNombreProducto(),
          Divider(),
          _inputMarcaProducto(),
          Divider(),
          _inputPesoProducto(),
          Divider(),
          _inputUnidadMedida(),
          Divider(),
          _inputIva(),
          Divider(),
          _inputIce(),
          Divider(),
          _inputStock(),
          Divider(),
          _inputPrecio(),
          Divider(),
          _inputEstado(),
          Divider(),
          _crearBoton(arg),
        ],
      ),
    );
  }

  Widget _crearBoton(Argumentos arg) {
    return CupertinoButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 85.0, vertical: 15.0),
          child: Text(
            'Guardar',
            style: TextStyle(color: Colors.white),
          ),
        ),
        borderRadius: BorderRadius.circular(15),
        color: Colors.blueAccent,
        onPressed: () => _actionGuardar(arg));
  }

  void _actionGuardar(Argumentos arg) {
    producto.categoriaId = 1;

    if (producto.productoBodegaId == null) {
      print('creando');
      print(producto.usuarioId);
      productoBloc.crearNuevoProducto(producto);
      if (navFrom == 'navFromHome') {
        Navigator.pop(context);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, 'productos', ModalRoute.withName('bodega'), arguments: arg);
      }
    } else {
      print('actualizando');
      productoBloc.actualizarProducto(producto);
      Navigator.pushNamedAndRemoveUntil(context, 'productos', ModalRoute.withName('bodega'), arguments: arg);
    }
  }

//===========================================================================INPUTS

  Widget _inputNombreProducto() {
    return TextFormField(
      initialValue: producto.productoNombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Nombre Producto',
        labelText: 'Nombre Producto',
      ),
      onChanged: (value) => producto.productoNombre = value,
    );
  }

  Widget _inputMarcaProducto() {
    return TextFormField(
      initialValue: producto.productoMarca,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Marca Producto',
        labelText: 'Marca Producto',
      ),
      onChanged: (value) => producto.productoMarca = value,
    );
  }

  Widget _inputPesoProducto() {
    if (producto.productoPeso == null) {
      producto.productoPeso = 0;
    }
    return TextFormField(
      initialValue: producto.productoPeso.toString(),
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Peso Producto',
        labelText: 'Peso Producto',
      ),
      onChanged: (value) => producto.productoPeso = double.parse(value),
    );
  }

  Widget _inputUnidadMedida() {
    return TextFormField(
      initialValue: producto.productoUnidadMedida,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Unidad de medida',
        labelText: 'Unidad de medida',
      ),
      onChanged: (value) => producto.productoUnidadMedida = (value),
    );
  }

  Widget _inputIva() {
    if (producto.productoBodegaIva == null) {
      producto.productoBodegaIva = false;
    }
    return SwitchListTile(
        title: Text('Tiene IVA'),
        value: producto.productoBodegaIva,
        onChanged: (value) {
          setState(() {
            producto.productoBodegaIva = value;
          });
        });
  }

  Widget _inputIce() {
    if (producto.productoBodegaIce == null) {
      producto.productoBodegaIce = false;
    }
    return SwitchListTile(
        title: Text('Tiene ICE'),
        value: producto.productoBodegaIce,
        onChanged: (value) {
          setState(() {
            producto.productoBodegaIce = value;
          });
        });
  }

  Widget _inputStock() {
    if (producto.productoBodegaStock == null) {
      producto.productoBodegaStock = 0;
    }
    return TextFormField(
      // autofocus: true,
      initialValue: producto.productoBodegaStock.toString(),
      enabled: !esServicio,
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Número de unidades en el inventario',
        labelText: 'Stock',
      ),
      onChanged: (value) => producto.productoBodegaStock = int.parse(value),
    );
  }

  Widget _inputPrecio() {
    if (producto.productoBodegaPrecio == null) {
      producto.productoBodegaPrecio = 0.0;
    }
    return TextFormField(
      initialValue: producto.productoBodegaPrecio.toString(),
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Precio Unitario',
        labelText: 'Precio Unitario',
      ),
      onChanged: (value) => producto.productoBodegaPrecio = double.parse(value),
    );
  }

  Widget _inputEstado() {
    return TextFormField(
      initialValue: producto.productoBodegaEstado,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Estado',
        labelText: 'Estado',
      ),
      onChanged: (value) => producto.productoBodegaEstado = (value),
    );
  }
}
