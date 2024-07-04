import 'package:flutter/material.dart';
import 'package:levaeu_mobile/model/driver_car.dart';
import 'package:levaeu_mobile/model/driver_license.dart';
import 'package:levaeu_mobile/model/driver_user.dart';

class UserData extends ChangeNotifier {
  dynamic _user;
  String _idUser = '';
  String _name = '';
  String _email = '';
  String _matricula = '';
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
  String _token = '';

  UserData({
    String? name,
    String? email,
    String? matricula,
    String? phone,
    String? cep,
    String? street,
    String? number,
    String? district,
    String? city,
    String? state,
    String? country,
    String? pass,
    String? gender,
  }) {
    if (name != null) _name = name;
    if (email != null) _email = email;
    if (matricula != null) _matricula = matricula;
    if (phone != null) _phone = phone;
    if (cep != null) _cep = cep;
    if (street != null) _street = street;
    if (number != null) _number = number;
    if (district != null) _district = district;
    if (city != null) _city = city;
    if (state != null) _state = state;
    if (country != null) _country = country;
    if (pass != null) _pass = pass;
    if (gender != null) _gender = gender;
  }

  dynamic get user => _user;
  String get idUser => _idUser;
  String get name => _name;
  String get phone => _phone;
  String get matricula => _matricula;
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
  String get token => _token;

  DriverLicense? get driverLicense {
    if (_user is DriverUser) {
      return (_user as DriverUser).driverLicense;
    }
    return null;
  }

  DriverCar? get driverCar {
    if (_user is DriverUser) {
      return (_user as DriverUser).driverCar;
    }
    return null;
  }

  void setUser(dynamic user) {
    _user = user;
    _name = user.name;
    _email = user.email;
    _matricula = user.matricula;
    _phone = user.phone;
    _cep = user.cep;
    _street = user.street;
    _number = user.number;
    _district = user.district;
    _city = user.city;
    _state = user.state;
    _country = user.country;
    _pass = user.pass;
    _gender = user.gender;

    if (user is DriverUser) {
      _user = DriverUser(
        name: _name,
        email: _email,
        matricula: _matricula,
        phone: _phone,
        cep: _cep,
        street: _street,
        number: _number,
        district: _district,
        city: _city,
        state: _state,
        country: _country,
        pass: _pass,
        gender: _gender,
        driverLicense: user.driverLicense,
        driverCar: user.driverCar,
      );
   }
    notifyListeners();
  }


  void convertToDriver(DriverLicense driverLicense, DriverCar driverCar) {
  _user = DriverUser(
    name: _name,
    email: _email,
    matricula: _matricula,
    phone: _phone,
    cep: _cep,
    street: _street,
    number: _number,
    district: _district,
    city: _city,
    state: _state,
    country: _country,
    pass: _pass,
    gender: _gender,
    driverLicense: driverLicense,
    driverCar: driverCar,
  );
  notifyListeners();
}


  void updateDriverLicense(DriverLicense driverLicense) {
    if (_user is DriverUser) {
      (_user as DriverUser).updateDriverLicense(driverLicense);
      (_user as DriverUser).driverLicense?.updateAll(
        newRegistro: driverLicense.registro, 
        newDataEmissao: driverLicense.dataEmissao, 
        newDataValidade: driverLicense.dataValidade, 
        newCategoria: driverLicense.categoria, 
        newCpf: driverLicense.cpf
      );
      notifyListeners();
    }
  }

  void updateDriverCar(DriverCar driverCar) {
    if (_user is DriverUser) {
      (_user as DriverUser).updateDriverCar(driverCar);
      (_user as DriverUser).driverCar?.updateAll(
        newMarca: driverCar.marca,
        newModelo: driverCar.modelo,
        newCor: driverCar.cor,
        newPlaca: driverCar.placa,
        newYear: driverCar.year,
      );
      notifyListeners();
    }
  }

  void updateIdUser(String newIdUser) {
    _idUser = newIdUser;
    notifyListeners();
  }

  void updateToken(String newToken) {
    _token = newToken;
    notifyListeners();
  }

  void updateName(String newName) {
    _name = newName;
    notifyListeners();
  }

  void updateEmail(String newEmail) {
    _email = newEmail;
    notifyListeners();
  }

  void updateMatricula(String newMatricula) {
    _matricula = newMatricula;
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
    required String newMatricula,
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
    UserData? userData,
  }) {
    _name = newName ;
    _email = newEmail ;
    _matricula = newMatricula;
    _phone = newPhone;
    _cep = newCep ;
    _street = newStreet;
    _number = newNumber;
    _district = newDistrict;
    _city = newCity ;
    _state = newState ;
    _country = newCountry;
    _pass = newPass ;
    _gender = newGender ;
    _user = userData ?? _user;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      "idUser": _idUser,
      "name": _name,
      "email": _email,
      "phone": _phone,
      "pass": _pass,
      "cep": _cep,
      "street": _street,
      "number": _number,
      "district": _district,
      "city": _city,
      "state": _state,
      "country": _country,
      "gender": _gender,
      "enrollment": _matricula,
      "typeUser": (_user is DriverUser) ? "DRIVER" : "DEFAULT",
      "token": _token,
    };
  }

  void updateFromJson(Map<String, dynamic> json) {
    _name = json['name'] ?? '';
    _email = json['email'] ?? '';
    _matricula = json['enrollment']?.toString() ?? '';
    _phone = json['phone'] ?? '';
    _cep = json['cep']?.toString() ?? '';
    _street = json['street'] ?? '';
    _number = json['number']?.toString() ?? '';
    _district = json['district'] ?? '';
    _city = json['city'] ?? '';
    _state = json['state'] ?? '';
    _country = json['country'] ?? '';
    _gender = json['gender'] ?? '';
    _token = json['token'] ?? '';
    _idUser = json['id']?.toString() ?? '';

    if (json['typeUser'] == 'DRIVER' && json.containsKey('driverLicense') && json.containsKey('car')) {
      _user = DriverUser(
        name: _name,
        email: _email,
        matricula: _matricula,
        phone: _phone,
        cep: _cep,
        street: _street,
        number: _number,
        district: _district,
        city: _city,
        state: _state,
        country: _country,
        pass: _pass,
        gender: _gender,
        driverLicense: DriverLicense.fromJson(json['driverLicense']),
        driverCar: DriverCar.fromJson(json['car']),
      );
    } 
    notifyListeners();
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'],
      email: json['email'],
      matricula: json['enrollment'],
      phone: json['phone'],
      cep: json['cep'],
      street: json['street'],
      number: json['number'],
      district: json['district'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      pass: '',
    );
  }

  void logout() {
      _user = null;
      _idUser = '';
      _name = '';
      _email = '';
      _matricula = '';
      _phone = '';
      _cep = '';
      _street = '';
      _number = '';
      _district = '';
      _city = '';
      _state = '';
      _country = '';
      _pass = '';
      _gender = '';
      _token = '';
      notifyListeners();
  }

}
