class PlaceDetails {
  final String name;
  final String formattedAddress;
  final String postalCode;
  final double lat;
  final double lng;

  PlaceDetails({required this.name ,required this.formattedAddress, required this.postalCode, required this.lat, required this.lng});

  factory PlaceDetails.fromJson(Map<String, dynamic> json) {
    String postalCode = '';
    double lat = json['geometry']['location']['lat'];
    double lng = json['geometry']['location']['lng'];
    json['address_components'].forEach((component) {
      if ((component['types'] as List).contains('postal_code')) {
        postalCode = component['long_name'];
      }
    });
    return PlaceDetails(
      name: json['name'],
      formattedAddress: json['formatted_address'],
      postalCode: postalCode,
      lat: lat,
      lng: lng,
    );
  }
}