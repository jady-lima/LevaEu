import 'package:flutter/material.dart';

class DriverLicense extends ChangeNotifier{
  String _registro = '';
  String _dataEmissao = '';
  String _dataValidade = '';
  String _categoria = '';
  String _cpf = '';

  DriverLicense({
    required String registro,
    required String dataEmissao,
    required String dataValidade,
    required String categoria,
    required String cpf,
  }) {
    _registro = registro;
    _dataEmissao = dataEmissao;
    _dataValidade = dataValidade;
    _categoria = categoria;
    _cpf = cpf;
  }

  String get registro => _registro;
  String get dataEmissao => _dataEmissao;
  String get dataValidade => _dataValidade;
  String get categoria => _categoria;
  String get cpf => _cpf;

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
    required String newregistro,
    required String newdataEmissao,
    required String newdataValidade,
    required String newcategoria,
    required String newcpf,
  }) {
    _registro = newregistro;
    _dataEmissao = newdataEmissao;
    _dataValidade = newdataValidade;
    _categoria = newcategoria;
    _cpf = newcpf;
    notifyListeners();
  }
}