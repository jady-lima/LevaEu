import 'package:flutter/material.dart';
import 'package:levaeu_mobile/screens/login/login.dart';
import 'package:levaeu_mobile/screens/register/registration.dart';

class Startlogin extends StatelessWidget{
  const Startlogin({super.key});

  @override
  Widget build(BuildContext context) {
    return _StartloginContent();
  }
}

class _StartloginContent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color.fromRGBO(57, 96, 143, 1.0)),
      ),

      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[

              Container(
                padding: const EdgeInsets.all(45.0),
                width: 250,
                height: 250,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset('img/logo.png'),
                ),
              ),
              
              Container(
                padding: const EdgeInsets.all(10),
                child: buildElevatedButton(Colors.white, const Color.fromRGBO(90, 90, 90, 1.0), const Color.fromRGBO(196, 198, 208, 1.0), 300, 'img/logo_gmail.png', "Login com Gmail", context, const Startlogin())
              ),

              Container(
                padding: const EdgeInsets.all(10),
                child: buildElevatedButton(Colors.white, const Color.fromRGBO(90, 90, 90, 1.0), const Color.fromRGBO(196, 198, 208, 1.0), 300, 'img/logo_sigaa.png', "Login com SIGAA", context, const Startlogin())
              ),

              const SizedBox(height: 15),

              Container(
                height: 1,
                width: 320,
                color: const Color.fromRGBO(196, 198, 208, 1.0),
              ),

              const SizedBox(height: 15),

              Container(
                padding: const EdgeInsets.all(10),
                child: buildElevatedButton(const Color.fromRGBO(57, 96, 143, 1.0), const Color.fromRGBO(255, 255, 255, 1), const Color.fromRGBO(57, 96, 143, 1.0), 300, null, "Criar Conta", context, const Registration())
              ),

              Container(
                padding: const EdgeInsets.all(10),
                child: buildElevatedButton(Colors.white, const Color.fromRGBO(57, 96, 143, 1.0), const Color.fromRGBO(57, 96, 143, 1.0), 235, null, "Entrar", context, const Login())
              ),

            ]
          ),
        ],
      ),
    );
  }

  Widget buildElevatedButton(Color? colorButton, Color? colorText, Color colorBorder, double sizeWidth,  String? imagePath, String text, BuildContext context, Widget f){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(sizeWidth, 50),
        backgroundColor: colorButton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side:  BorderSide(
          color: colorBorder
        )
      ),
      child: Row(
        children: <Widget>[
          if (imagePath != null)
            Image.asset(
              imagePath,
              width: 24,
              height: 24,
            ),
          Text(
            " $text",
            style: TextStyle(
              color: colorText,
              fontSize: 16
            ),
          ),
        ],
      ),
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => f));        
      }, 
    );
  }
}