import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  String _name = '';
  String _email = '';
  String _phone = '';
  String _cep = '';
  String _street = '';
  String _number = '';
  String _district = '';
  String _city = '';
  String _state = '';
  String _country = '';
  String _pass = '';
  String _gender = '';

  String get name => _name;
  String get phone => _phone;
  String get cep => _cep;
  String get street => _street;
  String get district => _district;
  String get city => _city;
  String get state => _state;
  String get country => _country;
  String get pass => _pass;
  String get gender => _gender;
  String get email => _email;
  String get senha => _pass;
  String get number => _number;

  void updateName(String newName) {
    _name = newName;
    notifyListeners();
  }

  void updateEmail(String newEmail) {
    _email = newEmail;
    notifyListeners();
  }

  void updatePhone(String newPhone) {
    _phone = newPhone;
    notifyListeners();
  }

  void updateCep(String newCep) {
    _cep = newCep;
    notifyListeners();
  }

  void updateStreet(String newStreet) {
    _street = newStreet;
    notifyListeners();
  }

  void updateNumber(String newNumber) {
    _number = newNumber;
    notifyListeners();
  }

  void updateDistrict(String newDistrict) {
    _district = newDistrict;
    notifyListeners();
  }

  void updateCity(String newCity) {
    _city = newCity;
    notifyListeners();
  }

  void updateState(String newState) {
    _state = newState;
    notifyListeners();
  }

  void updateCountry(String newCountry) {
    _country = newCountry;
    notifyListeners();
  }

  void updatePass(String newPass) {
    _pass = newPass;
    notifyListeners();
  }

  void updateGender(String newGender) {
    _gender = newGender;
    notifyListeners();
  }

  void updateAll({
    required String newName,
    required String newEmail,
    required String newPhone,
    required String newCep,
    required String newStreet,
    required String newNumber,
    required String newDistrict,
    required String newCity,
    required String newState,
    required String newCountry,
    required String newPass,
    required String newGender,
  }) {
    _name = newName ?? _name;
    _email = newEmail ?? _email;
    _phone = newPhone ?? _phone;
    _cep = newCep ?? _cep;
    _street = newStreet ?? _street;
    _number = newNumber ?? _number;
    _district = newDistrict ?? _district;
    _city = newCity ?? _city;
    _state = newState ?? _state;
    _country = newCountry ?? _country;
    _pass = newPass ?? _pass;
    _gender = newGender ?? _gender;
    notifyListeners();
  }
}
