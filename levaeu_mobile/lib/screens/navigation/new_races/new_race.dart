import 'package:flutter/material.dart';
import 'package:levaeu_mobile/model/race.dart';
import 'package:levaeu_mobile/model/user_data.dart';
import 'package:levaeu_mobile/controllers/race_controller.dart';
import 'package:levaeu_mobile/screens/navigation/new_races/add_users_race.dart';
import 'package:levaeu_mobile/screens/navigation/new_races/map_screen.dart';
import 'package:levaeu_mobile/screens/navigation/new_races/race_details.dart';
import 'package:provider/provider.dart';

class NewRace extends StatefulWidget {
  const NewRace({super.key});

  @override
  _NewRaceState createState() => _NewRaceState();
}

class _NewRaceState extends State<NewRace> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchOpenRaces();
    _fetchDriverRaces();
  }

  Future<void> _fetchOpenRaces() async {
    final user = Provider.of<UserData>(context, listen: false);
    final raceController = Provider.of<RaceController>(context, listen: false);

    try {
      await raceController.fetchOpenRaces(user.token, user.idUser);
    } catch (e) {
      print('Erro ao buscar corridas abertas: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchDriverRaces() async {
    final user = Provider.of<UserData>(context, listen: false);
    final raceController = Provider.of<RaceController>(context, listen: false);

    try {
      await raceController.fetchDriverRaces(user.token, user.idUser);
    } catch (e) {
      print('Erro ao buscar corridas do motorista: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserData, RaceController>(
      builder: (context, user, raceController, child) {
        return _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      if (user.driverCar != null) ...[
                        Container(
                          constraints: const BoxConstraints(maxWidth: 350, minWidth: 240),
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 15, left: 5, bottom: 10),
                          child: const Text(
                            "Minhas Corridas Ativas",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                          ),
                        ),
                        if (raceController.driverRaces.isNotEmpty)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: raceController.driverRaces.length,
                            itemBuilder: (context, index) {
                              final race = raceController.driverRaces[index];
                              return RaceCard(race: race);
                            },
                          )
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
                                itemCount: raceController.openRaces.length,
                                itemBuilder: (context, index) {
                                  final race = raceController.openRaces[index];
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const MapScreen()));
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

  const RaceCard({super.key, required this.race});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context, listen: false);

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
          title: Text("${race.motoristaName}\n${race.saidaName} \u2192 ${race.destinoName}"),
          subtitle: Text("Horário: ${race.horario.format(context)}"),
          onTap: () {
            if(race.motoristaID == user.idUser) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddUsersRace(race: race),
                ),
              );
            } else{
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RaceDetailsScreen(race: race),
                ),
              );
            }
          },
        )
      ),
    );
  }
}
