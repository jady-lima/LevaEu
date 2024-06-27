import 'dart:convert';
import 'package:http/http.dart' as http;

class DirectionsService {
  final String apiKey;

  DirectionsService({required this.apiKey});

  Future<Map<String, dynamic>> fetchDirections(String origin, String destination, List<String> waypoints) async {
    final waypointStr = waypoints.join('|');
    final url = 'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&waypoints=$waypointStr&key=$apiKey';
    print('Fetching directions with URL: $url');
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Directions data: $data');
      return data;
    } else {
      print('Failed to load directions. Status code: ${response.statusCode}');
      throw Exception('Failed to load directions');
    }
  }
}
