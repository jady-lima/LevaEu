import 'package:flutter/material.dart';

class CreateNewRace extends StatefulWidget{
  const CreateNewRace({super.key});

  @override
  _CreateNewRaceState createState() => _CreateNewRaceState();
}

class _CreateNewRaceState extends State<CreateNewRace>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,

      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(57, 96, 143, 1.0),
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Nova corrida",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Text("Tela de criar nova Corrida!"),
    );
  }
}