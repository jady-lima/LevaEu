import 'package:flutter/material.dart';

class Pix extends StatefulWidget {
  const Pix({Key? key}) : super(key: key);

  @override
  _PixState createState() => _PixState();
}

class _PixState extends State<Pix> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,

      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(57, 96, 143, 1.0),
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Pix",
          style: TextStyle(color: Colors.white),
        ),
      ),
      
      body: const Text("Tela de Pix"),
    );
  }
}
