import "package:flutter/material.dart";

enum ValidationType {
  notEmpty,
  name,
  email,
  password,
  phone,
  zipcode,
  address,
  streetNumber,
  emailOrPhone,
  registro, 
  cpf,
  data,
  placa,
  ano,
  modelo,
}

class TextFieldsForms {

  static Widget buildTextFormField(String label, TextInputType inputType, TextEditingController controller, bool pass, ValidationType validationType, void Function(String?)? onSaved ) {

    String? Function(String?)? validator;
    switch (validationType) {
      case ValidationType.notEmpty:
        validator = validateNotEmpty;
        break;
      case ValidationType.name:
        validator = validateName;
        break;
      case ValidationType.email:
        validator = validateEmail;
        break;
      case ValidationType.password:
        validator = validatePassword;
        break;
      case ValidationType.phone:
        validator = validatePhone;
        break;
      case ValidationType.zipcode:
        validator = validateZipcode;
        break;
      case ValidationType.address:
        validator = validateAddress;
        break;
      case ValidationType.streetNumber:
        validator = validateStreetNumber;
        break;
      case ValidationType.emailOrPhone:
        validator = validateEmailOrPhone;
        break;
      case ValidationType.registro:
        validator = validateCNH;
        break;
      case ValidationType.cpf:
        validator = validateCPF;
        break;
      case ValidationType.data:
        validator = validateDate;
        break;
      case ValidationType.placa:
        validator = validatePlaca;
        break;
      case ValidationType.ano:
        validator = validateAno;
        break;
      case ValidationType.modelo:
        validator = validateModelo;
        break;
    }

    return TextFormField (
      controller: controller,
      obscureText: pass,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color.fromRGBO(184, 184, 184, 1)),
        border: const UnderlineInputBorder(),
      ),
      style: const TextStyle(color: Color.fromRGBO(184, 184, 184, 1), fontSize: 12.0),
      keyboardType: inputType,
      onSaved: onSaved,
    );

  }

  static void saveFormFieldValue(String? value) {
    print('Valor do campo salvo: $value');
  }

  static String? validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, preencha o campo abaixo.';
    }
    return null;
  }

  static String? validatePlaca(String? value) {
    final RegExp placaRegex = RegExp(r'^([a-zA-Z]{3}[0-9]{4}|[a-zA-Z]{3}-[0-9]{4})$');
    if (value == null || value.isEmpty) {
      return 'Por favor, preencha o campo abaixo.';
    } 
    if (!placaRegex.hasMatch(value)) {
      return "Por favor, insira uma placa válida";
    }
    return null;
  }

  static String? validateAno(String? value) {
    final RegExp anoRegex = RegExp(r'^([0-9]{4})$');
    if (value == null || value.isEmpty) {
      return 'Por favor, preencha o campo abaixo.';
    } 
    if (!anoRegex.hasMatch(value)) {
      return "Por favor, insira um ano válido";
    }
    return null;
  }

  static String? validateModelo(String? value) {
    final modeloRegex = RegExp(r'^([a-zA-Z0-9 ]+)$');
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu nome.';
    } 
    if (!modeloRegex.hasMatch(value)) {
      return 'Por favor, insira um modelo válido.';
    }
    return null;
  }

  static String? validateCPF(String? value){
    final RegExp cpfRegex = RegExp(r'^(\d{3}\.\d{3}\.\d{3}-\d{2}|\d{11})$');

    if (value == null || value.isEmpty) {
      return 'Por favor, preencha o CPF.';
    }
    if (!cpfRegex.hasMatch(value)) {
      return 'Por favor, insira um CPF válido.';
    }
    return null;
  }

  static String? validateCNH(String? value) {
    final RegExp nchRegex = RegExp(r'^\d{11}$');
    if (value == null || value.isEmpty) {
      return 'Por favor, preencha o registro da CNH.';
    }

    if (!nchRegex.hasMatch(value)) {
      return 'Por favor, insira um registro válido.';
    }

    return null;
}

  static String? validateName(String? value) {
    final nameRegex = RegExp(r'^(?! )[a-z A-Z]{3,}$');
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu nome.';
    } 
    if (!nameRegex.hasMatch(value)) {
      return 'Por favor, insira um nome válido.';
    }
    return null;
  }

  static String? validateStreetNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o número do endereço.';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Por favor, insira um número válido.';
    } 
      return null;
  }
  
  static String? validateAddress(String? value){
    final addressRegex = RegExp(r'^[a-zA-ZÀ-ú 0-9]+(?: [a-zA-ZÀ-ú]+)*$');
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu endereço.';
    } 
    if (!addressRegex.hasMatch(value)) {
      return 'Por favor, insira um endereço válido.';
    }
    return null;
  }

  static String? validateDate(String? value){
    final RegExp dateRegex = RegExp(r'^(0?[1-9]|[12][0-9]|3[01])/(0?[1-9]|1[0-2])/\d{4}$');
    if (value == null || value.isEmpty) {
      return 'Por favor, insira a data.';
    } 
    if (!dateRegex.hasMatch(value)) {
      return 'Por favor, insira uma data válida.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value == null || value.isEmpty) {
      return 'Por favor, insira um email.';
    }

    if (!emailRegex.hasMatch(value)) {
      return 'Por favor, insira um email válido.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira sua senha.';
    }

    if (value.length < 8) {
      return 'A senha deve ter no minimo 8 caracteres';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    final phoneRegex = RegExp(r'^([1-9]{2}) 9? [0-9]{4}-[0-9]{4}|[0-9]{11}$');
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu número de telefone';
    }

    if (!phoneRegex.hasMatch(value)) {
      return 'Por favor, insira um telefone válido.';
    }

    return null;
  }

  static String? validateZipcode(String? value) {
    final zipCodeRegex = RegExp(r'^[0-9]{8}$');
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu número CEP';
    }

    if (!zipCodeRegex.hasMatch(value)) {
      return 'Por favor, insira um CEP válido, no formato: xxxxxxxx.';
    }

    return null;
  }

  static String? validateEmailOrPhone(String? value){
    final phoneRegex = RegExp(r'^([1-9]{2}) 9? [0-9]{4}-[0-9]{4}|[0-9]{11}$');
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (value == null || value.isEmpty) {
      return 'Por favor, preencha o campo';
    }

    if (!phoneRegex.hasMatch(value) && !emailRegex.hasMatch(value)) {
      return 'Por favor, insira seu email ou telefone';
    }

    return null;
  }
}