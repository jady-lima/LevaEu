import 'package:flutter/material.dart';
import 'package:levaeu_mobile/model/driver_car.dart';
import 'package:levaeu_mobile/model/driver_license.dart';
import 'package:levaeu_mobile/model/driver_user.dart';
import 'package:levaeu_mobile/model/race.dart';
import 'package:levaeu_mobile/model/user_data.dart';
import 'package:levaeu_mobile/controllers/race_controller.dart';
import 'package:levaeu_mobile/screens/navigation/new_races/create_new_race.dart';
import 'package:levaeu_mobile/screens/navigation/new_races/map_screen.dart';
import 'package:provider/provider.dart';

class NewRace extends StatefulWidget {
  const NewRace({super.key});

  @override
  _NewRaceState createState() => _NewRaceState();
}

class _NewRaceState extends State<NewRace> {
  @override
  void initState() {
    super.initState();
    _initializeUserAsDriver();
  }

  void _initializeUserAsDriver() async {
    await Future.delayed(Duration.zero); // Aguarda a construção inicial dos widgets
    final userData = Provider.of<UserData>(context, listen: false);
    final driverLicense = DriverLicense(
      registro: '123456',
      dataEmissao: DateTime.now().toString(),
      dataValidade: DateTime.now().add(Duration(days: 365)).toString(),
      categoria: 'B',
      cpf: '123.456.789-00',
    );
    final driverCar = DriverCar(
      marca: 'Toyota',
      modelo: 'Corolla',
      cor: 'Prata',
      placa: 'ABC-1234',
      year: '2020',
    );

    userData.convertToDriver(driverLicense, driverCar);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserData, RaceController>(
      builder: (context, user, raceController, child) {
        final user1 = UserData(
          name: "Hermonie",
          email: "hermonie@gmail.com",
          matricula: "123456",
          phone: "99999999999",
          cep: "55555555",
          street: "Alguma",
          number: "10",
          district: "cidade ai",
          city: "cidade ai",
          state: "Algum",
          country: "dos bobos",
          pass: "password",
          gender: "Feminino",
        );

        final List<UserData> passageiros = [user1, user1, user1];

        final pass1 = Race(
          saida: "IMD",
          destino: "Natal Shopping",
          data: DateTime(2024, 12, 25),
          horario: const TimeOfDay(hour: 15, minute: 30),
          motorista: user1,
          passageiros: passageiros,
        );

        final List<Race> openRaces = [pass1];
        final Race? activeRace = raceController.activeRace;


        return Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                if (user.driverCar != null) ...[
                  Container(
                    constraints: const BoxConstraints(maxWidth: 350, minWidth: 240),
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 15, left: 5, bottom: 10),
                    child: const Text(
                      "Minha Corrida Ativa",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                  ),
                  if (activeRace != null)
                    RaceCard(race: activeRace)
                  else
                    Container(
                      constraints: const BoxConstraints(maxWidth: 350, minWidth: 40),
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 15, left: 5, bottom: 10),
                      child: const Text(
                        "Você não lançou uma corrida",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color.fromRGBO(150, 150, 150, 1),
                        ),
                      ),
                    ),
                ],
                Container(
                  constraints: const BoxConstraints(maxWidth: 350, minWidth: 240),
                  margin: const EdgeInsets.only(top: 15, left: 5, bottom: 10),
                  alignment: Alignment.center,
                  child: const Text(
                    "Corridas Abertas",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: openRaces.length,
                          itemBuilder: (context, index) {
                            final race = openRaces[index];
                            return RaceCard(race: race);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (user.driverCar != null)
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: FloatingActionButton(
                  backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen()));
                  },
                  child: const Icon(
                    Icons.add,
                    color: Color.fromRGBO(57, 96, 143, 1.0),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class RaceCard extends StatelessWidget {
  final Race race;

  const RaceCard({Key? key, required this.race}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
      child: Card(
        color: const Color.fromRGBO(255, 255, 255, 1.0),
        margin: const EdgeInsets.all(10.0),
        child: ListTile(
          leading: const Icon(Icons.person_outline_sharp),
          trailing: const CircleAvatar(
            backgroundColor: Color.fromRGBO(57, 96, 143, 1.0),
            child: Icon(
              Icons.drive_eta_outlined,
              color: Colors.white,
            ),
          ),
          title: Text("${race.motorista.name}\n${race.saidaName} \u2192 ${race.destinoName}"),
          subtitle: Text("Horário: ${race.horario.format(context)}"),
          onTap: () {
            // Lógica para abrir detalhes da corrida
            //Navigator.push();
          },
        ),
      ),
    );
  }
}
