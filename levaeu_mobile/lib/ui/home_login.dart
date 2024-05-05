import 'package:flutter/material.dart';

class Homelogin extends StatefulWidget{
  @override
  _HomeloginState createState() => _HomeloginState();
}

class _HomeloginState extends State<Homelogin> {
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
                child: buildElevatedButton(Colors.white, const Color.fromRGBO(90, 90, 90, 1.0), const Color.fromRGBO(196, 198, 208, 1.0), 300, 45,'img/logo_gmail.png', "Login com Gmail")
              ),

              Container(
                padding: const EdgeInsets.all(10),
                child: buildElevatedButton(Colors.white, const Color.fromRGBO(90, 90, 90, 1.0), const Color.fromRGBO(196, 198, 208, 1.0), 300, 45, 'img/logo_sigaa.png', "Login com SIGAA")
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
                child: buildElevatedButton(const Color.fromRGBO(57, 96, 143, 1.0), const Color.fromRGBO(255, 255, 255, 1), const Color.fromRGBO(57, 96, 143, 1.0), 300, 45, null, "Criar Conta")
              ),

              Container(
                padding: const EdgeInsets.all(10),
                child: buildElevatedButton(Colors.white, const Color.fromRGBO(57, 96, 143, 1.0), const Color.fromRGBO(57, 96, 143, 1.0), 235, 45, null, "Entrar")
                ),

            ]
          ),
        ],
      ),
    );
  }

  Widget buildElevatedButton(Color? colorButton, Color? colorText, Color colorBorder, double sizeWidth, double sizeHeight, String? imagePath, String text){
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
              fontFamily: 'Roboto',
              fontSize: 16
            ),
          ),
        ],
      ),
      onPressed: (){
        
      }, 
    );
  }
}