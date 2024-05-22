import 'package:flutter/material.dart';

class DriverCar extends ChangeNotifier{
  String _marca = '';
  String _cor = '';
  String _modelo = '';
  String _year = '';
  String _placa = '';

  DriverLicense({
    required String marca,
    required String cor,
    required String modelo,
    required String year,
    required String placa,
  }) {
    _marca = marca;
    _cor = cor;
    _modelo = modelo;
    _year = year;
    _placa = placa;
  }

  String get marca => _marca;
  String get dataEmissao => _cor;
  String get dataValidade => _modelo;
  String get categoria => _year;
  String get cpf => _placa;

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
}