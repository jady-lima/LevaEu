import 'package:flutter/material.dart';
import 'package:levaeu_mobile/ui/login.dart';

class Homelogin extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return _HomeloginContent();
  }
}

class _HomeloginContent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        centerTitle: true,
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
                child: buildElevatedButton(Colors.white, const Color.fromRGBO(90, 90, 90, 1.0), const Color.fromRGBO(196, 198, 208, 1.0), 300, 45,'img/logo_gmail.png', "Login com Gmail", context, Login())
              ),

              Container(
                padding: const EdgeInsets.all(10),
                child: buildElevatedButton(Colors.white, const Color.fromRGBO(90, 90, 90, 1.0), const Color.fromRGBO(196, 198, 208, 1.0), 300, 45, 'img/logo_sigaa.png', "Login com SIGAA", context, Login())
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
                child: buildElevatedButton(const Color.fromRGBO(57, 96, 143, 1.0), const Color.fromRGBO(255, 255, 255, 1), const Color.fromRGBO(57, 96, 143, 1.0), 300, 45, null, "Criar Conta", context, Login())
              ),

              Container(
                padding: const EdgeInsets.all(10),
                child: buildElevatedButton(Colors.white, const Color.fromRGBO(57, 96, 143, 1.0), const Color.fromRGBO(57, 96, 143, 1.0), 235, 45, null, "Entrar", context, Login())
                ),

            ]
          ),
        ],
      ),
    );
  }

  Widget buildElevatedButton(Color? colorButton, Color? colorText, Color colorBorder, double sizeWidth, double sizeHeight, String? imagePath, String text, BuildContext context, Widget f){
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