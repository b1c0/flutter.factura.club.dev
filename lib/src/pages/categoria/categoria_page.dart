import 'package:app_factura_club_dev/src/blocs/categoria_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/models/Argumentos.dart';
import 'package:app_factura_club_dev/src/models/Categoria.dart';
import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:flutter/material.dart';

class CategoriaPage extends StatefulWidget {
  @override
  _CategoriaPageState createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<CategoriaPage> {
  @override
  Widget build(BuildContext context) {
    final Argumentos arg = ModalRoute.of(context).settings.arguments;
    final Empresa empresa = arg.empresa;
    final categoriaBloc = Provider.crearCategoriaBloc(context);
    categoriaBloc.cargarCategorias(empresa.empresaId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Argumentos a = Argumentos.categoria(arg.empresa, arg.usuario, Categoria());
                Navigator.pushNamed(context, 'nueva-categoria', arguments: a).then((value) {
                  setState(() {});
                });
              })
        ],
      ),
      body: _listarCategorias(categoriaBloc, arg),
    );
  }

  Widget _listarCategorias(CategoriaBloc categoriaBloc, Argumentos arg) {
    return StreamBuilder(
      stream: categoriaBloc.categoriasStream,
      builder: (BuildContext context, AsyncSnapshot<List<Categoria>> snapshot) {
        if (snapshot.hasData) {
          final categorias = snapshot.data;
          return ListView.builder(
              itemCount: categorias.length,
              itemBuilder: (context, i) {
                categorias[i].usuarioId = arg.usuario.idUser;
                return _crearItem(context, categoriaBloc, categorias[i], arg);
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _crearItem(BuildContext context, CategoriaBloc categoriaBloc, Categoria categoria, Argumentos arg) {
    return Card(
      margin: EdgeInsets.all(5.0),
      color: Colors.blue[300],
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: [
          Container(
            color: Colors.pinkAccent,
            padding: EdgeInsets.all(5.0),
            child: ListTile(
              leading: Icon(Icons.menu_book, color: Colors.white, size: 40.0),
              title: Text(categoria.categoriaNombre, style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
