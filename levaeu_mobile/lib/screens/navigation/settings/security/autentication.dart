import 'package:flutter/material.dart';

class Autentication extends StatefulWidget {
  const Autentication({Key? key}) : super(key: key);

  @override
  _AutenticationState createState() => _AutenticationState();
}

class _AutenticationState extends State<Autentication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,

      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(57, 96, 143, 1.0),
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Autenticação de dois fatores",
          style: TextStyle(color: Colors.white),
        ),
      ),
      
      body: const Text("Tela de Autenticação"),
    );
  }
}
