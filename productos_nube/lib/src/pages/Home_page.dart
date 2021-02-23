import 'package:flutter/material.dart';

class HomePages extends StatelessWidget {
  const HomePages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos en la nube'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            _encabezadoDrawer(),
            _itemsDrawer(context),
          ],
        ),
      ),
    );
  }

  Widget _encabezadoDrawer() {
    return UserAccountsDrawerHeader(
        accountName: Text('Nicodemo'), accountEmail: Text('Nini38@gmail.com'));
  }

  Widget _itemsDrawer(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('Lista de productos'),
          leading: Icon(Icons.list),
          onTap: () => Navigator.pushNamed(context, 'lista'),
        ),
        ListTile(
          title: Text('Nuevo Producto'),
          leading: Icon(Icons.more),
          onTap: () => Navigator.pushNamed(context, 'producto'),
        )
      ],
    );
  }
}
