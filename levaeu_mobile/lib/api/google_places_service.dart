import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';
import '../model/place.dart';
import '../model/place_details.dart';
import 'api_client.dart';

class GooglePlacesService {
  final ApiClient apiClient;
  String? _sessionToken;
  final Uuid _uuid = Uuid();

  GooglePlacesService({required this.apiClient});

  void createSessionToken() {
    _sessionToken = _uuid.v4();
  }

  Future<List<Place>> fetchPlaces(String query) async {
    if (_sessionToken == null) {
      createSessionToken();
    }
    final response = await apiClient.get('/place/autocomplete/json', queryParameters: {
      'input': query,
      'sessiontoken': _sessionToken,
    });

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['predictions'];
      return data.map((json) => Place.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load places');
    }
  }

  Future<PlaceDetails> fetchPlaceDetails(String placeId) async {
    if (_sessionToken == null) {
      createSessionToken();
    }
    final response = await apiClient.get('/place/details/json', queryParameters: {
      'place_id': placeId,
      'sessiontoken': _sessionToken,
    });

    if (response.statusCode == 200) {
      final json = response.data['result'];
      return PlaceDetails.fromJson(json);
    } else {
      throw Exception('Failed to load place details');
    }
  }
}
