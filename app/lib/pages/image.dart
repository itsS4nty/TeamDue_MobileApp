import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class ImagePage extends StatelessWidget {
//   final String idImage;
//   const ImagePage(this.idImage, {Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Imagen"),
//       ),
//       body: Center(
//         child: Image.network("http://51.38.225.18:3000/file/" + idImage),
//       ),
//     );
//   }
// }

class ImagePage extends StatefulWidget {
  final String idImage;
  final String nomImage;
  ImagePage(this.idImage, this.nomImage, {Key? key}) : super(key: key);

  @override
  _nameState createState() => _nameState();
}

class _nameState extends State<ImagePage> {
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
        child: Image.network("http://51.38.225.18:3000/file/" + widget.idImage),
      ),
    );
  }
}

buscarImagen(idIm) async {
  return Image.network("http://51.38.225.18:3000/file/" + idIm);
}

Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.getString("token") ?? "null";
}
