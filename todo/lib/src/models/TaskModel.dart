import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  TaskModel({
    this.id = '',
    this.titulo = '',
    this.fecha = '',
    this.energia = 'Energia baja',
  });

  String id;
  String titulo;
  String fecha;
  String energia;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        titulo: json["titulo"],
        fecha: json["fecha"],
        energia: json["energia"],
      );

  Map<String, dynamic> toJson() => {
        //"id": id,
        "titulo": titulo,
        "fecha": fecha,
        "energia": energia,
      };
}
