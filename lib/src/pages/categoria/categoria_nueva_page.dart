import 'package:app_factura_club_dev/src/blocs/categoria_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/models/Argumentos.dart';
import 'package:app_factura_club_dev/src/models/Categoria.dart';
import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NuevaCategoriaPage extends StatefulWidget {
  @override
  _NuevaCategoriaPageState createState() => _NuevaCategoriaPageState();
}

class _NuevaCategoriaPageState extends State<NuevaCategoriaPage> {
  final _formKey = GlobalKey<FormState>();
  Categoria categoria = Categoria.sinId();
  CategoriaBloc categoriaBloc;

  @override
  Widget build(BuildContext context) {
    final Argumentos arg = ModalRoute.of(context).settings.arguments;
    final Usuario usuario = arg.usuario;
    final Empresa empresa = arg.empresa;
    final Categoria data = arg.categoria;
    categoriaBloc = Provider.crearCategoriaBloc(context);

    categoria = data;
    categoria.usuarioId = usuario.idUser;
    categoria.empresaId = empresa.empresaId;

    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Categoria'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: _formulario(arg),
      ),
    );
  }

  //===========================================================================FORMULARIO
  Widget _formulario(Argumentos arg) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          _inputNombreCategoria(),
          Divider(),
          _botonGuardarCategoria(arg),
        ],
      ),
    );
  }

  //===========================================================================INPUTS
  Widget _inputNombreCategoria() {
    return TextFormField(
      maxLength: 250,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Nombre Categoria *',
      ),
      validator: (value) {
        if (value.isNotEmpty) {
          return null;
        } else {
          return 'El nombre es obligatorio';
        }
      },
      onChanged: (value) => categoria.categoriaNombre = value,
    );
  }

  //===========================================================================BOTONES
  Widget _botonGuardarCategoria(Argumentos arg) {
    return CupertinoButton(
      child: Text('Guardar'),
      borderRadius: BorderRadius.circular(15),
      color: Colors.blueAccent,
      onPressed: () => _ingresarCategoria(arg),
    );
  }

  //===========================================================================MÉTODOS
  void _ingresarCategoria(Argumentos arg) {
    if (!_formKey.currentState.validate()) return;

    if (categoria.categoriaId == null) {
      print('creando');
      categoriaBloc.crearNuevaCategoria(categoria);
      Navigator.pop(context);
      Navigator.popAndPushNamed(context, 'categoria', arguments: arg);
    }
  }
}
