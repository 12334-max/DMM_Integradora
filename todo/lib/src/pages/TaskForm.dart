import 'package:flutter/material.dart';
import 'package:todo/src/models/TaskModel.dart';
import 'package:todo/src/provider/tarea_provider.dart';

class TaskForm extends StatefulWidget {
  TaskForm({Key key}) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formkey = GlobalKey<FormState>();
  TaskModel taskmodel = TaskModel();
  final tareaProvider = TareaProvider();
  TaskModel task;

  TextEditingController _inputTitulo = TextEditingController();
  TextEditingController _inputFecha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TaskModel task = ModalRoute.of(context).settings.arguments;
    if (task != null) {
      taskmodel = task;
      TextEditingController _inputFecha =
          TextEditingController(text: '${task.fecha}');
      Widget _campoTitulo() {
        return TextFormField(
          initialValue: task.titulo,
          decoration: InputDecoration(
            icon: Icon(Icons.archive, color: Colors.black),
          ),
          validator: (nuevoValor) {
            if (nuevoValor.isEmpty) {
              return 'Debes agregar un titulo';
            } else {
              taskmodel.titulo = nuevoValor;
              return null;
            }
          },
        );
      }

      void _selectDate2(BuildContext context) async {
        DateTime picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year - 5),
            lastDate: DateTime(DateTime.now().year + 5));
        if (picked != null) {
          setState(() {
            String dia = '${picked.day}';
            if (picked.day < 10) {
              dia = '0${picked.day}';
            }
            task.fecha = '${picked.year}-${picked.month}-$dia';
          });
        }
      }

      Widget _campoFecha2(BuildContext context) {
        return TextFormField(
          controller: _inputFecha,
          decoration: InputDecoration(
              icon: Icon(Icons.calendar_today, color: Colors.black)),
          enableInteractiveSelection: false,
          validator: (nuevovalor) {
            if (nuevovalor.isEmpty) {
              return 'Selecciona una fecha';
            } else {
              task.fecha = nuevovalor;
              taskmodel.fecha = nuevovalor;
              return null;
            }
          },
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            _selectDate2(context);
          },
        );
      }

      return Form(
        key: _formkey,
        child: ListView(
          children: [
            _campoTitulo(),
            _campoFecha2(context),
            _campoEnergia(),
            description()
            //_botonEditar(),
          ],
        ),
      );
    } else {
      return Form(
        key: _formkey,
        child: ListView(
          children: [
            _campoTitulo(),
            _campoFecha(context),
            _campoEnergia(),
            _botonGuardar(),
          ],
        ),
      );
    }
  }

  Widget _campoTitulo() {
    return TextFormField(
      controller: _inputTitulo,
      decoration: InputDecoration(),
      validator: (nuevoValor) {
        if (nuevoValor.isEmpty) {
          return 'Debes agregar un titulo';
        } else {
          taskmodel.titulo = nuevoValor;
          return null;
        }
      },
    );
  }

  Widget _campoFecha(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          icon: Icon(Icons.calendar_today, color: Colors.black)),
      enableInteractiveSelection: false,
      controller: _inputFecha,
      validator: (nuevovalue) {
        if (nuevovalue.isEmpty) {
          return 'Selecciona una fecha';
        } else {
          taskmodel.fecha = nuevovalue;
          return null;
        }
      },
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        _selectDate(context);
      },
    );
  }

  Widget _campoEnergia() {
    return DropdownButton(
        value: taskmodel.energia,
        icon: Icon(Icons.battery_std, color: Colors.blueAccent),
        dropdownColor: Colors.lightBlue,
        isExpanded: true,
        style: TextStyle(color: Colors.black),
        underline: Container(height: 3, color: Colors.blueAccent),
        items: [
          DropdownMenuItem(
            child: Text('Energia baja'),
            value: 'Energia baja',
          ),
          DropdownMenuItem(
            child: Text('Energia media'),
            value: 'Energia media',
          ),
          DropdownMenuItem(
            child: Text('Energia alta'),
            value: 'Energia alta',
          )
        ],
        onChanged: (value) {
          setState(() {
            taskmodel.energia = value;
          });
        });
  }

  Widget _botonGuardar() {
    return RaisedButton(
        splashColor: Colors.orange,
        color: Colors.blue,
        elevation: 7,
        padding: EdgeInsets.all(20.0),
        child: Text('Nuevo Cesto'),
        onPressed: () {
          if (_formkey.currentState.validate()) {
            tareaProvider.crear(taskmodel);
            _inputFecha.clear();
            _inputTitulo.clear();
          }
        });
  }

  void _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));
    if (picked != null) {
      setState(() {
        String dia = '${picked.day}';
        if (picked.day < 10) {
          dia = '0${picked.day}';
        }
        _inputFecha.text = '${picked.year}-${picked.month}-$dia';
      });
    }
  }

  /* Widget _botonEditar() {
    return RaisedButton(
        splashColor: Colors.orange,
        color: Colors.blue,
        elevation: 5,
        padding: EdgeInsets.all(20.0),
        child: Text('Editar tarea'),
        onPressed: () {
          if (_formkey.currentState.validate()) {
            tareaProvider.editar(taskmodel);
            _inputFecha.clear();
            _inputTitulo.clear();
            Navigator.pop(context);
          }
        });
  }**/
  Widget description() {
    return Text('Cesto de basura llena. Favor de retirar');
  }
}
