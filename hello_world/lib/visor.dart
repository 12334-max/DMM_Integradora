import 'package:flutter/material.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

class VisorPDF extends StatefulWidget {
  VisorPDF({Key key, this.title, this.archivo}) : super(key: key);

  final String title;
  final String archivo;

  @override
  _VisorPDFState createState() => _VisorPDFState();
}

class _VisorPDFState extends State<VisorPDF> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: PDF.asset(
          widget.archivo,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ));
  }
}
