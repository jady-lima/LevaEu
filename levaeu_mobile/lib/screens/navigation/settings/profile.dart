import 'package:flutter/material.dart';
import 'package:levaeu_mobile/model/user_data.dart';
import 'package:levaeu_mobile/utils/list_tile_editing_text_fields.dart';
import 'package:levaeu_mobile/utils/text_fields_forms.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    return Scaffold(
      
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,

      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(57, 96, 143, 1.0),
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Minha conta",
          style: TextStyle(color: Colors.white),
        ),
      ),
      
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget> [

              Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.only(top: 25),
                constraints: const BoxConstraints(maxWidth: 100, maxHeight: 220, minHeight: 200),
                child: Image.asset('img/user.png'),
              ),

              Card(
                color: Colors.white,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 340, minWidth: 240),
                  child: Column(

                    children: <Widget>[

                      Container(
                        constraints: const BoxConstraints(maxHeight: 30, minHeight: 10),
                        margin: const EdgeInsets.only(top: 10),
                        child: const Text(
                          "Dados Pessoais",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Color.fromRGBO(90, 87, 87, 0.711)
                          ),
                        ),
                      ),

                      ListTileEditingTextField(
                        title: "Nome", 
                        user: userData.name, 
                        controller: TextEditingController(text: userData.name), 
                        function: userData.updateName,
                        inputType: TextInputType.text,
                        validationType: ValidationType.name,
                      ),

                      ListTileEditingTextField(
                        title: "Email", 
                        user: userData.email, 
                        controller: TextEditingController(text: userData.email), 
                        function: userData.updateEmail,
                        inputType: TextInputType.text,
                        validationType: ValidationType.email,
                      ),

                      ListTileEditingTextField(
                        title: "Matrícula", 
                        user: userData.email, 
                        controller: TextEditingController(text: userData.matricula), 
                        function: userData.updateMatricula,
                        inputType: TextInputType.text,
                        validationType: ValidationType.matricula,
                      ),

                      ListTileEditingTextField(
                        title: "Telefone", 
                        user: userData.email, 
                        controller: TextEditingController(text: userData.phone), 
                        function: userData.updatePhone,
                        inputType: TextInputType.number,
                        validationType: ValidationType.phone,
                      ),

                      ListTileEditingTextField(
                        title: "CEP", 
                        user: userData.cep, 
                        controller: TextEditingController(text: userData.cep), 
                        function: userData.updateCep,
                        inputType: TextInputType.number,
                        validationType: ValidationType.zipcode,
                      ),

                      ListTileEditingTextField(
                        title: "Rua", 
                        user: userData.street, 
                        controller: TextEditingController(text: userData.street), 
                        function: userData.updateStreet,
                        inputType: TextInputType.text,
                        validationType: ValidationType.address,
                      ),

                      ListTileEditingTextField(
                        title: "Cidade", 
                        user: userData.city, 
                        controller: TextEditingController(text: userData.city), 
                        function: userData.updateCity,
                        inputType: TextInputType.text,
                        validationType: ValidationType.address,
                      ),

                      ListTileEditingTextField(
                        title: "Estado", 
                        user: userData.state, 
                        controller: TextEditingController(text: userData.state), 
                        function: userData.updateState,
                        inputType: TextInputType.text,
                        validationType: ValidationType.address,
                      ),

                      ListTileEditingTextField(
                        title: "País", 
                        user: userData.country, 
                        controller: TextEditingController(text: userData.country), 
                        function: userData.updateCountry,
                        inputType: TextInputType.text,
                        validationType: ValidationType.address,
                      ),

                      ListTile(
                        title: const Text("Gênero: "),
                        subtitle: Text(userData.gender),
                      ),

                      if (userData.driverCar != null)
                        Container(
                          constraints: const BoxConstraints(maxHeight: 30, minHeight: 10),
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            "Dados da CNH",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Color.fromRGBO(90, 87, 87, 0.711)
                            ),
                          ),
                        ),

                        ListTileEditingTextField(
                          title: "Registro", 
                          user: userData.driverLicense!.registro, 
                          controller: TextEditingController(text: userData.driverLicense!.registro), 
                          function: userData.driverLicense!.updateRegistro,
                          inputType: TextInputType.text,
                          validationType: ValidationType.registro,
                        ),

                        ListTileEditingTextField(
                          title: "Data de Emissão", 
                          user: userData.driverLicense!.dataEmissao, 
                          controller: TextEditingController(text: userData.driverLicense!.dataEmissao), 
                          function: userData.driverLicense!.updateDataEmissao,
                          inputType: TextInputType.text,
                          validationType: ValidationType.data,
                        ),

                        ListTileEditingTextField(
                          title: "Data de Validade", 
                          user: userData.driverLicense!.dataValidade, 
                          controller: TextEditingController(text: userData.driverLicense!.dataValidade), 
                          function: userData.driverLicense!.updateDataValidade,
                          inputType: TextInputType.text,
                          validationType: ValidationType.data,
                        ),

                        ListTileEditingTextField(
                          title: "CPF", 
                          user: userData.driverLicense!.cpf, 
                          controller: TextEditingController(text: userData.driverLicense!.cpf), 
                          function: userData.driverLicense!.updateCPF,
                          inputType: TextInputType.text,
                          validationType: ValidationType.cpf,
                        ),

                        ListTileEditingTextField(
                          title: "Categoria", 
                          user: userData.driverLicense!.categoria, 
                          controller: TextEditingController(text: userData.driverLicense!.categoria), 
                          function: userData.driverLicense!.updateCategoria,
                          inputType: TextInputType.text,
                          validationType: ValidationType.name,
                        ),
                      
                        Container(
                          constraints: const BoxConstraints(maxHeight: 30, minHeight: 10),
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            "Dados do Veículo",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Color.fromRGBO(90, 87, 87, 0.711)
                            ),
                          ),
                        ),

                        ListTileEditingTextField(
                          title: "Marca", 
                          user: userData.driverCar!.marca, 
                          controller: TextEditingController(text: userData.driverCar!.marca), 
                          function: userData.driverCar!.updateMarca,
                          inputType: TextInputType.text,
                          validationType: ValidationType.name,
                        ),

                        ListTileEditingTextField(
                          title: "Modelo", 
                          user: userData.driverCar!.modelo, 
                          controller: TextEditingController(text: userData.driverCar!.modelo), 
                          function: userData.driverCar!.updateModelo,
                          inputType: TextInputType.text,
                          validationType: ValidationType.name,
                        ),

                        ListTileEditingTextField(
                          title: "Cor", 
                          user: userData.driverCar!.cor, 
                          controller: TextEditingController(text: userData.driverCar!.cor), 
                          function: userData.driverCar!.updateCor,
                          inputType: TextInputType.text,
                          validationType: ValidationType.name,
                        ),

                        ListTileEditingTextField(
                          title: "Placa", 
                          user: userData.driverCar!.placa, 
                          controller: TextEditingController(text: userData.driverCar!.placa), 
                          function: userData.driverCar!.updatePlaca,
                          inputType: TextInputType.text,
                          validationType: ValidationType.placa,
                        ),

                        ListTileEditingTextField(
                          title: "Ano", 
                          user: userData.driverCar!.year, 
                          controller: TextEditingController(text: userData.driverCar!.year), 
                          function: userData.driverCar!.updateYear,
                          inputType: TextInputType.text,
                          validationType: ValidationType.ano,
                        ),

                    ],
                  ),
                )
              )

            ],
          )
        )
      )
    );
  }
}
