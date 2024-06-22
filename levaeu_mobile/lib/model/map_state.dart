import 'package:flutter/material.dart';

class MapState with ChangeNotifier {
  String _startLocation = '';
  String _destinationLocation = '';

  String get startLocation => _startLocation;
  String get destinationLocation => _destinationLocation;

  void setLocations(String start, String destination) {
    _startLocation = start;
    _destinationLocation = destination;
    notifyListeners();
  }
}
