import 'package:flutter/material.dart';

class NewRace extends StatefulWidget{
  const NewRace({super.key});

  @override
  _NewRaceState createState() => _NewRaceState();
}

class _NewRaceState extends State<NewRace> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          
          Container(
            height: 200,
            color: Colors.green,
            child: Center(child: Text('Tela de corridas')),
          ),

        ],
      ),
    );
  }
}