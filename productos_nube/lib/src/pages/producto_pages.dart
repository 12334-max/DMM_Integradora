import 'package:flutter/material.dart';
import 'package:productos_nube/src/models/producto_modelo.dart';
import 'package:productos_nube/src/providers/producto_provider.dart';

class ProductoPage extends StatefulWidget {
  ProductoPage({Key key}) : super(key: key);

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  ProductoModelo productoModelo = ProductoModelo();
  final productoProvider = Productprovider();

  @override
  Widget build(BuildContext context) {
    ProductoModelo producto = ModalRoute.of(context).settings.arguments;

    if (producto != null) {
      productoModelo = producto;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('producto'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _campoNombre(),
                _campoPrecio(),
                _campoDisponible(),
                _submit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _campoNombre() {
    return TextFormField(
      initialValue: productoModelo.nombre,
      validator: (nuevoValor) {
        if (nuevoValor.length < 2) {
          return 'Demasiado Corto, al menos 3 Caracteres';
        }
        return null;
      },
      onSaved: (nuevoValor) => productoModelo.nombre = nuevoValor,
    );
  }

  Widget _campoPrecio() {
    return TextFormField(
      initialValue: productoModelo.precio.toString(),
      validator: (nuevoValor) {
        final res = num.tryParse(nuevoValor);
        if (res == null) {
          return 'Debes ingresar un Número';
        }
        return null;
      },
      onSaved: (nuevoValor) =>
          productoModelo.precio = num.parse(nuevoValor) / 1.0,
      keyboardType: TextInputType.number,
    );
  }

  Widget _campoDisponible() {
    return SwitchListTile(
        title: Text('Disponible'),
        value: productoModelo.disponible,
        onChanged: (nuevoValor) => setState(() {
              productoModelo.disponible = nuevoValor;
            }));
  }

  Widget _submit() {
    return RaisedButton.icon(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        color: Colors.blueAccent,
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            if (productoModelo.id != '') {
              productoProvider.editar(productoModelo);
            } else {
              productoProvider.crear(productoModelo);
            }
            Navigator.pop(context);
          }
        },
        icon: Icon(Icons.save),
        label: Text('Guardar'));
  }
}
