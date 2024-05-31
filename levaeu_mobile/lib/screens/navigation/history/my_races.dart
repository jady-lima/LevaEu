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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Container(
            constraints: const BoxConstraints(maxWidth: 300, minWidth: 240),
            margin: const EdgeInsets.only(top: 20, left: 25, bottom: 10),
            alignment: Alignment.centerLeft,
            child: const Text(
              "Histórico motorista",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Color.fromRGBO(0, 0, 0, 1),
              ),
            ),
          ),
          
           const Center(
            child: Card(
              color: Colors.white,
              child: SizedBox(
                width: 350,
                height: 100,
                child: Center(
                  child: Text(
                    "Sem históricos no momento",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}