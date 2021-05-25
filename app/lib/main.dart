import 'package:app/pages/home.dart';
import 'package:app/pages/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.amber),
      routes: {"/": (context) => Login(), "/home": (context) => Inicio()},
      initialRoute: "/home",

      // debugShowCheckedModeBanner: false,
      // home: login());
    );
  }
}
