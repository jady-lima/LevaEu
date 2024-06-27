import 'package:flutter/material.dart';
import 'package:levaeu_mobile/model/race.dart';

class RaceController extends ChangeNotifier {
  Race? _activeRace;

  Race? get activeRace => _activeRace;

  void setActiveRace(Race race) {
    _activeRace = race;
    notifyListeners();
  }

  void clearActiveRace() {
    _activeRace = null;
    notifyListeners();
  }
}
