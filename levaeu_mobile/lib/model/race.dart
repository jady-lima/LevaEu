import 'package:flutter/material.dart';
import 'package:levaeu_mobile/model/user_data.dart';

class Race extends ChangeNotifier{
  static const String columnId = "columnId";
  static const String columnSaida = "columnSaida";
  static const String columnDestino = "columnDestino";
  static const String columnData = "columnData";
  static const String columnHorario = "columnHorario";
  static const String columnPassageiros = "columnPassageiros";
  static const String columnMotorista = "columnMotorista";

  int _idRace = 0;
  String _saida = '';
  String _destino = '';
  DateTime _data = DateTime.now();
  TimeOfDay _horario = TimeOfDay.now();
  List<UserData> _passageiros = [];
  UserData _motorista = UserData();

  Race({
    int? idRace,
    String? saida,
    String? destino,
    DateTime? data,
    TimeOfDay? horario,
    List<UserData>? passageiros,
    UserData? motorista,
  }) {
    if (idRace != null) _idRace = idRace;
    if (saida != null) _saida = saida;
    if (destino != null) _destino = destino;
    if (data != null) _data = data;
    if (horario != null) _horario = horario;
    if (passageiros != null) _passageiros = passageiros;
    if (motorista != null) _motorista = motorista;
  }

  int get idRace => _idRace;
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

  Map<String, dynamic> toMap() {
    return {
      columnId: _idRace,
      columnSaida: _saida,
      columnDestino: _destino,
      columnData: _data,
      columnHorario: _horario,
      columnPassageiros: _passageiros,
      columnMotorista: _motorista, 
    };
  }

  factory Race.fromMap(Map<String, dynamic> map){
    return Race(
      idRace: map[columnId],
      saida: map[columnSaida],
      destino: map[columnDestino],
      data: map[columnData],
      horario: map[columnHorario],
      passageiros: map[columnPassageiros],
      motorista: map[columnMotorista]
    );
  }
  
}