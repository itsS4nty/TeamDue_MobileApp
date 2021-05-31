import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Registro extends StatefulWidget {
  @override
  _nameState createState() => _nameState();
}

class _nameState extends State<Registro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro"),
      ),
      body: ListView(
        children: <Widget>[
          usuario(),
          nombre(),
          apellido1(),
          apellido2(),
          correo(),
          password(),
          confirmarPassword(),
          botonRegistrar()
        ],
      ),
    );
  }
}

final usuarioCampo = TextEditingController();
final nombreCampo = TextEditingController();
final apellido1Campo = TextEditingController();
final apellido2Campo = TextEditingController();
final correoCampo = TextEditingController();
final passwordCampo = TextEditingController();
final confirmarPasswordCampo = TextEditingController();

class usuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 10.0, left: 20.0, right: 20.0, bottom: 1.0),
      child: TextFormField(
        controller: usuarioCampo,
        scrollPadding: EdgeInsets.all(10),
        obscureText: false,
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: "Usuario"),
      ),
    );
  }
}

class nombre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 10.0, left: 20.0, right: 20.0, bottom: 1.0),
      child: TextField(
        controller: nombreCampo,
        scrollPadding: EdgeInsets.all(10),
        obscureText: false,
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: "Nombre"),
      ),
    );
  }
}

class apellido1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 10.0, left: 20.0, right: 20.0, bottom: 1.0),
      child: TextField(
        controller: apellido1Campo,
        scrollPadding: EdgeInsets.all(10),
        obscureText: false,
        decoration: InputDecoration(
            border: OutlineInputBorder(), labelText: "Primer apellido"),
      ),
    );
  }
}

class apellido2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 10.0, left: 20.0, right: 20.0, bottom: 1.0),
      child: TextField(
        controller: apellido2Campo,
        scrollPadding: EdgeInsets.all(10),
        obscureText: false,
        decoration: InputDecoration(
            border: OutlineInputBorder(), labelText: "Segundo apellido"),
      ),
    );
  }
}

class correo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 10.0, left: 20.0, right: 20.0, bottom: 1.0),
      child: TextField(
        controller: correoCampo,
        scrollPadding: EdgeInsets.all(10),
        obscureText: false,
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: "Correo"),
      ),
    );
  }
}

class password extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 10.0, left: 20.0, right: 20.0, bottom: 5.0),
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

class confirmarPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 10.0, left: 20.0, right: 20.0, bottom: 5.0),
      child: TextField(
        controller: confirmarPasswordCampo,
        scrollPadding: EdgeInsets.all(10),
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(), labelText: "Confirmar password"),
      ),
    );
  }
}

class botonRegistrar extends StatelessWidget {
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

          // logeando(usuarioCampo.text, passwordCampo.text, context);

          if (usuarioCampo.text.isEmpty ||
              passwordCampo.text.isEmpty ||
              nombreCampo.text.isEmpty ||
              apellido1Campo.text.isEmpty ||
              apellido2Campo.text.isEmpty ||
              correoCampo.text.isEmpty) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                      title: Text("Error"),
                      content: Text("Rellena todos los campos"),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Aceptar"))
                      ],
                    ));
          } else {
            if (confirmarPasswordCampo.text == passwordCampo.text) {
              registrado(
                      usuarioCampo.text,
                      passwordCampo.text,
                      nombreCampo.text,
                      apellido1Campo.text,
                      context,
                      apellido2Campo.text,
                      correoCampo.text)
                  .then((value) => {
                        if (value)
                          {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => AlertDialog(
                                      title: Text("¡Éxito!"),
                                      content: Text(
                                          "Usuario registrado correctamente, se ha enviado un mail para validar la cuenta de usuario"),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () {
                                              usuarioCampo.clear();
                                              nombreCampo.clear();
                                              correoCampo.clear();
                                              apellido1Campo.clear();
                                              apellido2Campo.clear();
                                              passwordCampo.clear();
                                              confirmarPasswordCampo.clear();
                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                      "/",
                                                      (Route<dynamic> route) =>
                                                          false);
                                            },
                                            child: Text("Aceptar"))
                                      ],
                                    ))
                          }
                        else
                          {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text("Error"),
                                      content:
                                          Text("Usuario o correo ya existente"),
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
            } else {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                        title: Text("Password error"),
                        content: Text("Las contraseñas no son iguales"),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Aceptar"))
                        ],
                      ));
            }
          }
        },
        child: Text('Registrar'),
      ),
    );
  }
}

Future<bool> registrado(
    usuario, password, nombre, apellido1, context, apellido2, correo) async {
  Map data = {
    "usuario": usuario,
    "password": password,
    "apellido1": apellido1,
    "apellido2": apellido2,
    "nombre": nombre,
    "correo": correo
  };

  var headers = {'Content-type': 'application/json'};

  final response = await http.post(
      Uri.parse("http://51.38.225.18:3000/register"),
      body: jsonEncode(data),
      headers: headers);

  print("Status code: " + response.statusCode.toString());

  if (response.statusCode == 201) {
    Navigator.of(context).pop();
    return true;
  } else {
    print(response.body);
    return false;
  }
}
