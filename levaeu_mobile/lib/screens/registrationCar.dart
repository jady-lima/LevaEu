

import 'package:flutter/material.dart';
import 'package:levaeu_mobile/utils/titles_screens.dart';

class RegistrationCar extends StatefulWidget{
  const RegistrationCar({super.key});

  @override
  _RegistrationCarState createState() => _RegistrationCarState();
}

class _RegistrationCarState extends State<RegistrationCar> {

 final _formKeyRegistration = GlobalKey<FormState>();

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(184, 184, 184, 0),
        iconTheme: const IconThemeData(color: Color.fromRGBO(57, 96, 143, 1.0)),
      ),

      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            children: <Widget>[
              
              Container(
                width: 120,
                height: 120,
                child: const Icon(Icons.drive_eta_rounded, color: Color.fromRGBO(57, 96, 143, 1.0), size: 100,)
              ),

              Container(
                margin: const EdgeInsets.only( bottom: 10),
                constraints: const BoxConstraints(maxWidth: 350),
                child: TitlesScreens.buildMainTitle("Informações do Veículo")
              ),

              Container(
                constraints: const BoxConstraints(maxWidth: 250),
                child: TitlesScreens.buildSecondaryTitle("Por favor, nos informe os dados do seu veículo para finalizar a criação da sua conta")
              ),

              Form(
                key: _formKeyRegistration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget> []
                )
              )
            ]
          )
        ]
      )
    );
  }

}