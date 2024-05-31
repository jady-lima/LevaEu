import 'package:flutter/material.dart';

class MyRaces extends StatefulWidget{
  const MyRaces({super.key});

  @override
  _MyRacesState createState() => _MyRacesState();
}

class _MyRacesState extends State<MyRaces> {
  bool driverUser = true;

  @override
  Widget build(BuildContext context) {
    final List<String> passageiroViagens = ['Passageiro 1', 'Passageiro 2', 'Passageiro 3'];
    final List<String> motoristaViagens = [];

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      driverUser = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: const Text("Passageiro"),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      driverUser = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: const Text("Motorista"),
                ),
              ),
            ],
          ),

          Expanded(
            child: SingleChildScrollView(
              child: _buildHistory( driverUser ? motoristaViagens : passageiroViagens),
            ),
          ),


        ],
      
    );
  }

  Widget _buildHistory(List<String> items){
    if (items.isEmpty) {
       return const Card(
        margin: EdgeInsets.all(10.0),
        child: ListTile(
          title: Text("Não há histórico de corrida."),
        ),
      );
    } else {
      return Column(
        children: items.map((item) => Card(
          margin: const EdgeInsets.all(10.0),
          child: ListTile(
            title: Text(item),
          ),
        )).toList(),
      );
    }
  }
}