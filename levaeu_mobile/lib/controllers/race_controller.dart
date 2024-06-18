import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class RaceController extends ChangeNotifier{
  double lat = 0.0;
  double long = 0.0;
  String erro = '';

  RaceController(){
    getPosicao();
  }

  getPosicao() async {
    try{
      Position position = await _currentPosition();
      lat = position.latitude;
      long = position.longitude;
    } catch (e) {
      erro = e.toString();
    }

    notifyListeners();
  }

  Future<Position> _currentPosition() async {
    
    bool active = await Geolocator.isLocationServiceEnabled();
    if(!active) {
      return Future.error("Por favor, habilite a localização no smartphone.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied) {
        return Future.error("Por favor, autorize o acesso a localização da aplicação.");
      }
    }

    if(permission == LocationPermission.deniedForever) {
      return Future.error("Por favor, autorize o acesso a localização da aplicação.");
    }

    return await Geolocator.getCurrentPosition();
  }
}