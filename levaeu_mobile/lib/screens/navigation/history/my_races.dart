import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:levaeu_mobile/model/history_data.dart';
import 'package:levaeu_mobile/model/user_data.dart';
import 'package:provider/provider.dart';

class MyRaces extends StatefulWidget {
  const MyRaces({super.key});

  @override
  _MyRacesState createState() => _MyRacesState();
}

class _MyRacesState extends State<MyRaces> {
  bool driverUser = true;

  @override
  Widget build(BuildContext context) {
    final userMotorista = Provider.of<UserData>(context);
    final user1 = UserData(
      name: "Hermonie",
      email: "hermonie@gmail.com",
      phone: "99999999999",
      cep: "55555555",
      street: "Alguma",
      number: "10",
      district: "cidade ai",
      city: "cidade ai",
      state: "Algum",
      country: "dos bobos",
      gender: "Feminino",
    );

    final List<UserData> passageiros1 = [user1, user1, user1];
    final List<UserData> passageiros2 = [userMotorista, user1, user1];

    final pass2 = HistoryData(
      saida: "Natal",
      destino: "Parnamirim",
      data: DateTime(2024, 6, 10),
      horario: const TimeOfDay(hour: 11, minute: 0),
      motorista: userMotorista,
      passageiros: passageiros1,
    );

    final pass1 = HistoryData(
      saida: "IMD",
      destino: "Natal Shopping",
      data: DateTime(2024, 12, 25),
      horario: const TimeOfDay(hour: 15, minute: 0),
      motorista: user1,
      passageiros: passageiros2,
    );

    final List<HistoryData> passageiroViagens = [pass1, pass1, pass1];
    final List<HistoryData> motoristaViagens = [pass2, pass2, pass2];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
            child: _buildHistory(driverUser ? motoristaViagens : passageiroViagens),
          ),
        ),
      ],
    );
  }

  Widget _buildHistory(List<HistoryData> items) {
    if (items.isEmpty) {
      return const Card(
        color: Color.fromRGBO(255, 255, 255, 1.0),
        margin: EdgeInsets.all(10.0),
        child: ListTile(
          title: Text("Não há histórico de corrida."),
        ),
      );
    } else {
      return Column(
        children: items.map((item) => Card(
          color: const Color.fromRGBO(255, 255, 255, 1.0),
          margin: const EdgeInsets.all(10.0),
          child: ListTile(
            title: Text("Destino: ${item.destino}"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Saída: ${item.saida}"),
                Text("Data: ${DateFormat('dd/MM/yyyy').format(item.data)}"),
                Text("Horário: ${item.horario.format(context)}"),
                Text("Motorista: ${item.motorista.name}"),
                Text("Passageiros: ${item.passageiros.map((p) => p.name).join(', ')}"),
              ],
            ),
          ),
        )).toList(),
      );
    }
  }
}
