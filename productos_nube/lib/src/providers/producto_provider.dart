import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:productos_nube/src/models/producto_modelo.dart';

class Productprovider {
  final _url = 'https://psprodusctos.firebaseio.com';

  Future<bool> crear(ProductoModelo producto) async {
    final urlCrear = '$_url/productos.json';
    final respuesta =
        await http.post(urlCrear, body: productoModeloToJson(producto));
    print(respuesta);
    return true;
  }

  Future<List<ProductoModelo>> leer() async {
    final List<ProductoModelo> lista = List<ProductoModelo>();
    final url = '$_url/productos.json';
    final respuesta = await http.get(url);
    final Map<String, dynamic> data = json.decode(respuesta.body);

    data.forEach((key, value) {
      ProductoModelo productoModelo = ProductoModelo.fromJson(value);
      productoModelo.id = key;
      lista.add(productoModelo);
    });
    return lista;
  }

  Future<bool> eliminar(String uuid) async {
    bool eliminado = false;
    final url = '$_url/productos/$uuid.json';
    final respuesta = await http.delete(url);
    if (respuesta.body == null) {
      eliminado = true;
    }
    return eliminado;
  }

  Future<bool> editar(ProductoModelo productoModelo) async {
    bool editado = false;
    final url = '$_url/productos/${productoModelo.id}.json';
    final respuesta =
        await http.put(url, body: productoModeloToJson(productoModelo));
    if (respuesta.statusCode == 200) {
      editado = true;
    }
    return editado;
  }
}
