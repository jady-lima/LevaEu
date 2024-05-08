import 'package:flutter/material.dart';
import 'package:levaeu_mobile/utils/titles_screens.dart';

class RegistrationCNH extends StatefulWidget{
  @override
  _RegistrationCNHState createState() => _RegistrationCNHState();
}

class _RegistrationCNHState extends State<RegistrationCNH> {
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
              
              //Container: Icon driver_license
              Container(
                padding: const EdgeInsets.all(0),
                width: 120,
                height: 120,
                child: ClipRRect(
                  child: Image.asset('img/driver_license.png'),
                ),
              ),

              Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.only( bottom: 10),
                constraints: const BoxConstraints(maxWidth: 350),
                child: TitlesScreens.buildMainTitle("Carteira Nacional de Habilitação")
              ),

              Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.all(0),
                constraints: const BoxConstraints(maxWidth: 250),
                child: TitlesScreens.buildSecondaryTitle("Por favor, nos informe os dados da sua CNH para continuar com a criação da sua conta")
              ),

            ],
          )
        ],
      ),
    );
  }
}