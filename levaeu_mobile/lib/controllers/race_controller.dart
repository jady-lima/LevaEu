import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:levaeu_mobile/api/api_client.dart';
import 'package:levaeu_mobile/model/race.dart';
import 'package:levaeu_mobile/model/user_data.dart';

class RaceController extends ChangeNotifier {

  Race? _activeRace;
  List<Race> _openRaces = [];
  List<Race> _driverRaces = [];
  List<Map<String, dynamic>> _acceptedPassengers = [];
  List<Map<String, dynamic>> _pendingPassengers = [];

  Race? get activeRace => _activeRace;
  List<Race> get openRaces => _openRaces;
  List<Race> get driverRaces => _driverRaces;
  List<Map<String,dynamic>> get acceptedPassengers => _acceptedPassengers;
  List<Map<String,dynamic>> get pendingPassengers => _pendingPassengers;

  void setActiveRace(Race race) {
    _activeRace = race;
    notifyListeners();
  }

  void setOpenRaces(List<Race> races) {
    _openRaces = races;
    notifyListeners();
  }

  void setDriverRaces(List<Race> races) {
    _driverRaces = races;
    notifyListeners();
  }

  void setAcceptedPassengers(List<Map<String, dynamic>> passengers) {
    _acceptedPassengers = passengers;
    notifyListeners();
  }

  void setPendingPassengers(List<Map<String, dynamic>> passengers) {
    _pendingPassengers = passengers;
    notifyListeners();
  }

  void addAcceptedPassenger(Map<String, dynamic> passenger) {
    _acceptedPassengers.add(passenger);
    notifyListeners();
  }


  void removeAcceptedPassenger(Map<String, dynamic> passenger) {
    _acceptedPassengers.removeWhere((p) => p['user']['id'] == passenger['user']['id']);
    notifyListeners();
  }

  Future<void> createRace(Race race, String token) async {
    try {
      final response = await ApiClient().createRace(race.toJson(), token);
      if (response.statusCode == 200) {
        print('response.data: ${response.data}');
        _activeRace = race;
        //_openRaces.add(race);
        notifyListeners();
      }
    } catch (e) {
      print('Failed to create race: $e');
    }
  }

  Future<void> fetchOpenRaces(String token, String id) async {
    try {
      final response = await ApiClient().fetchOpenRaces(token, id);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        final List<Race> fetchedRaces = data.map((json) => Race.fromJson(json)).toList();
        setOpenRaces(fetchedRaces);
      }
    } catch (e) {
      print('Failed to fetch open races: $e');
    }
  }

  Future<void> submitUserRequest(Map<String, dynamic> data, String token) async {
    try {
      final response = await ApiClient().submitUserRequest(data, token);
      if (response.statusCode == 200) {
        notifyListeners();
      }
    } catch (e) {
      print('Failed to submit user request: $e');
      throw e;
    }
  }

  Future<void> fetchDriverRaces(String token, String driverId) async {
    try {
      final response = await ApiClient().fetchDriverRaces(token, driverId);
      if (response.statusCode == 200) {
        List<Race> races = (response.data as List).map((e) => Race.fromJson(e)).toList();
        setDriverRaces(races);
      }
    } catch (e) {
      print('Failed to fetch driver races: $e');
    }
  }

  Future<void> fetchPassengerRequests(String token, int rideId) async {
    try {
      final response = await ApiClient().getPassengerRequests(token, rideId);
      final List<Map<String, dynamic>> passengerRequests = List<Map<String, dynamic>>.from(response.data);

      _acceptedPassengers = passengerRequests.where((request) => request['userRide']['confirmed'] == true).toList();
      _pendingPassengers = passengerRequests.where((request) => request['userRide']['confirmed'] == false).toList();
      
      notifyListeners();
    } catch (e) {
      print('Erro ao buscar passageiros: $e');
    }
  }

  // Future<void> confirmPassengerRequest(String token, int userId, int rideId) async {
  //   try {
  //     print('Enviando confirmação de passageiro: token=$token, userId=$userId, rideId=$rideId');
  //     await ApiClient().confirmPassengerRequest(token, userId, rideId);
  //   } catch (e) {
  //     print('Erro ao confirmar passageiro: $e');
  //     throw Exception('Erro ao confirmar passageiro');
  //   }
  // }

  Future<void> removePassengerRequest(String token, int userId, int rideId) async {
    try {
      print('Enviando remoção de passageiro: token=$token, userId=$userId, rideId=$rideId');
      await ApiClient().removePassengerRequest(token, userId, rideId);
    } catch (e) {
      print('Erro ao remover passageiro: $e');
      throw Exception('Erro ao remover passageiro');
    }
  }

  Future<void> confirmPassengers(String token, int rideId, List<int> passengerIds) async {
    try {
      final response = await ApiClient().confirmPassengerRequest(token, rideId, passengerIds);
      if (response.statusCode == 200) {
        print('Passageiros confirmados com sucesso');
      } else {
        throw Exception('Erro ao confirmar passageiros');
      }
    } catch (e) {
      print('Erro ao confirmar passageiros: ${e.toString()}');
      throw Exception('Erro ao confirmar passageiros');
    }
  }

  void finishRace(String idRace) {
    _driverRaces.removeWhere((race) => race.idRace == idRace);
    _openRaces.removeWhere((race) => race.idRace == idRace);
    notifyListeners();
  }

  void clearActiveRace() {
    _activeRace = null;
    notifyListeners();
  }

  void clearDriverRaces() {
    _driverRaces = [];
  }

  List<Race> getNextThreeRaces() {
    // Ordenar as corridas pelo horário de partida
    _openRaces.sort((a, b) => a.data.compareTo(b.data));
    // Retornar as três primeiras corridas
    return _openRaces.take(3).toList();
  }
}
