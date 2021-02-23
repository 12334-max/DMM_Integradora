import 'package:flutter/material.dart';
import 'package:todo/src/pages/TaskForm.dart';
import 'package:todo/src/pages/TaskList.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final List<String> tasks = <String>[];
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Aplicación de control'),
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: 'Cestos de basura',
                  ),
                  Tab(
                    text: 'Nueva',
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Center(
                  child: TaskList(),
                ),
                Center(
                  child: TaskForm(),
                ),
              ],
            )));
  }
}
