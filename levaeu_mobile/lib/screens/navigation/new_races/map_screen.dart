import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'package:levaeu_mobile/api/google_places_service.dart';
import 'package:levaeu_mobile/api/directions_service.dart';
import 'package:levaeu_mobile/model/race.dart';
import 'package:levaeu_mobile/model/place.dart';
import 'package:levaeu_mobile/controllers/race_controller.dart';
import 'package:levaeu_mobile/model/user_data.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  TextEditingController? _activeController;
  TimeOfDay? _selectedTime;
  DateTime? _selectedDate;

  String? _startName;
  String? _destinationName;

  List<Place> _places = [];
  bool _isLoading = false;
  late GooglePlacesService googlePlacesService;
  late DirectionsService directionsService;
  late String sessionToken;
  final Set<Marker> _markers = {};
  List<LatLng> _polylineCoordinates = [];
  Polyline? _polyline;

  @override
  void initState() {
    super.initState();
    googlePlacesService = GooglePlacesService(apiKey: dotenv.env['GOOGLE_MAPS_API_KEY']!);
    directionsService = DirectionsService(apiKey: dotenv.env['GOOGLE_MAPS_API_KEY']!);
    sessionToken = const Uuid().v4();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    _startController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  void _searchPlaces(String query) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final places = await googlePlacesService.fetchPlaces(query, sessionToken);
      setState(() {
        _places = places;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to load places')));
    }
  }

  void _fetchPlaceDetails(String placeId) async {
    try {
      final placeDetails = await googlePlacesService.fetchPlaceDetails(placeId, sessionToken);
      setState(() {
        _activeController?.text = '${placeDetails.name}, ${placeDetails.formattedAddress}';
        _addMarker(placeDetails.lat, placeDetails.lng, placeDetails.formattedAddress);

        if (_activeController == _startController) {
          _startName = placeDetails.name;
        } else if (_activeController == _destinationController) {
          _destinationName = placeDetails.name;
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to load place details')));
    }
  }

  void _addMarker(double lat, double lng, String address) {
    final markerId = MarkerId(lat.toString() + lng.toString());
    final marker = Marker(
      markerId: markerId,
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(
        title: address,
        snippet: 'Lat: $lat, Lng: $lng',
      ),
    );

    setState(() {
      _markers.add(marker);
      _mapController?.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
    });
  }

  void _confirmLocations() async {
    if (_markers.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Selecione os pontos de partida e destino')));
      return;
    }
    if(_selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Selecione o horário da corrida')));
      return;
    }

    String origin = '${_markers.elementAt(0).position.latitude},${_markers.elementAt(0).position.longitude}';
    String destination = '${_markers.elementAt(1).position.latitude},${_markers.elementAt(1).position.longitude}';

    try {
      final directions = await directionsService.fetchDirections(origin, destination, []);
      _drawPolyline(directions['routes'][0]['overview_polyline']['points']);

      // Adicionar corrida ao estado
      final user = Provider.of<UserData>(context, listen: false);
      final raceController = Provider.of<RaceController>(context, listen: false);

      DateTime combinedDate = DateTime(_selectedDate!.year, _selectedDate!.month, _selectedDate!.day, _selectedTime!.hour, _selectedTime!.minute);

      final newRace = Race(
        motoristaID: user.idUser,
        saida: _startController.text,
        destino: _destinationController.text,
        data: combinedDate,
        horario: _selectedTime,
        passageiros: [],
        motorista: user,
        motoristaName: user.name,
        saidaName: _startName,
        destinoName: _destinationName,
        saidaLat: _markers.elementAt(0).position.latitude,
        saidaLng: _markers.elementAt(0).position.longitude,
        destinoLat: _markers.elementAt(1).position.latitude,
        destinoLng: _markers.elementAt(1).position.longitude,
      );

      print('JSON a ser enviado ao backend: ${newRace.toJson()}');
      await raceController.createRace(newRace, user.token);
      
      await raceController.fetchDriverRaces(user.token, user.idUser);
      Navigator.pop(context); // Voltar para a tela anterior
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to load directions')));
    }
  }

  void _drawPolyline(String encodedPolyline) {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> result = polylinePoints.decodePolyline(encodedPolyline);

    if (result.isNotEmpty) {
      setState(() {
        _polylineCoordinates = result.map((point) => LatLng(point.latitude, point.longitude)).toList();
        _polyline = Polyline(
          polylineId: const PolylineId('route'),
          points: _polylineCoordinates,
          color: Colors.blue,
          width: 5,
        );
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: _selectedTime ?? TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDate = pickedDate;
          _selectedTime = pickedTime;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Criar Corrida',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(57, 96, 143, 1.0),
        iconTheme: const IconThemeData(color: Color.fromRGBO(255, 255, 255, 1.0)),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              _mapController = controller;
            },
            initialCameraPosition: const CameraPosition(
              target: LatLng(-5.7945, -35.211), // Exemplo: Centralizado em Natal, RN, Brasil
              zoom: 13.0,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: _markers,
            polylines: _polyline != null ? <Polyline>{_polyline!} : <Polyline>{},
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.4, // Altura inicial da folha
            minChildSize: 0.1, // Altura mínima da folha
            maxChildSize: 1.0, // Altura máxima da folha
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    TextField(
                      controller: _startController,
                      decoration: const InputDecoration(
                        labelText: 'De:',
                        suffixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        _activeController = _startController;
                        _searchPlaces(value);
                      },
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _destinationController,
                      decoration: const InputDecoration(
                        labelText: 'Para:',
                        suffixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        _activeController = _destinationController;
                        _searchPlaces(value);
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedTime == null
                                ? 'Selecione o horário'
                                : 'Horário: ${_selectedTime?.format(context)} ${_selectedDate?.day}/${_selectedDate?.month}/${_selectedDate?.year}',
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.access_time),
                          onPressed: () => _selectTime(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _confirmLocations,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text('Confirmar'),
                    ),
                    if (_isLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _places.length,
                        itemBuilder: (context, index) {
                          final place = _places[index];
                          return ListTile(
                            title: Text(place.description),
                            leading: const Icon(Icons.location_on),
                            onTap: () {
                              _fetchPlaceDetails(place.placeId);
                            },
                          );
                        },
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
