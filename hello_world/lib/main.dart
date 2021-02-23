import 'package:app_dmm/visor.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desarrollo Móvil',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Desarrollo Móvil'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final picker = ImagePicker();
  File imagenUsuario;

  Future<void> _abreURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir la dirección: $url';
    }
  }

  Future getImage() async {
    final sourceMode = await showDialog<ImageSource>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Seleccionar imagen desde:'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ImageSource.camera);
                },
                child: const Text('Cámara'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
                child: const Text('Galería'),
              ),
            ],
          );
        });
    if (sourceMode != null) {
      final pickedFile = await picker.getImage(source: sourceMode);

      setState(() {
        if (pickedFile != null) {
          imagenUsuario = File(pickedFile.path);
        } else {
          print('No seleccionaste alguna imagen.');
        }
      });
    }
  }

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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _imgPerfil(),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 50),
                leading: Icon(Icons.picture_as_pdf, size: 30),
                title: Text('Manual de la App',
                    style:
                        TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
                subtitle: Text('Ejemplo de visor de archivos PDF'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VisorPDF(
                        title: widget.title,
                        archivo: 'pdf/Manual_App.pdf',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 50),
                leading: Icon(Icons.picture_as_pdf, size: 30),
                title: Text('Manual de Arduino',
                    style:
                        TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
                subtitle: Text('Ejemplo de visor de archivos PDF'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VisorPDF(
                        title: widget.title,
                        archivo: 'pdf/Manual_Arduino.pdf',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 50),
                leading: Icon(Icons.video_collection, size: 30),
                title: Text('Partida de Ajedrez',
                    style:
                        TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
                subtitle: Text('Ejemplo de abrir videos de YouTube'),
                onTap: () {
                  _abreURL('https://www.youtube.com/watch?v=TcOhrQR9wwI');
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 50),
                leading: Icon(Icons.videogame_asset, size: 30),
                title: Text('Nuevo X-Box',
                    style:
                        TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
                subtitle: Text('Ejemplo de abrir una publicación en Facebook'),
                onTap: () {
                  _abreURL('https://www.facebook.com/xbox/');
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 50),
                leading: Icon(Icons.web, size: 30),
                title: Text('UTSelva - Oficial',
                    style:
                        TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
                subtitle:
                    Text('Ejemplo de abrir una página normal en el navegador'),
                onTap: () {
                  _abreURL('http://www.utselva.edu.mx');
                },
              ),
            ],
          ),
        ));
  }

  Container _imgPerfil() {
    return Container(
      child: IconButton(
        icon: imagenUsuario == null
            ? Icon(Icons.person_outline, color: Colors.blueGrey)
            : ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.file(imagenUsuario)),
        iconSize: 100,
        onPressed: getImage,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: imagenUsuario == null
            ? Border.all(color: Colors.black87, width: 3)
            : null,
      ),
    );
  }
}
