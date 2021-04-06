import 'package:app_factura_club_dev/src/blocs/categoria_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/producto_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/models/Argumentos.dart';
import 'package:app_factura_club_dev/src/models/Bodega.dart';
import 'package:app_factura_club_dev/src/models/Categoria.dart';
import 'package:app_factura_club_dev/src/models/Producto.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:app_factura_club_dev/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NuevoProductoPage extends StatefulWidget {
  @override
  _NuevoProductoPage createState() => _NuevoProductoPage();
}

class _NuevoProductoPage extends State<NuevoProductoPage> {
  final _formKey = GlobalKey<FormState>();
  Producto producto = Producto.sinId();
  ProductoBloc productoBloc;
  CategoriaBloc categoriaBloc;
  String navFrom;
  String _categoriaSeleccionada = '-1';
  bool esServicio = false;
  bool iva = false;
  bool rice = false;

  @override
  Widget build(BuildContext context) {
    final Argumentos arg = ModalRoute.of(context).settings.arguments;
    final Usuario usuario = arg.usuario;
    final Bodega bodega = arg.bodega;
    final Producto data = arg.producto;
    categoriaBloc = Provider.crearCategoriaBloc(context);
    productoBloc = Provider.crearProductoBloc(context);
    categoriaBloc.cargarCategorias(arg.empresa.empresaId);
    navFrom = arg.navFrom;

    producto = data;
    producto.bodegaId = bodega.bodegaId;
    producto.usuarioId = usuario.idUser;

    if (producto.categoriaId != null) {
      _categoriaSeleccionada = producto.categoriaId.toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Producto'),
      ),
      body: _formulario(arg),
    );
  }

  //===========================================================================FORMULARIO
  Widget _formulario(Argumentos arg) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        children: [
          _inputNombreProducto(),
          Divider(),
          _inputMarcaProducto(),
          Divider(),
          _inputCodigoBarras(),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26, width: 1),
              borderRadius: BorderRadius.circular(20),
              color: Colors.white24,
            ),
            child: getCategorias(),
          ),
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
          _botonGuardarProducto(arg),
        ],
      ),
    );
  }

//===========================================================================INPUTS

  Widget _inputNombreProducto() {
    return TextFormField(
      initialValue: producto.productoNombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Nombre Producto',
        labelText: 'Nombre Producto *',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'El nombre del producto es obligatorio';
        } else {
          return null;
        }
      },
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

  Widget _inputCodigoBarras() {
    return TextFormField(
      initialValue: producto.productoCodigoBarras,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Codigo de Barras',
        labelText: 'Codigo de Barras',
      ),
      onChanged: (value) => producto.productoCodigoBarras = value,
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
      validator: (value) {
        if (int.parse(value) > 0) {
          return null;
        } else {
          return 'Debe ingresar la cantidad del stock';
        }
      },
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
      validator: (value) {
        if (double.parse(value) > 0) {
          return null;
        } else {
          return 'Debe ingresar un precio diferente de 0';
        }
      },
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

  Widget getCategorias() {
    return StreamBuilder(
      stream: categoriaBloc.categoriasStream,
      builder: (BuildContext context, AsyncSnapshot<List<Categoria>> snapshot) {
        if (snapshot.hasData) {
          final categorias = snapshot.data;
          List<DropdownMenuItem<String>> opciones = getCategoriasDropDown(categorias);
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: DropdownButton(
              value: _categoriaSeleccionada,
              items: opciones,
              onChanged: (value) {
                setState(() {
                  _categoriaSeleccionada = value;
                  producto.categoriaId = int.parse(_categoriaSeleccionada);
                });
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  //===========================================================================BOTONES
  Widget _botonGuardarProducto(Argumentos arg) {
    return CupertinoButton(
        child: Text(
          'Guardar',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        padding: EdgeInsets.symmetric(vertical: 20),
        borderRadius: BorderRadius.circular(15),
        color: Colors.blueAccent,
        onPressed: () => _ingresarProducto(arg));
  }

  //===========================================================================MEÉTODOS

  List<DropdownMenuItem<String>> getCategoriasDropDown(List<Categoria> opciones) {
    List<DropdownMenuItem<String>> lista = [];
    lista.add(DropdownMenuItem(
      child: Text(
        'Seleccione una Categoria',
      ),
      value: '-1',
    ));
    opciones.forEach((item) {
      lista.add(DropdownMenuItem(
        child: Text(item.categoriaNombre),
        value: item.categoriaId.toString(),
      ));
    });
    return lista;
  }

  void _ingresarProducto(Argumentos arg) {
    if (!_formKey.currentState.validate()) return;
    if (_categoriaSeleccionada == '-1') {
      mostrarAlerta(context, 'Alerta', 'Debe serleccionar la categoria');
      return;
    }

    if (producto.productoBodegaId == null) {
      productoBloc.crearNuevoProducto(producto);
      Navigator.pop(context);
      if (navFrom != 'navFromHome') {
        Navigator.popAndPushNamed(context, 'productos', arguments: arg);
      }
    } else {
      productoBloc.actualizarProducto(producto);
      Navigator.pop(context);
      Navigator.popAndPushNamed(context, 'productos', arguments: arg);
    }
  }
}
