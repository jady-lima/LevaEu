import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteMapScreen extends StatelessWidget {
  final LatLng initialLocation;
  final LatLng finalLocation;
  final List<LatLng> waypoints;

  const RouteMapScreen({
    super.key,
    required this.initialLocation,
    required this.finalLocation,
    required this.waypoints,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rota da Corrida'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialLocation,
          zoom: 12.0,
        ),
        markers: {
          Marker(markerId: const MarkerId('initial'), position: initialLocation),
          Marker(markerId: const MarkerId('final'), position: finalLocation),
          ...waypoints.map((point) => Marker(markerId: MarkerId(point.toString()), position: point)).toSet(),
        },
        polylines: {
          Polyline(
            polylineId: const PolylineId('route'),
            points: [initialLocation, ...waypoints, finalLocation],
            color: Colors.blue,
            width: 5,
          ),
        },
      ),
    );
  }
}
