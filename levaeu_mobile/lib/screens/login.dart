import 'package:flutter/material.dart';
import 'package:levaeu_mobile/screens/registration.dart';
import 'package:levaeu_mobile/utils/elevated_buttons.dart';
import 'package:levaeu_mobile/utils/text_fields_forms.dart';

class Login extends StatefulWidget{
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<Login>{
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _formKeyLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color.fromRGBO(57, 96, 143, 1.0)),
      ),

      body: ListView(
        scrollDirection: Axis.vertical,
        children:  <Widget> [
          Column(
            children: <Widget> [

              //Container: Imagem
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                constraints: const BoxConstraints(maxWidth: 250),
                child: Image.asset('img/img_login.png'),
              ),

              //Container: Titulo Principal
              Container(
                margin: const EdgeInsets.only(top: 10),
                constraints: const BoxConstraints(maxWidth: 350),
                child: const Text(
                  "Acesse sua conta",
                  textAlign: TextAlign.justify,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 28,
                    color: Color.fromRGBO(65, 65, 65, 1)
                  ),
                ),
              ),

              //Container: Titulo Secundário
              Container(
                constraints: const BoxConstraints(maxWidth: 300),
                child: const Text(
                  'Entre com seu email ou telefone e aproveite suas viajens.',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color.fromRGBO(160, 160, 160, 1)
                  ),
                ),
              ),

              //Form: Formulário de login
              Form(
                key: _formKeyLogin,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    //Container/TextFormFiel: Email
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: TextFieldsForms.buildTextFormField("Email ou telefone", TextInputType.text, emailController, false, ValidationType.emailOrPhone, TextFieldsForms.saveFormFieldValue),
                    ),

                    //Container/TextFormFiel: Senha
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: TextFieldsForms.buildTextFormField("Senha", TextInputType.visiblePassword, passController, true, ValidationType.password, TextFieldsForms.saveFormFieldValue)
                    ),

                    //Container/ElevatedButton: Entrar
                    Container(
                      constraints: const BoxConstraints(maxWidth: 300),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      child: ElevatedButtonsForms.buildElevatedButton(
                        const Color.fromRGBO(57, 96, 143, 1.0), 
                        const Color.fromRGBO(255, 255, 255, 1), 
                        const Color.fromRGBO(57, 96, 143, 1.0), 320, 50, 
                        "Entrar", context, Login(), _formKeyLogin)
                    ),

                    //Container/ElevatedButton: Criar Conta
                    Container(
                      constraints: const BoxConstraints(maxWidth: 300, minWidth: 250),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: ElevatedButtonsForms.buildElevatedButton(
                        Colors.white, 
                        const Color.fromRGBO(57, 96, 143, 1.0),
                        const Color.fromRGBO(57, 96, 143, 1.0), 320, 50,
                        "Criar conta", context, Registration(), null)
                    ),
                    
                  ],
                ),
              )
    
            ],
          )
        ]
      )
    );
  }

}