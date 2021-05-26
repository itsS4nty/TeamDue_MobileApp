import 'package:flutter/material.dart';
import 'package:app/models/archivos.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// late SharedPreferences sharedPreferences;

class Inicio extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Inicio> {
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
                  }))
            }
          else
            {
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
            child: ListView.builder(
          itemCount: _listaArchivos.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.amber, width: 1))),
              child: Text(
                _listaArchivos[index].nombre + "." + _listaArchivos[index].tipo,
                style: TextStyle(fontSize: 16),
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
  print(idUsu);

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
    throw Exception("Fallo en la conexión");
  }
}
