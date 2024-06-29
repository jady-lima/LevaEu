import 'package:flutter/material.dart';

class DriverCar extends ChangeNotifier{
  String _marca = '';
  String _cor = '';
  String _modelo = '';
  String _year = '';
  String _placa = '';

  DriverCar({
    String? marca,
    String? cor,
    String? modelo,
    String? year,
    String? placa,
  }) {
    if (marca != null ) _marca = marca;
    if (cor != null ) _cor = cor;
    if (modelo != null ) _modelo = modelo;
    if (year != null ) _year = year;
    if (placa != null ) _placa = placa;
  }

  String get marca => _marca;
  String get cor => _cor;
  String get modelo => _modelo;
  String get year => _year;
  String get placa => _placa;

  void updateMarca(String newMarca){
    _marca = newMarca;
    notifyListeners();
  }

  void updateCor(String newCor){
    _cor = newCor;
    notifyListeners();
  }

  void updateModelo(String newModelo){
    _modelo = newModelo;
    notifyListeners();
  }

  void updateYear(String newYear){
    _year = newYear;
    notifyListeners();
  }

  void updatePlaca(String newPlaca){
    _placa = newPlaca;
    notifyListeners();
  }

  void updateAll({
    required String newMarca,
    required String newCor,
    required String newModelo,
    required String newYear,
    required String newPlaca,
  }) {
    _marca = newMarca;
    _cor = newCor;
    _modelo = newModelo;
    _year = newYear;
    _placa = newPlaca;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      "brand": marca,
      "model": modelo,
      "year": year,
      "plate": placa,
      "color": cor,
    };
  }
}