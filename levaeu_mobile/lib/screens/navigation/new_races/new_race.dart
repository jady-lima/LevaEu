import 'package:flutter/material.dart';

class NewRace extends StatefulWidget{
  const NewRace({super.key});

  @override
  _NewRaceState createState() => _NewRaceState();
}

class _NewRaceState extends State<NewRace> {
  @override
  Widget build(BuildContext context) {
    return Stack ( 
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              
              Container(
                height: 200,
                color: Colors.green,
                child: const Center(child: Text('Tela de corridas')),
              ),

              Container(
                height: 200,
                color: Colors.blue,
                child: const Center(child: Text('Tela de corridas')),
              ),
              
              Container(
                height: 200,
                color: Colors.red,
                child: const Center(child: Text('Tela de corridas')),
              ),
              
              Container(
                height: 200,
                color: Colors.yellow,
                child: const Center(child: Text('Tela de corridas')),
              ),               

            ],
          ),
        ),

        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: FloatingActionButton(
            backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
            onPressed: () {
              // Ação do botão
            },
            child: const Icon(
              Icons.add,
              color: Color.fromRGBO(57, 96, 143, 1.0),
            ),
          ),
        ),

      ],
    );
  }
}