

import 'package:flutter/material.dart';

class RegistrationCar extends StatefulWidget{
  @override
  _RegistrationCarState createState() => _RegistrationCarState();
}

class _RegistrationCarState extends State<RegistrationCar> {

 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(184, 184, 184, 0),
        iconTheme: const IconThemeData(color: Color.fromRGBO(57, 96, 143, 1.0)),
      ),

      body: Text("Registro carro"),
    );
  }

}