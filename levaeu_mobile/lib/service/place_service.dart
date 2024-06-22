import '../api/google_places_service.dart';
import '../model/place.dart';
import '../model/place_details.dart';

class PlaceService {
  final GooglePlacesService googlePlacesService;

  PlaceService({required this.googlePlacesService});

  void createSessionToken() {
    googlePlacesService.createSessionToken();
  }

  Future<List<Place>> searchPlaces(String query) {
    return googlePlacesService.fetchPlaces(query);
  }

  Future<PlaceDetails> getPlaceDetails(String placeId) {
    return googlePlacesService.fetchPlaceDetails(placeId);
  }
}
