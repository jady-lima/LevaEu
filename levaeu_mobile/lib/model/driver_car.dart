import 'package:flutter/material.dart';

class DriverCar extends ChangeNotifier{
  String? _idCar;
  String _marca = '';
  String _cor = '';
  String _modelo = '';
  String _year = '';
  String _placa = '';

  DriverCar({
    String? idCar,
    String? marca,
    String? cor,
    String? modelo,
    String? year,
    String? placa,
  }) {
    if (idCar != null) _idCar = idCar;
    if (marca != null ) _marca = marca;
    if (cor != null ) _cor = cor;
    if (modelo != null ) _modelo = modelo;
    if (year != null ) _year = year;
    if (placa != null ) _placa = placa;
  }

  String? get idCar => _idCar;
  String get marca => _marca;
  String get cor => _cor;
  String get modelo => _modelo;
  String get year => _year;
  String get placa => _placa;

  void updateIdCar(String newIdCar) {
    _idCar = newIdCar;
    notifyListeners();
  }

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
    String? newIdCar,
    required String newMarca,
    required String newCor,
    required String newModelo,
    required String newYear,
    required String newPlaca,
  }) {
    _idCar = newIdCar ?? _idCar;
    _marca = newMarca;
    _cor = newCor;
    _modelo = newModelo;
    _year = newYear;
    _placa = newPlaca;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      "idCar": _idCar,
      "brand": _marca,
      "model": _modelo,
      "year": _year,
      "plate": _placa,
      "color": _cor,
    };
  }

  factory DriverCar.fromJson(Map<String, dynamic> json) {
    return DriverCar(
      idCar: json['id']?.toString(),
      marca: json['brand'],
      cor: json['color'],
      modelo: json['model'],
      year: json['year']?.toString(),
      placa: json['plate'],
    );
  }
}
