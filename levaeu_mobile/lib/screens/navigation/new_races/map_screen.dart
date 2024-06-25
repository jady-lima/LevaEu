import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:levaeu_mobile/api/google_places_service.dart';
import 'package:levaeu_mobile/model/place.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  List<Place> _places = [];
  bool _isLoading = false;
  late GooglePlacesService googlePlacesService;
  late String sessionToken;

  @override
  void initState() {
    super.initState();
    googlePlacesService = GooglePlacesService(apiKey: 'API VAI AQUI');
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
      print("Searching for places with query: $query");
      final places = await googlePlacesService.fetchPlaces(query, sessionToken);
      print("Received places: $places");
      setState(() {
        _places = places;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching places: $e");
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load places')));
    }
  }

  void _confirmLocations() {
    print("Start: ${_startController.text}");
    print("Destination: ${_destinationController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Placeholder'),
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
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3, // Altura inicial da folha
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
                        _searchPlaces(value);
                      },
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
                            onTap: () async {
                              // Fetch place details and do something with them
                              print('Selected place: ${place.description}');
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
