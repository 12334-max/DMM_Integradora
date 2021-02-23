import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo/src/models/TaskModel.dart';

class TareaProvider {
  final _url = 'https://app-todo-11701.firebaseio.com/';

  Future<bool> crear(TaskModel tarea) async {
    final urlCrear = '$_url/tareas.json';
    final respuesta = await http.post(urlCrear, body: taskModelToJson(tarea));
    print(respuesta);
    return true;
  }

  Future<List<TaskModel>> leer() async {
    final List<TaskModel> lista = List<TaskModel>();
    final url = '$_url/tareas.json';
    final respuesta = await http.get(url);
    final Map<String, dynamic> data = json.decode(respuesta.body);
    data.forEach((key, value) {
      TaskModel taskModel = TaskModel.fromJson(value);
      taskModel.id = key;
      lista.add(taskModel);
    });
    return lista;
  }

  Future<bool> eliminar(String uuid) async {
    bool eliminado = false;
    final url = '$_url/tareas/$uuid.json';
    final respuesta = await http.delete(url);
    if (respuesta.body == null) {
      eliminado = true;
    }
    return eliminado;
  }

  Future<bool> editar(TaskModel taskModel) async {
    bool editado = false;
    final url = '$_url/tareas/${taskModel.id}.json';
    final respuesta = await http.put(url, body: taskModelToJson(taskModel));
    if (respuesta.statusCode == 200) {
      editado = true;
    }
    return editado;
  }
}
