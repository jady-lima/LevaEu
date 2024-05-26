import 'package:flutter/material.dart';
import 'package:levaeu_mobile/model/user_data.dart';
import 'package:levaeu_mobile/screens/register/registration.dart';
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
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                constraints: const BoxConstraints(maxWidth: 100),
                child: Image.asset('img/user.png'),
              ),

              Card(
                color: Colors.white,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 350, minWidth: 240),
                  child: Column(

                    children: <Widget>[

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

                      ListTile(
                        title: const Text("CEP: "),
                        subtitle: Text(userData.cep),
                      ),

                      ListTile(
                        title: const Text("Rua: "),
                        subtitle: Text(userData.street),
                      ),

                      ListTile(
                        title: const Text("Numero: "),
                        subtitle: Text(userData.number),
                      ),

                      ListTile(
                        title: const Text("Bairro: "),
                        subtitle: Text(userData.district),
                      ),

                      ListTile(
                        title: const Text("Estado: "),
                        subtitle: Text(userData.state),
                      ),

                      ListTile(
                        title: const Text("País: "),
                        subtitle: Text(userData.country),
                      ),

                      ListTile(
                        title: const Text("Gênero: "),
                        subtitle: Text(userData.gender),
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
