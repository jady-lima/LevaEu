import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:levaeu_mobile/model/driver_car.dart';
import 'package:levaeu_mobile/model/driver_license.dart';
import 'package:levaeu_mobile/model/driver_user.dart';
import 'package:levaeu_mobile/model/user_data.dart';
import 'package:levaeu_mobile/screens/navigation/home_state.dart';
import 'package:levaeu_mobile/screens/login/start_login.dart';
import 'package:levaeu_mobile/screens/register/registration_cnh.dart';
import 'package:levaeu_mobile/utils/check_box_menus.dart';
import 'package:levaeu_mobile/utils/drop_down_menu.dart';
import 'package:levaeu_mobile/utils/elevated_buttons.dart';
import 'package:levaeu_mobile/utils/text_fields_forms.dart';
import 'package:levaeu_mobile/utils/titles_screens.dart';
import 'package:provider/provider.dart';
import 'package:levaeu_mobile/controllers/auth_controller.dart';
import 'package:levaeu_mobile/api/api_client.dart';
import 'dart:async';
import 'dart:convert';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final ApiClient _apiClient = ApiClient();
  late AuthController _authController;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final matriculaController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final numberController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final districtController = TextEditingController();
  final streetController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfController = TextEditingController();
  final zipcodeController = TextEditingController();
  final genderController = TextEditingController();

  final _formKeyRegistration = GlobalKey<FormState>();
  String street = '';
  String district = '';
  String state = '';
  String city = '';
  String country = "Brasil";
  bool _isChecked = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _authController = AuthController(apiClient: _apiClient);
    phoneController.addListener(formatPhoneNumber);
  }

  @override
  void dispose() {
    phoneController.removeListener(formatPhoneNumber);
    phoneController.dispose();
    super.dispose();
  }

  void formatPhoneNumber() {
    String formatted = _formatPhone(phoneController.text);
    phoneController.value = phoneController.value.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _formatPhone(String value) {
    String digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.length <= 2) {
      return '($digitsOnly';
    } else if (digitsOnly.length <= 3) {
      return '(${digitsOnly.substring(0, 2)}) ${digitsOnly.substring(2, 3)}';
    } else if (digitsOnly.length <= 7) {
      return '(${digitsOnly.substring(0, 2)}) ${digitsOnly.substring(2, 3)} ${digitsOnly.substring(3)}';
    } else if (digitsOnly.length <= 11) {
      return '(${digitsOnly.substring(0, 2)}) ${digitsOnly.substring(2, 3)} ${digitsOnly.substring(3, 7)}-${digitsOnly.substring(7)}';
    } else {
      return '(${digitsOnly.substring(0, 2)}) ${digitsOnly.substring(2, 3)} ${digitsOnly.substring(3, 7)}-${digitsOnly.substring(7, 11)}';
    }
  }

  Future<void> getAddress(String zipcode) async {
    String requestAddress = "https://api.brasilaberto.com/v1/zipcode/$zipcode";
    final response = await http.get(Uri.parse(requestAddress));

    if (response.statusCode == 200) {
      Map<String, dynamic>? data = json.decode(response.body);
      if (data != null && data.containsKey("result")) {
        Map<String, dynamic> results = data["result"];
        setState(() {
          street = results["street"] ?? "";
          district = results["district"] ?? "";
          city = results["city"] ?? "";
          state = results["state"] ?? "";

          cityController.text = city;
          stateController.text = state;
          streetController.text = street;
          districtController.text = district;
          countryController.text = country;
        });
      } else {
        print("Dados inválidos retornados pela API: $street");
      }
    } else {
      print("Erro ao buscar dados do CEP: ${response.statusCode}");
    }
  }


  Future<void> _submitUserData(BuildContext context) async {
    final user = Provider.of<UserData>(context, listen: false);
    setState(() {
      _isLoading = true;
    });

    Map<String, dynamic> userData = {
      "name": nameController.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "pass": passwordController.text,
      "cep": zipcodeController.text,
      "street": streetController.text,
      "number": numberController.text,
      "district": districtController.text,
      "city": cityController.text,
      "state": stateController.text,
      "country": countryController.text,
      "gender": genderController.text,
      "enrollment": matriculaController.text,
      "typeUser": _isChecked ? "DRIVER" : "DEFAULT"
    };

    try {
      print('Enviando dados do usuário para o backend: $userData');
      final response = await _authController.registerUser(userData);
      print('User registered successfully: ${response.data}');

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (_isChecked) {
          final driverUser = DriverUser(
            name: responseData['name'],
            email: responseData['email'],
            matricula: responseData['enrollment'],
            phone: responseData['phone'],
            cep: responseData['cep'],
            street: responseData['street'],
            number: responseData['number'],
            district: responseData['district'],
            city: responseData['city'],
            state: responseData['state'],
            country: responseData['country'],
            pass: passwordController.text,
            gender: responseData['gender'],
            driverLicense: DriverLicense(),
            driverCar: DriverCar(),
          );

          user.setUser(driverUser);

          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationCNH()));
        } else {
          user.updateAll(
            newName: responseData['name'],
            newEmail: responseData['email'],
            newMatricula: responseData['enrollment'],
            newPhone: responseData['phone'],
            newCep: responseData['cep'],
            newStreet: responseData['street'],
            newNumber: responseData['number'],
            newDistrict: responseData['district'],
            newCity: responseData['city'],
            newState: responseData['state'],
            newCountry: responseData['country'],
            newPass:  passwordController.text,
            newGender: responseData['gender'],
          );

          user.updateIdUser(responseData['id'].toString());
          user.updateToken(responseData['token']);
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeState()));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to register user')));
      }
    } catch (e) {
      print('Failed to register user: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to register user')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(184, 184, 184, 0),
        iconTheme: const IconThemeData(color: Color.fromRGBO(57, 96, 143, 1.0)),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                width: 120,
                height: 120,
                child: const Icon(
                  Icons.account_circle_rounded,
                  color: Color.fromRGBO(57, 96, 143, 1.0),
                  size: 100,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                constraints: const BoxConstraints(maxWidth: 350),
                child: TitlesScreens.buildMainTitle("Crie sua conta"),
              ),
              Container(
                padding: const EdgeInsetsDirectional.all(5),
                constraints: const BoxConstraints(maxWidth: 250),
                child: TitlesScreens.buildSecondaryTitle(
                    'Preencha os campos abaixo para criação da sua conta gratuita.'),
              ),
              Form(
                key: _formKeyRegistration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField(
                        "Nome",
                        TextInputType.text,
                        nameController,
                        false,
                        ValidationType.name,
                        TextFieldsForms.saveFormFieldValue,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField(
                        "Email",
                        TextInputType.emailAddress,
                        emailController,
                        false,
                        ValidationType.email,
                        TextFieldsForms.saveFormFieldValue,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField(
                        "Matricula",
                        TextInputType.number,
                        matriculaController,
                        false,
                        ValidationType.matricula,
                        TextFieldsForms.saveFormFieldValue,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField(
                        "Telefone",
                        TextInputType.phone,
                        phoneController,
                        false,
                        ValidationType.notEmpty,
                        TextFieldsForms.saveFormFieldValue,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFormField(
                        controller: zipcodeController,
                        validator: TextFieldsForms.validateZipcode,
                        decoration: const InputDecoration(
                          labelText: "CEP",
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(184, 184, 184, 1),
                          ),
                          border: UnderlineInputBorder(),
                        ),
                        style: const TextStyle(
                          color: Color.fromRGBO(184, 184, 184, 1),
                          fontSize: 12.0,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.length == 8) {
                            getAddress(value);
                          }
                        },
                        onSaved: TextFieldsForms.saveFormFieldValue,
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField(
                        "Rua",
                        TextInputType.text,
                        streetController,
                        false,
                        ValidationType.address,
                        TextFieldsForms.saveFormFieldValue,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField(
                        "Número",
                        TextInputType.number,
                        numberController,
                        false,
                        ValidationType.streetNumber,
                        TextFieldsForms.saveFormFieldValue,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField(
                        "Bairro",
                        TextInputType.text,
                        districtController,
                        false,
                        ValidationType.address,
                        TextFieldsForms.saveFormFieldValue,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField(
                        "Cidade",
                        TextInputType.text,
                        cityController,
                        false,
                        ValidationType.address,
                        TextFieldsForms.saveFormFieldValue,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField(
                        "Estado",
                        TextInputType.text,
                        stateController,
                        false,
                        ValidationType.address,
                        TextFieldsForms.saveFormFieldValue,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField(
                        "País",
                        TextInputType.text,
                        countryController,
                        false,
                        ValidationType.name,
                        TextFieldsForms.saveFormFieldValue,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField(
                        "Senha",
                        TextInputType.visiblePassword,
                        passwordController,
                        true,
                        ValidationType.password,
                        TextFieldsForms.saveFormFieldValue,
                      ),
                    ),
                    /*
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField(
                        "Confirme a senha",
                        TextInputType.visiblePassword,
                        passwordConfController,
                        true,
                        ValidationType.password,
                        TextFieldsForms.saveFormFieldValue,
                      ),
                    ),
                    */
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: DropDownMenus.buildDropDownButton(
                        genderController.text,
                        (String? value) {
                          setState(() {
                            genderController.text = value!;
                          });
                        },
                        ListType.genderList,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: CheckBoxMenus.buildCheckBoxMenu(
                        _isChecked,
                        (bool? value) {
                          setState(() {
                            _isChecked = value ?? false;
                          });
                        },
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 300),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      child: ElevatedButtonsForms.buildElevatedButtonSubmitUserData(
                        const Color.fromRGBO(57, 96, 143, 1.0),
                        const Color.fromRGBO(255, 255, 255, 1),
                        const Color.fromRGBO(57, 96, 143, 1.0),
                        320,
                        50,
                        "Criar conta",
                        context,
                        _formKeyRegistration,
                        () {
                          if (_formKeyRegistration.currentState!.validate()) {
                            _submitUserData(context);
                          }
                        },
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 300, minWidth: 250),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: ElevatedButtonsForms.buildElevatedButton(
                        Colors.white,
                        const Color.fromRGBO(57, 96, 143, 1.0),
                        const Color.fromRGBO(57, 96, 143, 1.0),
                        320,
                        50,
                        "Cancelar",
                        context,
                        const Startlogin(),
                        null,
                      ),
                    ),
                  ],
                ),
              ),
              if (_isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
