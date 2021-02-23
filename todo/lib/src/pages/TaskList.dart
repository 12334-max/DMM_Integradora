import 'package:flutter/material.dart';
import 'package:todo/src/models/TaskModel.dart';
import 'package:todo/src/provider/tarea_provider.dart';

class TaskList extends StatelessWidget {
  final tarea = TareaProvider();
  TaskList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    tarea.leer();
    return Scaffold(
      body: FutureBuilder(
          future: tarea.leer(),
          builder: (context, AsyncSnapshot<List<TaskModel>> snapshot) {
            if (snapshot.hasData) {
              final items = snapshot.data;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, pos) => _crearItem(context, items[pos]),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  _crearItem(BuildContext context, TaskModel taskModel) {
    if (taskModel.energia == "Energia baja") {
      return Dismissible(
        key: UniqueKey(),
        onDismissed: (direccion) => tarea.eliminar(taskModel.id),
        background: Container(
          color: Colors.red,
          child: Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Eliminar",
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        child: ListTile(
            title: Text(taskModel.titulo),
            subtitle: Text(taskModel.fecha),
            trailing: Icon(
              Icons.battery_alert,
              size: 50,
              color: Colors.lightGreen,
            ),
            onLongPress: () async {
              await Navigator.pushNamed(context, "/edit", arguments: taskModel);
              Navigator.pushReplacementNamed(context, "/home");
            }),
      );
    } else if (taskModel.energia == "Energia media") {
      return Dismissible(
        key: UniqueKey(),
        onDismissed: (direccion) => tarea.eliminar(taskModel.id),
        background: Container(
          color: Colors.red,
          child: Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Eliminar",
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        child: ListTile(
          title: Text(taskModel.titulo),
          subtitle: Text(taskModel.fecha),
          onLongPress: () async {
            await Navigator.pushNamed(context, "/edit", arguments: taskModel);
            Navigator.pushReplacementNamed(context, "/home");
          },
          trailing: Icon(
            Icons.battery_std,
            size: 50,
            color: Colors.yellow,
          ),
        ),
      );
    } else {
      return Dismissible(
        key: UniqueKey(),
        onDismissed: (direccion) => tarea.eliminar(taskModel.id),
        background: Container(
          color: Colors.red,
          child: Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Eliminar",
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        child: ListTile(
          title: Text(taskModel.titulo),
          subtitle: Text(taskModel.fecha),
          onLongPress: () async {
            await Navigator.pushNamed(context, "/edit", arguments: taskModel);
            Navigator.pushReplacementNamed(context, "/home");
          },
          trailing: Icon(
            Icons.battery_charging_full,
            size: 50,
            color: Colors.blue,
          ),
        ),
      );
    }
  }
}
