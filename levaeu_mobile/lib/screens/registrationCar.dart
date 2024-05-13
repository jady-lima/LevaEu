

import 'package:flutter/material.dart';

class RegistrationCar extends StatefulWidget{
  const RegistrationCar({super.key});

  @override
  _RegistrationCarState createState() => _RegistrationCarState();
}

class _RegistrationCarState extends State<RegistrationCar> {

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(184, 184, 184, 0),
        iconTheme: const IconThemeData(color: Color.fromRGBO(57, 96, 143, 1.0)),
      ),

      body: const Text("Registro carro"),
    );
  }

}