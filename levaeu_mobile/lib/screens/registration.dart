import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:levaeu_mobile/screens/home.dart';
import 'package:levaeu_mobile/screens/start_login.dart';
import 'package:levaeu_mobile/screens/registrationCNH.dart';
import 'package:levaeu_mobile/utils/check_box_menus.dart';
import 'package:levaeu_mobile/utils/drop_down_menu.dart';
import 'package:levaeu_mobile/utils/elevated_buttons.dart';
import 'package:levaeu_mobile/utils/text_fields_forms.dart';
import 'package:levaeu_mobile/utils/titles_screens.dart';

class Registration extends StatefulWidget{
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
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

  @override
  void initState() {
  super.initState();
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
    } else if (digitsOnly.length <= 3){
      return '(${digitsOnly.substring(0, 2)}) ${digitsOnly.substring(2, 3)}';
    } else if (digitsOnly.length <= 7){
      return '(${digitsOnly.substring(0, 2)}) ${digitsOnly.substring(2, 3)} ${digitsOnly.substring(3)}';
    } else if (digitsOnly.length <= 11) {
      return '(${digitsOnly.substring(0, 2)}) ${digitsOnly.substring(2, 3)} ${digitsOnly.substring(3, 7)}-${digitsOnly.substring(7)}';
    } else {
      return '(${digitsOnly.substring(0, 2)}) ${digitsOnly.substring(2, 3)} ${digitsOnly.substring(3, 7)}-${digitsOnly.substring(7, 11)}';
    }
  }


  Future<void> getAddress(String zipcode) async{
    String requestAddress = "https://api.brasilaberto.com/v1/zipcode/$zipcode";
    final response = await http.get(Uri.parse(requestAddress));

    if(response.statusCode == 200){
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
    }  else {
      print("Erro ao buscar dados do CEP: ${response.statusCode}");
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
        children: <Widget> [
          Column(
            children: <Widget>[

              //Container: Icon
              Container(
                padding: const EdgeInsets.all(10),
                width: 120,
                height: 120,
                child: const Icon(Icons.account_circle_rounded, color: Color.fromRGBO(57, 96, 143, 1.0), size: 100,)
              ),

              //Container: Titulo Principal
              Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                constraints: const BoxConstraints(maxWidth: 350),
                child: TitlesScreens.buildMainTitle(
                  "Crie sua conta"
                )
              ),

              //Container: Titulo Secundário
              Container(
                padding: const EdgeInsetsDirectional.all(5),
                constraints: const BoxConstraints(maxWidth: 250),
                child: TitlesScreens.buildSecondaryTitle(
                  'Preencha os campos abaixo para criação da sua conta gratuita.'
                ),
              ),

              //Formulário de registro
              Form(
                key: _formKeyRegistration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget> [

                    //Container/TextFormField: Nome         
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField("Nome", TextInputType.text, nameController, false, ValidationType.name, TextFieldsForms.saveFormFieldValue)
                    ),

                    //Container/TextFormField: Email
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField("Email", TextInputType.emailAddress, emailController, false, ValidationType.email, TextFieldsForms.saveFormFieldValue)
                    ),

                    //Container/TextFormField: Telefone
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField("Telefone", TextInputType.phone, phoneController, false, ValidationType.phone, TextFieldsForms.saveFormFieldValue)
                    ),

                    //Container/TextFormField: CEP
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFormField(
                        controller: zipcodeController,
                        validator: TextFieldsForms.validateZipcode,
                        decoration: const InputDecoration(
                          labelText: "CEP",
                          labelStyle: TextStyle(color: Color.fromRGBO(184, 184, 184, 1)),
                          border: UnderlineInputBorder(),
                        ),
                        style: const TextStyle(color: Color.fromRGBO(184, 184, 184, 1), fontSize: 12.0),
                        keyboardType: TextInputType.number,
                        onSaved: TextFieldsForms.saveFormFieldValue,
                        onEditingComplete: () {
                          String zipcode = zipcodeController.text;
                          if (zipcode.length == 8) {
                            getAddress(zipcode);
                          }
                        },
                      ),
                    ),

                    // //Container/TextFormField: Endereço
                    // Container(
                    //   padding: const EdgeInsets.only(top: 15, bottom: 5),
                    //   constraints: const BoxConstraints(maxWidth: 320),
                    //   child: TextFieldsForms.buildTextFormField("Endereço", TextInputType.text, addressController, false, ValidationType.address, TextFieldsForms.saveFormFieldValue)
                    // ),

                    //Container/TextFormField: Rua
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField("Rua", TextInputType.text, streetController, false, ValidationType.address, TextFieldsForms.saveFormFieldValue)
                    ),

                    //Container/TextFormField: Rua
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField("Número", TextInputType.number, numberController, false, ValidationType.streetNumber, TextFieldsForms.saveFormFieldValue),
                    ),

                    //Container/TextFormField: Bairro
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField("Bairro", TextInputType.text, districtController, false, ValidationType.address, TextFieldsForms.saveFormFieldValue)
                    ),

                    //Container/TextFormField: Cidade
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField("Cidade", TextInputType.text, cityController, false, ValidationType.address, TextFieldsForms.saveFormFieldValue)
                    ),

                    //Container/TextFormField: Estado
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField("Estado", TextInputType.text, stateController,false, ValidationType.address, TextFieldsForms.saveFormFieldValue)
                    ),

                    //Container/TextFormField: País
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField("País", TextInputType.text, countryController, false, ValidationType.name, TextFieldsForms.saveFormFieldValue)
                    ),

                    //Container/TextFormField: Senha
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField("Senha", TextInputType.visiblePassword, passwordController, true,ValidationType.password, TextFieldsForms.saveFormFieldValue)
                    ),

                    //Container/TextFormField: Confirmação de Senha
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField("Confirme a senha", TextInputType.visiblePassword, passwordConfController, true, ValidationType.password, TextFieldsForms.saveFormFieldValue)
                    ),
  
                    //Container/DropDown: Gênero
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: DropDownMenus.buildDropDownButton(genderList.first,
                        (String? value) {
                          setState(() {
                            genderList.first = value!;
                          });
                        }, ListType.genderList,
                      ),
                    ),

                    //Container/CheckBox: Motorista
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: CheckBoxMenus.buildCheckBoxMenu(_isChecked,
                        (bool? value) {
                          setState(() {
                            _isChecked = value ?? false;
                          });
                        },
                      ),
                    ),

                    //Container/ElevatedButton: Criar conta
                    Container(
                      constraints: const BoxConstraints(maxWidth: 300),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      child: ElevatedButtonsForms.buildElevatedButton(
                        const Color.fromRGBO(57, 96, 143, 1.0), 
                        const Color.fromRGBO(255, 255, 255, 1), 
                        const Color.fromRGBO(57, 96, 143, 1.0), 
                        320, 50, "Criar conta", context,
                        _isChecked ? RegistrationCNH() : Home(), 
                        _formKeyRegistration)
                    ),

                    //Container/ElevatedButton: Cancelar
                    Container(
                      constraints: const BoxConstraints(maxWidth: 300, minWidth: 250),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: ElevatedButtonsForms.buildElevatedButton(Colors.white, const Color.fromRGBO(57, 96, 143, 1.0), const Color.fromRGBO(57, 96, 143, 1.0), 320, 50,"Cancelar", context, Startlogin(), null)
                    ),

                  ],
                ),
              )

            ],
          )

        ],
      ),
    );
  }

}