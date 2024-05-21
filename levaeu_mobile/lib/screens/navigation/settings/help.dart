import 'package:flutter/material.dart';

class Help extends StatefulWidget{
  const Help({super.key});

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,

      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(57, 96, 143, 1.0),
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Suporte",
          style: TextStyle(color: Colors.white),
        ),
      ),
      

      body: const Text("Tela de Suporte"),
    );
  }
}