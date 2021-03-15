import 'dart:html';

import 'package:app_factura_club_dev/src/models/Cliente.dart';
import 'package:app_factura_club_dev/src/services/cliente_service.dart';
import 'package:flutter/material.dart';

class ClienteSearch extends SearchDelegate {
  final clienteService = ClienteService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
        future: clienteService.buscarCliente(query),
        builder: (BuildContext context, AsyncSnapshot<List<Cliente>> snapshot) {
          if (snapshot.hasData) {
            final clientes = snapshot.data;
            return ListView(
                children: clientes.map((cliente) {
              return ListTile(
                leading: Icon(Icons.person),
                title: Text('${cliente.clienteIdentificacion} - ${cliente.clienteNombres}'),
                subtitle: Text(cliente.clienteCorreo),
                onTap: () {
                  close(context, null);
                  // pelicula.uniqueId = '';
                  Navigator.pushNamed(context, 'nueva-factura', arguments: cliente);
                },
              );
            }).toList());
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
