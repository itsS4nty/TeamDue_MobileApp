import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        // debugShowCheckedModeBanner: false,
        home: login());
  }
}

class login extends StatelessWidget {
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
          botonRecordarPassword(),
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

class usuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 20.0, left: 20.0, right: 20.0, bottom: 1.0),
      child: TextField(
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
        },
        child: Text('Si no tienes cuenta. ¡Registrate!'),
      ),
    );
  }
}
