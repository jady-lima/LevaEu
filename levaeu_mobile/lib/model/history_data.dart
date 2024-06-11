import 'package:flutter/material.dart';
import 'package:levaeu_mobile/model/user_data.dart';

class HistoryData extends ChangeNotifier {
  String _saida = '';
  String _destino = '';
  late DateTime _data;
  late TimeOfDay _horario;
  List<UserData> _passageiros = [];
  late UserData _motorista;

  HistoryData({
    String? saida,
    String? destino,
    DateTime? data,
    TimeOfDay? horario,
    List<UserData>? passageiros,
    UserData? motorista,
  }) {
    _saida = saida ?? '';
    _destino = destino ?? '';
    _data = data ?? DateTime.now();
    _horario = horario ?? TimeOfDay.now();
    _passageiros = passageiros ?? [];
    _motorista = motorista ?? UserData(
      name: '',
      email: '',
      phone: '',
      cep: '',
      street: '',
      number: '',
      district: '',
      city: '',
      state: '',
      country: '',
      gender: '',
    );
  }

  String get saida => _saida;
  String get destino => _destino;
  DateTime get data => _data;
  TimeOfDay get horario => _horario;
  List<UserData> get passageiros => _passageiros;
  UserData get motorista => _motorista;

  void updateSaida(String newSaida) {
    _saida = newSaida;
    notifyListeners();
  }

  void updateDestino(String newDestino) {
    _destino = newDestino;
    notifyListeners();
  }

  void updateData(DateTime newData) {
    _data = newData;
    notifyListeners();
  }

  void updateHorario(TimeOfDay newHorario) {
    _horario = newHorario;
    notifyListeners();
  }

  void updatePassageiros(List<UserData> newPassageiros) {
    _passageiros = newPassageiros;
    notifyListeners();
  }

  void updateMotorista(UserData newMotorista) {
    _motorista = newMotorista;
    notifyListeners();
  }

  void updateAll({
    required String newSaida,
    required String newDestino,
    required DateTime newData,
    required TimeOfDay newHorario,
    required List<UserData> newPassageiros,
    required UserData newMotorista,
  }) {
    _saida = newSaida;
    _destino = newDestino;
    _data = newData;
    _horario = newHorario;
    _passageiros = newPassageiros;
    _motorista = newMotorista;
    notifyListeners();
  }
}
