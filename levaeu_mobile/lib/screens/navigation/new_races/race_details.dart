import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:levaeu_mobile/api/google_places_service.dart';
import 'package:levaeu_mobile/model/location.dart';
import 'package:levaeu_mobile/model/place.dart';
import 'package:levaeu_mobile/model/place_details.dart';
import 'package:levaeu_mobile/model/race.dart';
import 'package:levaeu_mobile/model/user_request.dart';
import 'package:provider/provider.dart';
import 'package:levaeu_mobile/model/user_data.dart';
import 'package:levaeu_mobile/controllers/race_controller.dart';
import 'package:uuid/uuid.dart';

class RaceDetailsScreen extends StatefulWidget {
  final Race race;

  const RaceDetailsScreen({Key? key, required this.race}) : super(key: key);

  @override
  _RaceDetailsScreenState createState() => _RaceDetailsScreenState();
}

class _RaceDetailsScreenState extends State<RaceDetailsScreen> {
  final TextEditingController _locationController = TextEditingController();
  bool _isPickup = true;
  bool _isLoading = false;
  bool _isSearching = false;
  List<Place> _places = [];
  PlaceDetails? _selectedPlace;

  late String sessionToken;
  late GooglePlacesService _placesService;

  @override
  void initState() {
    super.initState();
    sessionToken = const Uuid().v4();
    _placesService = GooglePlacesService(apiKey: dotenv.env['GOOGLE_MAPS_API_KEY']!);
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  void _submitRequest(BuildContext context) async {
    final user = Provider.of<UserData>(context, listen: false);
    final raceController = Provider.of<RaceController>(context, listen: false);

    if (_selectedPlace == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecione um local de parada válido')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final location = Location(
      name: _selectedPlace!.name,
      latitude: _selectedPlace!.lat,
      longitude: _selectedPlace!.lng,
    );

    final userRequest = UserRequest(
      idUser: user.idUser,
      idRide: widget.race.idRace,
      location: location,
      isPickup: _isPickup,
    );

    try {
      print('Submitting user request: ${userRequest.toJson()}');
      await raceController.submitUserRequest(userRequest.toJson(), user.token);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Requisição enviada com sucesso')),
      );
      Navigator.pop(context); // Voltar para a tela anterior
    } catch (e) {
      print('Failed to submit user request: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao enviar requisição')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _searchPlaces(String query) async {
    setState(() {
      _isSearching = true;
    });
    try {
      final places = await _placesService.fetchPlaces(query, sessionToken);
      setState(() {
        _places = places;
        _isSearching = false;
      });
    } catch (e) {
      setState(() {
        _isSearching = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Falha ao buscar locais')));
    }
  }

  void _fetchPlaceDetails(String placeId) async {
    try {
      final placeDetails = await _placesService.fetchPlaceDetails(placeId, sessionToken);
      setState(() {
        _locationController.text = '${placeDetails.name}, ${placeDetails.formattedAddress}';
        _selectedPlace = placeDetails;
        _places = [];
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Falha ao carregar detalhes do local')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Corrida'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Motorista: ${widget.race.motoristaName}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Saída: ${widget.race.saidaName}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Destino: ${widget.race.destinoName}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Horário: ${widget.race.horario.format(context)}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _locationController,
                    decoration: const InputDecoration(labelText: 'Local de Parada'),
                    onChanged: _searchPlaces,
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Wrap(
                      spacing: 10.0,
                      runSpacing: 100.0,
                      children: [
                        ChoiceChip(
                          label: const Text('Embarque'),
                          selected: _isPickup,
                          onSelected: (selected) {
                            setState(() {
                              _isPickup = true;
                            });
                          },
                        ),
                        ChoiceChip(
                          label: const Text('Desembarque'),
                          selected: !_isPickup,
                          onSelected: (selected) {
                            setState(() {
                              _isPickup = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _submitRequest(context),
                      child: const Text('Enviar Solicitação'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_places.isNotEmpty && !_isSearching)
                    Expanded(
                      child: ListView.builder(
                        itemCount: _places.length,
                        itemBuilder: (context, index) {
                          final place = _places[index];
                          return ListTile(
                            title: Text(place.description),
                            onTap: () => _fetchPlaceDetails(place.placeId),
                          );
                        },
                      ),
                    ),
                  if (_isSearching)
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
    );
  }
}
