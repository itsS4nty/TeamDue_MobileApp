import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TextPage extends StatefulWidget {
  final String idImage;
  final String nomImage;
  TextPage(this.idImage, this.nomImage, {Key? key}) : super(key: key);

  @override
  _nameState createState() => _nameState();
}

class _nameState extends State<TextPage> {
  late var imagen;
  @override
  void initState() {
    super.initState();
    getToken().then((valueToken) => {
          if (valueToken == "null")
            {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/", (Route<dynamic> route) => false)
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nomImage),
      ),
      body: Center(
        child: Text(http
            .read(Uri.parse("http://51.38.225.18:3000/file/" + widget.idImage))
            .toString()),
      ),
    );
  }
}

Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.getString("token") ?? "null";
}
