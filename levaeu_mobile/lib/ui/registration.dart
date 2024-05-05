import 'package:flutter/material.dart';

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

              Container(
                padding: const EdgeInsets.all(10),
                width: 120,
                height: 120,
                child: const Icon(Icons.account_circle_rounded, color: Color.fromRGBO(57, 96, 143, 1.0), size: 100,)
              ),

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
              
              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 5),
                constraints: const BoxConstraints(maxWidth: 320),
                child: buildTextField("Nome", TextInputType.text, nameController, false)
              ),

              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 5),
                constraints: const BoxConstraints(maxWidth: 320),
                child: buildTextField("Email", TextInputType.emailAddress, emailController, false)
              ),

              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 5),
                constraints: const BoxConstraints(maxWidth: 320),
                child: buildTextField("Telefone", TextInputType.phone, phoneController, false)
              ),

              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 5),
                constraints: const BoxConstraints(maxWidth: 320),
                child: buildTextField("CEP", TextInputType.number, zipcodeController, false)
              ),

              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 5),
                constraints: const BoxConstraints(maxWidth: 320),
                child: buildTextField("Endereço", TextInputType.text, addressController, false)
              ),

              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 5),
                constraints: const BoxConstraints(maxWidth: 320),
                child: buildTextField("Cidade", TextInputType.text, cityController, false)
              ),

              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 5),
                constraints: const BoxConstraints(maxWidth: 320),
                child: buildTextField("Estado", TextInputType.text, stateController,false)
              ),

              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 5),
                constraints: const BoxConstraints(maxWidth: 320),
                child: buildTextField("País", TextInputType.text, countryController, false)
              ),

              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 5),
                constraints: const BoxConstraints(maxWidth: 320),
                child: buildTextField("Senha", TextInputType.visiblePassword, passwordController, true)
              ),

              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 5),
                constraints: const BoxConstraints(maxWidth: 320),
                child: buildTextField("Confirme a senha", TextInputType.visiblePassword, passwordConfController, true)
              ),

              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 5),
                constraints: const BoxConstraints(maxWidth: 320),
                child: buildTextField("Gênero", TextInputType.emailAddress, nameController, false)
              ),
            
              Container(
                constraints: const BoxConstraints(maxWidth: 300),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: buildElevatedButton(const Color.fromRGBO(57, 96, 143, 1.0), const Color.fromRGBO(255, 255, 255, 1), const Color.fromRGBO(57, 96, 143, 1.0), 320, 50, "Criar conta", context, Registration())
              ),

              Container(
                constraints: const BoxConstraints(maxWidth: 300, minWidth: 250),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: buildElevatedButton(Colors.white, const Color.fromRGBO(57, 96, 143, 1.0), const Color.fromRGBO(57, 96, 143, 1.0), 320, 50,"Cancelar", context, Registration())
              ),
            ],
          )

        ],
      ),
    );
  }

  Widget buildTextField(String label, TextInputType inputType, TextEditingController controller, bool pass) {
    return TextField (
      controller: controller,
      obscureText: pass,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: label,
        labelStyle: const TextStyle(color: Color.fromRGBO(184, 184, 184, 1)),
      ),
      style: const TextStyle(color: Color.fromRGBO(57, 96, 143, 1.0), fontSize: 12.0),
      keyboardType: inputType
    );
  }

  Widget buildElevatedButton(Color? colorButton, Color? colorText, Color colorBorder, double sizeWidth, double sizeHeight, String text, BuildContext context, Widget f){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(sizeWidth, sizeHeight),
        backgroundColor: colorButton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side:  BorderSide(
          color: colorBorder
        )
      ),
      child:
        Text(
          " $text",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colorText,
            fontSize: 16,
          ),
        ),
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => f));        
      }, 
    );
  }
}