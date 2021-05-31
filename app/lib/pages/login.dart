import 'package:app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

class Login extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("TeamDue"),
        backgroundColor: Colors.amber[400],
      ),
      body: new ListView(
        children: <Widget>[
          logo(),
          usuario(),
          password(),
          botonLogin(),
          // botonRecordarPassword(),
          botonRegistrar()
        ],
      ),
    );
  }
}

class logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.0,
      width: 220.0,
      padding:
          EdgeInsets.only(left: 20.0, top: 80.0, right: 20.0, bottom: 20.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(200)),
      child: new Center(
        child: Image.asset("assets/images/logo_small.png"),
      ),
    );
  }
}

final usuarioCampo = TextEditingController();
final passwordCampo = TextEditingController();

class usuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 20.0, left: 20.0, right: 20.0, bottom: 1.0),
      child: TextField(
        controller: usuarioCampo,
        scrollPadding: EdgeInsets.all(10),
        obscureText: false,
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: "Usuario"),
      ),
    );
  }
}

class password extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 20.0, left: 20.0, right: 20.0, bottom: 5.0),
      child: TextField(
        controller: passwordCampo,
        scrollPadding: EdgeInsets.all(10),
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(), labelText: "Contraseña"),
      ),
    );
  }
}

class botonLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 90.0, top: 20.0, right: 90.0),
      child: TextButton(
        style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.amber[400],
            onSurface: Colors.grey),
        onPressed: () {
          print("Boton iniciar sesion pulsado");

          print("Usuario: " +
              usuarioCampo.text +
              " y password: " +
              passwordCampo.text);

          logeando(usuarioCampo.text, passwordCampo.text, context)
              .then((value) => {
                    if (value)
                      {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/home", (Route<dynamic> route) => false)
                      }
                    else
                      {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text("Login"),
                                  content:
                                      Text("Usuario o contraseña incorrecto "),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Aceptar"))
                                  ],
                                ))
                      }
                  });
        },
        child: Text('Iniciar sesión'),
      ),
    );
  }
}

class botonRecordarPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 1.0),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.amber[400],
        ),
        onPressed: () {
          print("Boton recordar contraseña pulsado");
        },
        child: Text('Recordar contraseña'),
      ),
    );
  }
}

class botonRegistrar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 1.0),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.amber[400],
        ),
        onPressed: () {
          print("Boton registrar pulsado");
          Navigator.of(context).pushNamed("/register");
        },
        child: Text('Si no tienes cuenta. ¡Registrate!'),
      ),
    );
  }
}

Future<bool> logeando(usuario, password, context) async {
  Map data = {"usuario": usuario, "password": password};

  var jsonData = null;
  var headers = {'Content-type': 'application/json'};

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final response = await http.post(Uri.parse("http://51.38.225.18:3000/login"),
      body: jsonEncode(data), headers: headers);

  print("Status code: " + response.statusCode.toString());

  if (response.statusCode == 200) {
    jsonData = json.decode(response.body);
    print(jsonData);

    sharedPreferences.setString("token", jsonData["token"]);
    print(jsonData["usuario"]["id"].runtimeType);
    sharedPreferences.setInt("idUsuario", jsonData["usuario"]["id"]);

    return true;
  } else {
    return false;
  }
}
