import 'package:flutter/material.dart';
import 'package:levaeu_mobile/api/api_client.dart';
import 'package:levaeu_mobile/model/race.dart';

class RaceController extends ChangeNotifier {

  Race? _activeRace;
  List<Race> _openRaces = [];

  Race? get activeRace => _activeRace;
  List<Race> get openRaces => _openRaces;

  void setActiveRace(Race race) {
    _activeRace = race;
    notifyListeners();
  }

  void setOpenRaces(List<Race> races) {
    _openRaces = races;
    notifyListeners();
  }

  Future<void> createRace(Race race, String token) async {
    try {
      final response = await ApiClient().createRace(race.toJson(), token);
      if (response.statusCode == 200) {
        _activeRace = race;
        //_openRaces.add(race);
        notifyListeners();
      }
    } catch (e) {
      print('Failed to create race: $e');
    }
  }

  Future<void> fetchOpenRaces(String token) async {
    try {
      final races = await ApiClient().fetchOpenRaces(token);
      _openRaces = races;
      notifyListeners();
    } catch (e) {
      print('Failed to fetch open races: $e');
    }
  }

  void clearActiveRace() {
    _activeRace = null;
    notifyListeners();
  }
}
