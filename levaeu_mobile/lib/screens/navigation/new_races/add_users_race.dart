import 'package:flutter/material.dart';

class AddUsersRace extends StatefulWidget{
  const AddUsersRace({super.key});

  @override
  _AddUsersRaceState createState() => _AddUsersRaceState();
}

class _AddUsersRaceState extends State<AddUsersRace>{
  bool _isLoading = true;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Center(
          child: Text(
            "Sua corrida",
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 24,
              color: Color.fromRGBO(65, 65, 65, 1)
            )
          ),
        ),

        Center(
          child: Image.asset('img/user.png')
        ),

        const Center(
          child: Text(
            "Passageiros",
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 24,
              color: Color.fromRGBO(65, 65, 65, 1)
            )
          ),
        ),

        //SUBSTITUIR PELA LISTA RECUPERADA DO BACK
        const Text("Lista de usuário na corrida"),
        
        const Text("Solicitantes"),
        //SUBSTITUIR PELA LISTA RECUPERADA DO BACK
        const Text("Botões de solicitantes"),

        const Text(
          "Informações: ",
          textAlign: TextAlign.center,
          softWrap: true,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 24,
            color: Color.fromRGBO(65, 65, 65, 1)
          )
        ),

        //PREENCHER COM OS DADOS DA CORRIDA QUE VEM DO BACK
        const Text("Data da carona: "),
        const Text("Horário: "),
        const Text("Embarque: "),
        const Text("Desembarque: "),

      ],
    );
  }
}

