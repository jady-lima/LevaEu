import 'package:flutter/material.dart';
import 'package:levaeu_mobile/model/user_data.dart';

class Race extends ChangeNotifier {
  static const String columnId = "columnId";
  static const String columnSaida = "columnSaida";
  static const String columnDestino = "columnDestino";
  static const String columnData = "columnData";
  static const String columnHorario = "columnHorario";
  static const String columnPassageiros = "columnPassageiros";
  static const String columnMotorista = "columnMotorista";
  static const String columnSaidaName = "columnSaidaName";
  static const String columnDestinoName = "columnDestinoName";

  int _idRace = 0;
  String _saida = '';
  String _destino = '';
  String _saidaName = '';
  String _destinoName = '';
  DateTime _data = DateTime.now();
  TimeOfDay _horario = TimeOfDay.now();
  List<UserData> _passageiros = [];
  UserData _motorista = UserData();

  Race({
    int? idRace,
    String? saida,
    String? destino,
    String? saidaName,
    String? destinoName,
    DateTime? data,
    TimeOfDay? horario,
    List<UserData>? passageiros,
    UserData? motorista,
  }) {
    if (idRace != null) _idRace = idRace;
    if (saida != null) _saida = saida;
    if (destino != null) _destino = destino;
    if (saidaName != null) _saidaName = saidaName;
    if (destinoName != null) _destinoName = destinoName;
    if (data != null) _data = data;
    if (horario != null) _horario = horario;
    if (passageiros != null) _passageiros = passageiros;
    if (motorista != null) _motorista = motorista;
  }

  int get idRace => _idRace;
  String get saida => _saida;
  String get destino => _destino;
  String get saidaName => _saidaName;
  String get destinoName => _destinoName;
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

  void updateSaidaName(String newSaidaName) {
    _saidaName = newSaidaName;
    notifyListeners();
  }

  void updateDestinoName(String newDestinoName) {
    _destinoName = newDestinoName;
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
    required String newSaidaName,
    required String newDestinoName,
    required DateTime newData,
    required TimeOfDay newHorario,
    required List<UserData> newPassageiros,
    required UserData newMotorista,
  }) {
    _saida = newSaida;
    _destino = newDestino;
    _saidaName = newSaidaName;
    _destinoName = newDestinoName;
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
      columnSaidaName: _saidaName,
      columnDestinoName: _destinoName,
      columnData: _data,
      columnHorario: _horario,
      columnPassageiros: _passageiros,
      columnMotorista: _motorista,
    };
  }

  factory Race.fromMap(Map<String, dynamic> map) {
    return Race(
      idRace: map[columnId],
      saida: map[columnSaida],
      destino: map[columnDestino],
      saidaName: map[columnSaidaName],
      destinoName: map[columnDestinoName],
      data: map[columnData],
      horario: map[columnHorario],
      passageiros: map[columnPassageiros],
      motorista: map[columnMotorista],
    );
  }
}
