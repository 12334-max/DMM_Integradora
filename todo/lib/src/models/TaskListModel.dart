import 'package:scoped_model/scoped_model.dart';

class TaskListModel extends Model {
  List<TaskModel> _taskList = List<TaskModel>();
  List<TaskModel> get taskList => _taskList;
  void add(TaskModel task) {
    _taskList.add(task);
    notifyListeners();
  }

  void edit(TaskModel task, Energia _inputEnergia, String _inputTitulo,
      String _inputFecha) {
    task.energia = _inputEnergia;
    task.titulo = _inputTitulo;
    task.fecha = _inputFecha;
    notifyListeners();
  }
}

enum Energia { baja, media, alta }

class TaskModel {
  String _titulo;
  String _fecha;
  Energia _energia;

  TaskModel(this._titulo, this._fecha, this._energia);

  String get titulo => this._titulo;
  String get fecha => this._fecha;
  Energia get energia => this._energia;
  set energia(Energia energia) {
    _energia = energia;
  }

  set titulo(String titulo) {
    _titulo = titulo;
  }

  set fecha(fecha) {
    _fecha = fecha;
  }
}
