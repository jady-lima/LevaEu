class PlaceDetails {
  final String formattedAddress;
  final double lat;
  final double lng;

  PlaceDetails({required this.formattedAddress, required this.lat, required this.lng});

  factory PlaceDetails.fromJson(Map<String, dynamic> json) {
    return PlaceDetails(
      formattedAddress: json['formatted_address'],
      lat: json['geometry']['location']['lat'],
      lng: json['geometry']['location']['lng'],
    );
  }
}
