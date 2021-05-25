import 'package:flutter/material.dart';
import 'package:app/models/archivos.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Inicio extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Inicio> {
  late Future<List<Archivos>> _listaArchivos;
  late SharedPreferences sharedPreferences;

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString("token"));
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/", (Route<dynamic> route) => false);
    }
  }

  Future<List<Archivos>> _getArchivos() async {
    final response =
        await http.get(Uri.parse("http://51.38.225.18:3000/files/8"));

    List<Archivos> archivos = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData) {
        archivos.add(Archivos(
            item["id"], item["nombre"], item["tipo"], item["UsuarioId"]));
      }

      return archivos;
    } else {
      throw Exception("Fallo en la conexión");
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    _listaArchivos = _getArchivos();
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
                sharedPreferences.clear();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    "/", (Route<dynamic> route) => false);
              },
              child: Text(
                "Cerrar Sesión",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: new Container(
        child: new Text("Hola"),
      ),
    );
  }
}
