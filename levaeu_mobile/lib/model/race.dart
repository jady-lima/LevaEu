import 'package:flutter/material.dart';
import 'package:levaeu_mobile/model/user_data.dart';
import 'package:intl/intl.dart';

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

  late String _idRace ;
  String _saida = '';
  String _destino = '';
  String _saidaName = '';
  String _destinoName = '';
  DateTime _dataHora = DateTime.now();
  TimeOfDay _horario = TimeOfDay.now();
  List<UserData> _passageiros = [];
  UserData _motorista = UserData();
  String _motoristaID = '';
  String _motoristaName = '';
  double _saidaLat = 0.0;
  double _saidaLng = 0.0;
  double _destinoLat = 0.0;
  double _destinoLng = 0.0;

  Race({
    String? idRace,
    String? saida,
    String? destino,
    String? saidaName,
    String? destinoName,
    DateTime? data,
    TimeOfDay? horario,
    List<UserData>? passageiros,
    UserData? motorista,
    String? motoristaID,
    String? motoristaName,
    double? saidaLat,
    double? saidaLng,
    double? destinoLat,
    double? destinoLng,
  }) {
    if (idRace != null) _idRace = idRace;
    if (saida != null) _saida = saida;
    if (destino != null) _destino = destino;
    if (saidaName != null) _saidaName = saidaName;
    if (destinoName != null) _destinoName = destinoName;
    if (data != null) _dataHora = data;
    if (horario != null) _horario = horario;
    if (passageiros != null) _passageiros = passageiros;
    if (motorista != null) _motorista = motorista;
    if (motoristaID != null) _motoristaID = motoristaID;
    if (motoristaName != null) _motoristaName = motoristaName;
    if (saidaLat != null) _saidaLat = saidaLat;
    if (saidaLng != null) _saidaLng = saidaLng;
    if (destinoLat != null) _destinoLat = destinoLat;
    if (destinoLng != null) _destinoLng = destinoLng;
  }

  String get idRace => _idRace;
  String get saida => _saida;
  String get destino => _destino;
  String get saidaName => _saidaName;
  String get destinoName => _destinoName;
  DateTime get data => _dataHora;
  TimeOfDay get horario => _horario;
  List<UserData> get passageiros => _passageiros;
  UserData get motorista => _motorista;
  String get motoristaID => _motoristaID;

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
    _dataHora = newData;
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
    _dataHora = newData;
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
      columnData: _dataHora,
      columnHorario: _horario,
      columnPassageiros: _passageiros,
      columnMotorista: _motorista,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'idDriver': _motoristaID,
      'ride':{
        'departureTime': DateFormat('yyyy-MM-dd HH:mm').format(_dataHora),
        'departureLocation': {
          'name': _saidaName,
          'latitude': _saidaLat,
          'longitude': _saidaLng,
        },
        'destinationLocation': {
          'name': _destinoName,
          'latitude': _destinoLat,
          'longitude': _destinoLng,
        },
      }
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

  factory Race.fromJson(Map<String, dynamic> json) {
    return Race(
        idRace: json[columnId],
        saida: json[columnSaida],
        destino: json[columnDestino],
        saidaName: json[columnSaidaName],
        destinoName: json[columnDestinoName],
        data: DateTime.parse(json[columnData]),
        horario: TimeOfDay.fromDateTime(DateTime.parse(json[columnData])),
        passageiros: [],
        motorista: UserData(),
      );
    }
}
