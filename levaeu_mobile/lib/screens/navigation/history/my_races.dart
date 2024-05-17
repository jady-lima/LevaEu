import 'package:flutter/material.dart';

class MyRaces extends StatefulWidget{
  const MyRaces({super.key});

  @override
  _MyRacesState createState() => _MyRacesState();
}

class _MyRacesState extends State<MyRaces> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            color: Colors.blue,
            child: const Center(child: Text('Histórico')),
          ),
        ],
      ),
    );
  }
}