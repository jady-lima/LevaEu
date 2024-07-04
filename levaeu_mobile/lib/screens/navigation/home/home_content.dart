import 'package:flutter/material.dart';
import 'package:levaeu_mobile/model/race.dart';
import 'package:levaeu_mobile/model/user_data.dart';
import 'package:levaeu_mobile/controllers/race_controller.dart';
import 'package:levaeu_mobile/utils/titles_screens.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomeContent extends StatefulWidget {
  final Function(int) onItemTapped;

  const HomeContent({super.key, required this.onItemTapped});

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  bool _isLoading = true;
  List<Race> _upcomingRaces = [];

  @override
  void initState() {
    super.initState();
    _fetchUpcomingRaces();
  }

Future<void> _fetchUpcomingRaces() async {
  final user = Provider.of<UserData>(context, listen: false);
  final raceController = Provider.of<RaceController>(context, listen: false);

  setState(() {
    _isLoading = true;
  });

  try {
    await raceController.fetchOpenRaces(user.token, user.idUser);
    setState(() {
      _upcomingRaces = raceController.getNextThreeRaces();
    });
  } catch (e) {
    print('Erro ao buscar corridas: $e');
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            constraints: const BoxConstraints(maxWidth: 300, minWidth: 220),
            margin: const EdgeInsets.only(top: 20, left: 25, bottom: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              "Olá, ${userData.name}!",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Color.fromRGBO(0, 0, 0, 1),
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.only(left: 20),
            //constraints: const BoxConstraints(maxWidth: 320, minWidth: 220),
            color: Colors.black,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 0.8,
          ),
          
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            constraints: const BoxConstraints(maxWidth: 320, minWidth: 220),
            child: TitlesScreens.buildHomeMainTitle("Próximas corridas: "),
          ),

          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _upcomingRaces.isEmpty
                  ? const Center(
                      child: Card(
                        color: Colors.white,
                        child: SizedBox(
                          width: 320,
                          height: 100,
                          child: Center(
                            child: Text(
                              "Sem corridas até o momento",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _upcomingRaces.length,
                      itemBuilder: (context, index) {
                        final race = _upcomingRaces[index];
                        final dateFormat = DateFormat('HH:mm dd/MM/yyyy');
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
                          child: Card(
                            color: Colors.white,
                            child: ListTile(
                              leading: const Icon(Icons.car_crash_rounded),
                              title: Text('Para: ${race.destinoName}'),
                              subtitle: Text(
                                  'Motorista: ${race.motoristaName}\nHorário: ${dateFormat.format(race.data)}'),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              ),
                              onTap: () {
                                widget.onItemTapped(2);
                              },
                            ),
                          ),
                        );
                      },
                    ),
        ],
      ),
    );
  }
}
