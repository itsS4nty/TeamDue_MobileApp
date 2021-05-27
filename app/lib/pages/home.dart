import 'package:app/pages/image.dart';
import 'package:flutter/material.dart';
import 'package:app/models/archivos.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// late SharedPreferences sharedPreferences;

class Inicio extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Inicio> {
  bool loading = true;
  late List<Archivos> _listaArchivos = [];
  late String token = "";

  @override
  void initState() {
    super.initState();
    getToken().then((valueToken) => {
          if (valueToken != "null")
            {
              getId().then((value) => _getArchivos(value).then((valueArchivos) {
                    setState(() {
                      _listaArchivos.addAll(valueArchivos);
                    });
                  })),
              loading = false
            }
          else
            {
              loading = false,
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/", (Route<dynamic> route) => false)
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Inicio"),
        backgroundColor: Colors.amber[400],
        actions: <Widget>[
          TextButton(
              onPressed: () {
                // sharedPreferences.clear();
                clearPrefrences();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    "/", (Route<dynamic> route) => false);
              },
              child: Text(
                "Cerrar Sesión",
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
      body: new Column(children: [
        Expanded(
            child: loading == true
                ? Center(
                    child: Container(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ListView.builder(
                    itemCount: _listaArchivos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        // return InkWell(
                        onTap: () {
                          // print(_listaArchivos[index].id);
                          // getToken().then((value) => descargarArchivo(
                          //     _listaArchivos[index].id, value, context));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImagePage(
                                      _listaArchivos[index].id.toString(),
                                      _listaArchivos[index].nombre +
                                          "." +
                                          _listaArchivos[index].tipo)));
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.amber, width: 1))),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _listaArchivos[index].tipo == "txt"
                                  ? Image.asset("assets/images/texto.png")
                                  : Image.asset("assets/images/imagen.png"),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                _listaArchivos[index].nombre +
                                    "." +
                                    _listaArchivos[index].tipo,
                                style: TextStyle(fontSize: 16),
                              ),
                              Spacer(),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: Colors.amber[400],
                                      onSurface: Colors.grey),
                                  onPressed: () {
                                    print(_listaArchivos[index].id);
                                    getToken().then((value) => descargarArchivo(
                                        _listaArchivos[index].id,
                                        value,
                                        context));
                                  },
                                  child: Text("Descargar"))
                            ],
                          ),
                        ),
                      );
                    },
                  ))
      ]),
    );
  }
}

Future<void> clearPrefrences() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

Future<int> getId() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.getInt("idUsuario") ?? -1;
}

Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.getString("token") ?? "null";
}

Future<List<Archivos>> _getArchivos(idUsu) async {
  final response = await http
      .get(Uri.parse("http://51.38.225.18:3000/files/" + idUsu.toString()));

  List<Archivos> archivos = [];

  if (response.statusCode == 200) {
    print("Status code: 200");
    String body = utf8.decode(response.bodyBytes);
    final jsonData = jsonDecode(body);
    for (var item in jsonData) {
      archivos.add(Archivos(
          item["id"], item["nombre"], item["tipo"], item["UsuarioId"]));
      print(item);
    }
    return archivos;
  } else {
    return [];
  }
}

descargarArchivo(idArchivo, token, context) async {
  try {
    var imageId = await ImageDownloader.downloadImage(
        "http://51.38.225.18:3000/downloadFile/" + idArchivo.toString());
    if (imageId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No se ha podido descargar el archivo")));
      return;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Archivo descargado")));
    }
  } on PlatformException catch (error) {
    print(error);
  }
}

verArchivo(idArchivo, token, context) async {}
