import "package:flutter/material.dart";

enum ValidationType {
  notEmpty,
  email,
  password,
  phone,
}

class TextFieldsForms {

  static Widget buildTextFormField(String label, TextInputType inputType, TextEditingController controller, bool pass, ValidationType validationType, void Function(String?)? onSaved ) {

    String? Function(String?)? validator;
    switch (validationType) {
      case ValidationType.notEmpty:
        validator = validateNotEmpty;
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
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value == null || value.isEmpty) {
      return 'Por favor, insira um email.';
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
    final phoneRegex = RegExp(r'^\([0-9]{2}\) [0-9]{5}-[0-9]{4}$');
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu número de telefone';
    }

    if (!phoneRegex.hasMatch(value)) {
      return 'Por favor, insira um telefone válido, no formato: (xx) 9xxxx-xxxx.';
    }

    return null;
  }
}