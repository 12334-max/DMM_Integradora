import 'package:flutter/material.dart';
import 'package:productos_nube/src/models/producto_modelo.dart';
import 'package:productos_nube/src/providers/producto_provider.dart';

class ListaPages extends StatelessWidget {
  final productoProvider = Productprovider();
  ListaPages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    productoProvider.leer();
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de productos'),
      ),
      body: FutureBuilder(
          future: productoProvider.leer(),
          builder: (context, AsyncSnapshot<List<ProductoModelo>> snapshot) {
            if (snapshot.hasData) {
              final items = snapshot.data;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, pos) => _crearItem(context, items[pos]),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  _crearItem(BuildContext context, ProductoModelo productoModelo) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) => productoProvider.eliminar(productoModelo.id),
      child: ListTile(
          title: Text('${productoModelo.nombre}'),
          trailing: Text('precio: ${productoModelo.precio}'),
          onTap: () async {
            await Navigator.pushNamed(context, 'producto',
                arguments: productoModelo);
            Navigator.pushReplacementNamed(context, 'lista');
          }),
    );
  }
}
