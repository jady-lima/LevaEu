import 'package:flutter/material.dart';
import 'package:levaeu_mobile/ui/home_login.dart';
import 'package:levaeu_mobile/utils/drop_down_menu.dart';
import 'package:levaeu_mobile/utils/elevated_buttons.dart';
import 'package:levaeu_mobile/utils/text_fields_forms.dart';

class Registration extends StatefulWidget{
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfController = TextEditingController();
  final zipcodeController = TextEditingController();
  final genderController = TextEditingController();
  final _formKeyRegistration = GlobalKey<FormState>();

  String dropdownValue = genderList.first;

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
                child: const Text(
                  "Crie sua conta",
                  textAlign: TextAlign.justify,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: Color.fromRGBO(65, 65, 65, 1)
                  ),
                ),
              ),

              //Container: Titulo Secundário
              Container(
                padding: const EdgeInsetsDirectional.all(5),
                constraints: const BoxConstraints(maxWidth: 300),
                child: const Text(
                  'Preencha os campos abaixo para criação da sua conta gratuita.',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color.fromRGBO(160, 160, 160, 1)
                  ),
                ),
              ),

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
                      child: TextFieldsForms.buildTextFormField("CEP", TextInputType.number, zipcodeController, false, ValidationType.zipcode, TextFieldsForms.saveFormFieldValue)
                    ),

                    //Container/TextFormField: Endereço
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField("Endereço", TextInputType.text, addressController, false, ValidationType.address, TextFieldsForms.saveFormFieldValue)
                    ),

                    //Container/TextFormField: Cidade
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField("Cidade", TextInputType.text, cityController, false, ValidationType.name, TextFieldsForms.saveFormFieldValue)
                    ),

                    //Container/TextFormField: Estado
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField("Estado", TextInputType.text, stateController,false, ValidationType.name, TextFieldsForms.saveFormFieldValue)
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
  
                    //Container/TextFormField: Gênero
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: DropDownMenus.buildDropDownButton(dropdownValue,
                        (String? value) {
                          setState(() {
                            dropdownValue = value!;
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
                      child: ElevatedButtonsForms.buildElevatedButton(const Color.fromRGBO(57, 96, 143, 1.0), const Color.fromRGBO(255, 255, 255, 1), const Color.fromRGBO(57, 96, 143, 1.0), 320, 50, "Criar conta", context, Registration(), _formKeyRegistration)
                    ),

                    //Container/ElevatedButton: Cancelar
                    Container(
                      constraints: const BoxConstraints(maxWidth: 300, minWidth: 250),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: ElevatedButtonsForms.buildElevatedButton(Colors.white, const Color.fromRGBO(57, 96, 143, 1.0), const Color.fromRGBO(57, 96, 143, 1.0), 320, 50,"Cancelar", context, Homelogin(), null)
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