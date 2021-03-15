import 'package:app_factura_club_dev/src/widgets/inputs_widget.dart';
import 'package:flutter/material.dart';

class PermisosUsuarioPage extends StatefulWidget {
  @override
  _PermisosUsuarioPage createState() => _PermisosUsuarioPage();
}

class _PermisosUsuarioPage extends State<PermisosUsuarioPage> {
  bool esServicio;
  bool _bloquearCheck = false;
  @override
  void initState() {
    super.initState();
    esServicio = false;
  }

  List<Item> _data = generateItems();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Permisos Usuario'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        children: [
          Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  // input.crearInputText('Nombre Perfil', ''),
                  // Divider(),
                  // input.crearInputText('Descripcion', ''),
                ],
              ),
            ),
          ),
          _buildPanel(),
          Divider(),
          _crearBoton(),
        ],
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: Container(
              child: Column(
            children: [
              _crearSwitch('Crear'),
              _crearSwitch('Editar'),
              _crearSwitch('Eliminar'),
            ],
          )),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  Widget _crearBoton() {
    return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 85.0, vertical: 15.0),
          child: Text('Guardar'),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 0.0,
        color: Colors.blueAccent,
        textColor: Colors.white,
        onPressed: () {});
  }

  Widget _crearSwitch(String texto) {
    return SwitchListTile(
        title: Text(texto),
        value: _bloquearCheck,
        onChanged: (valor) {
          setState(() {
            _bloquearCheck = valor;
          });
        });
  }
}

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems() {
  List<Item> items = List<Item>();
  items.add(Item(headerValue: 'Empresa', expandedValue: 'Opciones'));
  items.add(Item(headerValue: 'Clientes', expandedValue: 'Opciones'));
  items.add(Item(headerValue: 'Productos', expandedValue: 'Opciones'));
  items.add(Item(headerValue: 'Facturas', expandedValue: 'Opciones'));
  items.add(Item(headerValue: 'algo mas xd', expandedValue: 'Opciones'));
  return items;
}

// List<Item> generateItems(int numberOfItems) {
//   return List.generate(numberOfItems, (int index) {
//     return Item(
//       headerValue: 'Panel $index',
//       expandedValue: 'This is item number $index',
//     );
//   });
// }
