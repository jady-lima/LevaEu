import 'package:flutter/material.dart';
import 'package:levaeu_mobile/model/race.dart';
import 'package:levaeu_mobile/model/user_data.dart';
import 'package:levaeu_mobile/controllers/race_controller.dart';
import 'package:levaeu_mobile/screens/navigation/new_races/route_map_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddUsersRace extends StatefulWidget {
  final Race race;

  const AddUsersRace({super.key, required this.race});

  @override
  _AddUsersRaceState createState() => _AddUsersRaceState();
}

class _AddUsersRaceState extends State<AddUsersRace> {
  bool _isLoading = true;
  List<Map<String, dynamic>> acceptedPassengers = [];

  @override
  void initState() {
    super.initState();
    _fetchPassengers();
  }

  Future<void> _fetchPassengers() async {
    final user = Provider.of<UserData>(context, listen: false);
    final raceController = Provider.of<RaceController>(context, listen: false);

    setState(() {
      _isLoading = true;
    });

    try {
      await raceController.fetchPassengerRequests(user.token, int.parse(widget.race.idRace));
      setState(() {
        acceptedPassengers = List.from(raceController.acceptedPassengers);
        _isLoading = false;
      });
    } catch (e) {
      print('Erro ao buscar passageiros: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _togglePassenger(Map<String, dynamic> passengerData) {
    setState(() {
      if (acceptedPassengers.any((p) => p['user']['id'] == passengerData['user']['id'])) {
        acceptedPassengers.removeWhere((p) => p['user']['id'] == passengerData['user']['id']);
      } else {
        if (acceptedPassengers.length >= 4) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Número máximo de passageiros atingido')),
          );
        } else {
          acceptedPassengers.add(passengerData);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final raceController = Provider.of<RaceController>(context);
    final dateFormat = DateFormat('HH:mm dd/MM/yyyy');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aceitar Passageiros'),
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Data da carona: ${dateFormat.format(widget.race.data)}",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Horário: ${widget.race.horario.format(context)}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Embarque: ${widget.race.saidaName}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Desembarque: ${widget.race.destinoName}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const Center(
                  child: Text(
                    "Passageiros aceitos",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                        color: Color.fromRGBO(65, 65, 65, 1)),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: acceptedPassengers.length,
                    itemBuilder: (context, index) {
                      final passengerData = acceptedPassengers[index];
                      final passenger = UserData.fromJson(passengerData['user']);
                      return ListTile(
                        title: Text(passenger.name),
                        subtitle: Text("Email: ${passenger.email}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            _togglePassenger(passengerData);
                          },
                        ),
                      );
                    },
                  ),
                ),
                const Divider(),
                const Center(
                  child: Text(
                    "Pedindo carona",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                        color: Color.fromRGBO(65, 65, 65, 1)),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: raceController.pendingPassengers.length,
                    itemBuilder: (context, index) {
                      final passengerData = raceController.pendingPassengers[index];
                      final passenger = UserData.fromJson(passengerData['user']);
                      final stopPoint = passengerData['userRide']['stopPoint'];
                      final departure = passengerData['userRide']['departure'] == true;
                      final locationType = departure ? 'Embarque' : 'Desembarque';

                      return ListTile(
                        title: Text(passenger.name),
                        subtitle: Text("$locationType -> ${stopPoint['name']}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.check, color: Colors.green),
                          onPressed: () {
                            _togglePassenger(passengerData);
                          },
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RouteMapScreen(
                          initialLocation: LatLng(widget.race.saidaLat, widget.race.saidaLng),
                          finalLocation: LatLng(widget.race.destinoLat, widget.race.destinoLng),
                          waypoints: acceptedPassengers.map((passengerData) {
                            final stopPoint = passengerData['userRide']['stopPoint'];
                            return LatLng(stopPoint['latitude'], stopPoint['longitude']);
                          }).toList(),
                        ),
                      ),
                    );
                  },
                  child: const Text('Visualizar Rota'),
                ),
              ],
            ),
    );
  }
}
