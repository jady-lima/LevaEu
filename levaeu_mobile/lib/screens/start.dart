import 'package:flutter/material.dart';
import 'package:levaeu_mobile/screens/start_login.dart';
import 'package:levaeu_mobile/utils/titles_screens.dart';

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _StartContent();
  }
}

class _StartContent extends StatelessWidget {
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
                padding: const EdgeInsets.all(30),
                width: 250,
                height: 250,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset('img/logo.png'),
                ),
              ),
              
              Container(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: TitlesScreens.buildMainTitle('Bem-vindo ao LevaEu!')
              ),

              Container(
                padding: const EdgeInsetsDirectional.all(15),
                constraints: const BoxConstraints(maxWidth: 300),
                child: TitlesScreens.buildStartSecondaryTitle(
                  'Estamos aqui para tornar suas viagens mais fáceis, econômicas e amigáveis. Conecte-se com outros estudantes e compartilhe caronas de forma segura e conveniente.'
                ),
              ),

              Container(
                padding: const EdgeInsets.all(50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(57, 96, 143, 1.0),
                    minimumSize: const Size(70, 70)
                  ),
                  child: const Icon(Icons.keyboard_arrow_right, color: Colors.white, weight: 50),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Startlogin())
                    );
                  }, 
                ),
              )

            ]
          ),
        ],
      ),
    );
  }

}