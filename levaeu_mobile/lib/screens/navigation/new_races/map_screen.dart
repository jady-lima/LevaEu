import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart'; 
import 'package:uuid/uuid.dart';
import 'package:levaeu_mobile/api/google_places_service.dart';
import 'package:levaeu_mobile/api/directions_service.dart';
import 'package:levaeu_mobile/model/place.dart';
import 'package:levaeu_mobile/model/place_details.dart';


class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  TextEditingController? _activeController;

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
    googlePlacesService = GooglePlacesService(apiKey: 'AIzaSyAunD4b6bopXL2T2uSMe_pfE7jHLGTPvJQ');
    directionsService = DirectionsService(apiKey: 'AIzaSyAunD4b6bopXL2T2uSMe_pfE7jHLGTPvJQ');
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

  void _fetchPlaceDetails(String placeId) async {
    try {
      final placeDetails = await googlePlacesService.fetchPlaceDetails(placeId, sessionToken);
      print('Selected place: ${placeDetails.formattedAddress}, Postal Code: ${placeDetails.postalCode}');
      setState(() {
        _activeController?.text  = '${placeDetails.formattedAddress}';
        _addMarker(placeDetails.lat, placeDetails.lng, placeDetails.formattedAddress);
      });
    } catch (e) {
      print("Error fetching place details: $e");
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
    } catch (e) {
      print("Error fetching directions: $e");
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
                              print('Selected place: ${place.description}, placeId: ${place.placeId}');
                              // Determine qual campo de texto está sendo editado
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
