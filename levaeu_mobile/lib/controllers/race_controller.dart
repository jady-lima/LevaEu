import 'package:flutter/material.dart';
import 'package:levaeu_mobile/api/api_client.dart';
import 'package:levaeu_mobile/model/race.dart';

class RaceController extends ChangeNotifier {

  Race? _activeRace;
  List<Race> _openRaces = [];
  List<Race> _driverRaces = [];

  Race? get activeRace => _activeRace;
  List<Race> get openRaces => _openRaces;
  List<Race> get driverRaces => _driverRaces;

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

  void clearActiveRace() {
    _activeRace = null;
    notifyListeners();
  }
}
