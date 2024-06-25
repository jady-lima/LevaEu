import 'dart:convert';
import 'package:levaeu_mobile/model/place.dart';
import 'package:http/http.dart' as http;

class GooglePlacesService {
  final String apiKey;

  GooglePlacesService({required this.apiKey});

  Future<List<Place>> fetchPlaces(String query, String sessionToken) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$apiKey&sessiontoken=$sessionToken';
    print('Fetching places with URL: $url');
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['predictions'];
      print('Response data: ${jsonDecode(response.body)}');
      return data.map((json) => Place.fromJson(json)).toList();
    } else {
      print('Failed to load places. Status code: ${response.statusCode}');
      throw Exception('Failed to load places');
    }
  }
}
