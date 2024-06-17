import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectDestinationPage extends StatefulWidget {
  @override
  _SelectDestinationPageState createState() => _SelectDestinationPageState();
}

class _SelectDestinationPageState extends State<SelectDestinationPage> {
  GoogleMapController? _mapController;
  TextEditingController _destinationController = TextEditingController();

  @override
  void dispose() {
    _mapController?.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Destination'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: (controller) {
                _mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(37.7749, -122.4194), // Localização inicial do mapa (São Francisco)
                zoom: 12,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _destinationController,
              decoration: InputDecoration(
                labelText: 'Destination',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Realizar busca ou qualquer outra ação com base no destino inserido
                    String destination = _destinationController.text;
                    // TODO: Implementar sua lógica aqui
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
