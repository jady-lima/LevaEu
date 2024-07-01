import 'package:flutter/material.dart';
import 'package:levaeu_mobile/api/api_client.dart';
import 'package:levaeu_mobile/controllers/auth_controller.dart';
import 'package:levaeu_mobile/model/driver_car.dart';
import 'package:levaeu_mobile/model/driver_license.dart';
import 'package:levaeu_mobile/model/user_data.dart';
import 'package:levaeu_mobile/screens/navigation/home_state.dart';
import 'package:levaeu_mobile/screens/login/start_login.dart';
import 'package:levaeu_mobile/utils/elevated_buttons.dart';
import 'package:levaeu_mobile/utils/text_fields_forms.dart';
import 'package:levaeu_mobile/utils/titles_screens.dart';
import 'package:provider/provider.dart';

class RegistrationCar extends StatefulWidget{
  const RegistrationCar({super.key});

  @override
  _RegistrationCarState createState() => _RegistrationCarState();
}

class _RegistrationCarState extends State<RegistrationCar> {

  final _formKeyRegistration = GlobalKey<FormState>();
  final marcaController = TextEditingController();
  final corController = TextEditingController();
  final anoController = TextEditingController();
  final modeloController = TextEditingController();
  final placaController = TextEditingController();

  bool _isLoading = false;

  late AuthController _authController;

  @override
  void initState() {
    super.initState();
    _authController = AuthController(apiClient: ApiClient());
  }

  Future<void> _submitUserCar(BuildContext context) async {
    final userData = Provider.of<UserData>(context, listen: false);
    final driverCar = Provider.of<DriverCar>(context, listen: false);
    final driverLicense = Provider.of<DriverLicense>(context, listen: false);

    driverCar.updateAll(
      newMarca: marcaController.text,
      newModelo: modeloController.text,
      newCor: corController.text,
      newPlaca: placaController.text,
      newYear: anoController.text,
    );

    userData.updateDriverCar(driverCar);

    final Map<String, dynamic> completeData = {
      "driver": 
        userData.toMap(),
      "driverLicense": 
        driverLicense.toMap(),
      "car": 
        driverCar.toMap()
    };

    setState(() {
      _isLoading = true;
    });

    try {
      print('Enviando dados completos para o backend: $completeData');
      final response = await _authController.registerComplete(completeData);
      print('User and vehicle registered successfully: ${response.data}');
      if (response.statusCode == 200) {

        userData.updateIdUser(response.data['id'].toString());
        userData.updateToken(response.data['token']);

        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeState()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to register vehicle')));
      }
    } catch (e) {
      print('Failed to register vehicle: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to register vehicle')));
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
              
              const SizedBox(
                width: 120,
                height: 120,
                child: Icon(Icons.drive_eta_rounded, color: Color.fromRGBO(57, 96, 143, 1.0), size: 100,)
              ),

              Container(
                margin: const EdgeInsets.only( bottom: 10),
                constraints: const BoxConstraints(maxWidth: 350),
                child: TitlesScreens.buildMainTitle("Informações do Veículo")
              ),

              Container(
                constraints: const BoxConstraints(maxWidth: 250),
                child: TitlesScreens.buildSecondaryTitle("Por favor, nos informe os dados do seu veículo para finalizar a criação da sua conta")
              ),

              Form(
                key: _formKeyRegistration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget> [

                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField("Marca do veículo", TextInputType.text, marcaController, false, ValidationType.name, TextFieldsForms.saveFormFieldValue),
                    ),

                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField("Modelo", TextInputType.text, modeloController, false, ValidationType.modelo, TextFieldsForms.saveFormFieldValue),
                    ),

                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField("Ano", TextInputType.number, anoController, false, ValidationType.ano, TextFieldsForms.saveFormFieldValue),
                    ),

                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField("Placa", TextInputType.text, placaController, false, ValidationType.placa, TextFieldsForms.saveFormFieldValue),
                    ),

                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFieldsForms.buildTextFormField("Cor", TextInputType.text, corController, false, ValidationType.name, TextFieldsForms.saveFormFieldValue),
                    ),

                    /*

                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: DropDownMenus.buildDropDownButton(
                        vehicleList.first,
                        (String? value) {
                          setState(() {
                            tipoController.text = value!;
                          });
                        }, ListType.vehicleList,
                      ),
                    ),
                    */

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
                            _submitUserCar(context);
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

                  ]
                )
              )
            ]
          )
        ]
      )
    );
  }

}