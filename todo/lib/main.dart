import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo/src/models/TaskListModel.dart';
import 'package:todo/src/pages/Login.dart';
import 'package:todo/src/pages/TaskForm.dart';
import 'package:todo/src/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<TaskListModel>(
        model: new TaskListModel(),
        child: MaterialApp(
            title: 'Aplicacion de Control',
            debugShowCheckedModeBanner: false,
            initialRoute: "/",
            routes: <String, WidgetBuilder>{
              "/": (context) => Login(),
              "/home": (context) => Home(),
              "/edit": (context) => Scaffold(
                    appBar: AppBar(
                      title: Text("Estado"),
                    ),
                    body: TaskForm(),
                  ),
            }));
  }
}
