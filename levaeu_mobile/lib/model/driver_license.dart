import 'package:flutter/material.dart';

class DriverLicense extends ChangeNotifier{
  String? _idDriverLicense;
  String _registro = '';
  String _dataEmissao = '';
  String _dataValidade = '';
  String _categoria = '';
  String _cpf = '';

  DriverLicense({
    String? idDriverLicense,
    String? registro,
    String? dataEmissao,
    String? dataValidade,
    String? categoria,
    String? cpf,
  }) {
    if (idDriverLicense != null ) _idDriverLicense = idDriverLicense;
    if (registro != null ) _registro = registro;
    if (dataEmissao != null ) _dataEmissao = dataEmissao;
    if (dataValidade != null ) _dataValidade = dataValidade;
    if (categoria != null ) _categoria = categoria;
    if (cpf != null ) _cpf = cpf;
  }

  String? get idDriverLicense => _idDriverLicense;
  String get registro => _registro;
  String get dataEmissao => _dataEmissao;
  String get dataValidade => _dataValidade;
  String get categoria => _categoria;
  String get cpf => _cpf;

  void updateIdDriverLicense(String newIdDriverLicense) {
    _idDriverLicense = newIdDriverLicense;
    notifyListeners();
  }

  void updateRegistro(String newRegistro){
    _registro = newRegistro;
    notifyListeners();
  }

  void updateDataEmissao(String newDataEmissao){
    _dataEmissao = newDataEmissao;
    notifyListeners();
  }

  void updateDataValidade(String newDataValidade){
    _dataValidade = newDataValidade;
    notifyListeners();
  }

  void updateCategoria(String newCategoria){
    _categoria = newCategoria;
    notifyListeners();
  }

  void updateCPF(String newCPF){
    _cpf = newCPF;
    notifyListeners();
  }

  void updateAll({
    String? newIdDriverLicense,
    required String newRegistro,
    required String newDataEmissao,
    required String newDataValidade,
    required String newCategoria,
    required String newCpf,
  }) {
    _idDriverLicense = newIdDriverLicense ?? _idDriverLicense;
    _registro = newRegistro;
    _dataEmissao = newDataEmissao;
    _dataValidade = newDataValidade;
    _categoria = newCategoria;
    _cpf = newCpf;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      "idDriverLicense": _idDriverLicense,
      "registrationNumber": _registro,
      "cpf": _cpf,
      "issuanceDate": _dataEmissao,
      "expirationDate": _dataValidade,
      "category": _categoria
    };
  }

  factory DriverLicense.fromJson(Map<String, dynamic> json) {
    return DriverLicense(
      idDriverLicense: json['idDriverLicense']?.toString(),
      registro: json['registrationNumber']?.toString(),
      cpf: json['cpf']?.toString(),
      dataEmissao: json['issuanceDate'],
      dataValidade: json['expirationDate'],
      categoria: json['category'],
    );
  }
}
