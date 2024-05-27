import 'package:flutter/material.dart';
import 'package:levaeu_mobile/model/driver_license.dart';
import 'package:levaeu_mobile/model/user_data.dart';
import 'package:levaeu_mobile/screens/register/registration_car.dart';
import 'package:levaeu_mobile/screens/login/start_login.dart';
import 'package:levaeu_mobile/utils/drop_down_menu.dart';
import 'package:levaeu_mobile/utils/elevated_buttons.dart';
import 'package:levaeu_mobile/utils/text_fields_forms.dart';
import 'package:levaeu_mobile/utils/titles_screens.dart';
import 'package:provider/provider.dart';

class RegistrationCNH extends StatefulWidget{
  const RegistrationCNH({super.key});

  @override
  _RegistrationCNHState createState() => _RegistrationCNHState();
}

class _RegistrationCNHState extends State<RegistrationCNH> {
  final registroController = TextEditingController();
  final dataEmissaoController = TextEditingController();
  final dataValidadeController = TextEditingController();
  final categoriaController = TextEditingController();
  final cpfController = TextEditingController();

  final _formKeyRegistration = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dataEmissaoController.addListener(formatDate);
    dataValidadeController.addListener(formatDate);
  }

  @override
  void dispose() {
    dataEmissaoController.removeListener(formatDate);
    dataValidadeController.removeListener(formatDate);
    dataEmissaoController.dispose();
    dataValidadeController.dispose();
    super.dispose();
  }

  void formatDate() {
    String emissao = _formatDate(dataEmissaoController.text, isEmissao: true);
    dataEmissaoController.value = dataEmissaoController.value.copyWith(
      text: emissao,
      selection: TextSelection.collapsed(offset: emissao.length),
    );
    String validade = _formatDate(dataValidadeController.text, isEmissao: false);
    dataValidadeController.value = dataValidadeController.value.copyWith(
      text: validade,
      selection: TextSelection.collapsed(offset: validade.length),
    );
  }

  String _formatDate(String value, {required bool isEmissao}) {
    String digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), ''); // Mantém apenas os dígitos

    if (digitsOnly.length <= 2) {
      return digitsOnly;
    } else if (digitsOnly.length <= 4) {
      return '${digitsOnly.substring(0, 2)}/${digitsOnly.substring(2)}';
    } else if (digitsOnly.length <= 8) {
      String day = digitsOnly.substring(0, 2);
      String month = digitsOnly.substring(2, 4);
      String year = digitsOnly.length > 4 ? digitsOnly.substring(4) : '';

      if (isEmissao && year.length == 4) {
        int yearInt = int.parse(year);
        int currentYear = DateTime.now().year;
        if (yearInt > currentYear) {
          year = currentYear.toString();
        }
      }

      if (year.isNotEmpty) {
        return '$day/$month/$year';
      } else {
        return '$day/$month';
      }
    } else {
      return '${digitsOnly.substring(0, 2)}/${digitsOnly.substring(2, 4)}/${digitsOnly.substring(4, 8)}';
    }
  }



  void _submitUserCNH(BuildContext context){
    final userData = Provider.of<UserData>(context, listen: false);
    final driverLicense = Provider.of<DriverLicense>(context, listen: false);
    
    driverLicense.updateAll(
      newregistro: registroController.text, 
      newdataEmissao: dataEmissaoController.text, 
      newdataValidade: dataValidadeController.text, 
      newcategoria: categoriaController.text, 
      newcpf: cpfController.text,
    );

    userData.updateDriverLicense(driverLicense);
    print(userData.driverLicense?.registro);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegistrationCar(),
      ),
    );
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
              
              //Container: Icon driver_license
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  child: Image.asset('img/driver_license.png'),
                ),
              ),

              Container(
                margin: const EdgeInsets.only( bottom: 10),
                constraints: const BoxConstraints(maxWidth: 350),
                child: TitlesScreens.buildMainTitle("Carteira Nacional de Habilitação")
              ),

              Container(
                constraints: const BoxConstraints(maxWidth: 250),
                child: TitlesScreens.buildSecondaryTitle("Por favor, nos informe os dados da sua CNH para continuar com a criação da sua conta")
              ),

              Form(
                key: _formKeyRegistration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget> [

                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField("Número de registro", TextInputType.number, registroController, false, ValidationType.registro, TextFieldsForms.saveFormFieldValue),
                    ),

                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField("Número de CPF", TextInputType.number, cpfController, false, ValidationType.cpf, TextFieldsForms.saveFormFieldValue),
                    ),

                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField("Data de Emissão", TextInputType.datetime, dataEmissaoController, false, ValidationType.data, TextFieldsForms.saveFormFieldValue),
                    ),

                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField("Data de validade", TextInputType.datetime, dataValidadeController, false, ValidationType.data, TextFieldsForms.saveFormFieldValue),
                    ),

                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: DropDownMenus.buildDropDownButton(
                        categoryList.first,
                        (String? value) {
                          setState(() {
                            categoryList.first = value!;
                          });
                        }, 
                        ListType.categoryList,
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
                        "Continuar", 
                        context,
                        _formKeyRegistration,
                        () {
                          if (_formKeyRegistration.currentState!.validate()) {
                            _submitUserCNH(context);
                          }
                        },
                      ),
                    ),

                    //Container/ElevatedButton: Cancelar
                    Container(
                      constraints: const BoxConstraints(maxWidth: 300, minWidth: 250),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: ElevatedButtonsForms.buildElevatedButton(Colors.white, const Color.fromRGBO(57, 96, 143, 1.0), const Color.fromRGBO(57, 96, 143, 1.0), 320, 50,"Cancelar", context, const Startlogin(), null)
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

