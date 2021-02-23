// To parse this JSON data, do
//
//     final productoModelo = productoModeloFromJson(jsonString);

import 'dart:convert';

ProductoModelo productoModeloFromJson(String str) =>
    ProductoModelo.fromJson(json.decode(str));

String productoModeloToJson(ProductoModelo data) => json.encode(data.toJson());

class ProductoModelo {
  ProductoModelo({
    this.id = '',
    this.nombre = '',
    this.precio = 0.0,
    this.disponible = false,
  });

  String id;
  String nombre;
  double precio;
  bool disponible;

  factory ProductoModelo.fromJson(Map<String, dynamic> json) => ProductoModelo(
        id: json["id"],
        nombre: json["nombre"],
        precio: json["precio"].toDouble(),
        disponible: json["disponible"],
      );

  Map<String, dynamic> toJson() => {
        //"id": id,
        "nombre": nombre,
        "precio": precio,
        "disponible": disponible,
      };
}
