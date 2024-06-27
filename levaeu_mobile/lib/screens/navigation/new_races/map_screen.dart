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
import 'package:levaeu_mobile/model/place_details.dart';
import 'package:levaeu_mobile/controllers/race_controller.dart';
import 'package:levaeu_mobile/model/user_data.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  TextEditingController? _activeController;
  TimeOfDay? _selectedTime;

  String? _startName;
  String? _destinationName;

  List<Place> _places = [];
  bool _isLoading = false;
  late GooglePlacesService googlePlacesService;
  late DirectionsService directionsService;
  late String sessionToken;
  Set<Marker> _markers = {};
  List<LatLng> _polylineCoordinates = [];
  Polyline? _polyline;

  @override
  void initState() {
    super.initState();
    googlePlacesService = GooglePlacesService(apiKey: dotenv.env['GOOGLE_MAPS_API_KEY']!);
    directionsService = DirectionsService(apiKey: dotenv.env['GOOGLE_MAPS_API_KEY']!);
    sessionToken = Uuid().v4();
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load places')));
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load place details')));
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Selecione os pontos de partida e destino')));
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
      final newRace = Race(
        saida: _startController.text,
        destino: _destinationController.text,
        data: DateTime.now(),
        horario: _selectedTime ?? TimeOfDay.now(),
        passageiros: [],
        motorista: user,
        saidaName: _startName,
        destinoName: _destinationName,
      );
      raceController.setActiveRace(newRace);
      Navigator.pop(context); // Voltar para a tela anterior
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load directions')));
    }
  }

  void _drawPolyline(String encodedPolyline) {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> result = polylinePoints.decodePolyline(encodedPolyline);

    if (result.isNotEmpty) {
      setState(() {
        _polylineCoordinates = result.map((point) => LatLng(point.latitude, point.longitude)).toList();
        _polyline = Polyline(
          polylineId: PolylineId('route'),
          points: _polylineCoordinates,
          color: Colors.blue,
          width: 5,
        );
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Corrida'),
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              _mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(-5.7945, -35.211), // Exemplo: Centralizado em Natal, RN, Brasil
              zoom: 13.0,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: _markers,
            polylines: _polyline != null ? Set<Polyline>.of([_polyline!]) : Set<Polyline>(),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.4, // Altura inicial da folha
            minChildSize: 0.1, // Altura mínima da folha
            maxChildSize: 1.0, // Altura máxima da folha
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
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
                      decoration: InputDecoration(
                        labelText: 'De:',
                        suffixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        _activeController = _startController;
                        _searchPlaces(value);
                      },
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _destinationController,
                      decoration: InputDecoration(
                        labelText: 'Para:',
                        suffixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        _activeController = _destinationController;
                        _searchPlaces(value);
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedTime == null
                                ? 'Selecione o horário'
                                : 'Horário: ${_selectedTime?.format(context)}',
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.access_time),
                          onPressed: () => _selectTime(context),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _confirmLocations,
                      child: Text('Confirmar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    if (_isLoading)
                      Center(
                        child: CircularProgressIndicator(),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _places.length,
                        itemBuilder: (context, index) {
                          final place = _places[index];
                          return ListTile(
                            title: Text(place.description),
                            leading: Icon(Icons.location_on),
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
