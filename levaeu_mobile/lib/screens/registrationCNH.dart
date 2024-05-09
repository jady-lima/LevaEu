import 'package:flutter/material.dart';
import 'package:levaeu_mobile/utils/drop_down_menu.dart';
import 'package:levaeu_mobile/utils/text_fields_forms.dart';
import 'package:levaeu_mobile/utils/titles_screens.dart';

class RegistrationCNH extends StatefulWidget{
  @override
  _RegistrationCNHState createState() => _RegistrationCNHState();
}

class _RegistrationCNHState extends State<RegistrationCNH> {
  final registroController = TextEditingController();
  final dataEmissaoController = TextEditingController();
  final dataValidadeController = TextEditingController();
  final categoriaController = TextEditingController();
  String dropdownValue = categoriaList.first;

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
              Container(
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

              Container(
                constraints: const BoxConstraints(maxWidth: 350),
                child: TextFieldsForms.buildTextFormField("Número de registro", TextInputType.number, registroController, false, ValidationType.notEmpty, TextFieldsForms.saveFormFieldValue),
              ),

              Container(
                constraints: const BoxConstraints(maxWidth: 350),
                child: TextFieldsForms.buildTextFormField("Data de Emissão", TextInputType.datetime, dataEmissaoController, false, ValidationType.notEmpty, TextFieldsForms.saveFormFieldValue),
              ),

              Container(
                constraints: const BoxConstraints(maxWidth: 350),
                child: TextFieldsForms.buildTextFormField("Data de validade", TextInputType.datetime, dataValidadeController, false, ValidationType.notEmpty, TextFieldsForms.saveFormFieldValue),
              ),

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


            ],
          )
        ],
      ),
    );
  }
}