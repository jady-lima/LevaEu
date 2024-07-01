import 'package:levaeu_mobile/model/location.dart';

class UserRequest {
  final String idRide;
  final String idUser;
  final bool isPickup; // 'PICKUP' ou 'DROPOFF'
  final Location location;

  UserRequest({
    required this.idRide,
    required this.idUser,
    required this.isPickup,
    required this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'idRide': idRide,
      'stopPoint': location.toJson(),
      'isPickup': isPickup,
    };
  }
}