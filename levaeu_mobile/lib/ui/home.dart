import 'package:flutter/material.dart';
import 'package:levaeu_mobile/ui/home_login.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _HomeContent();
  }
}

class _HomeContent extends StatelessWidget {
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
                padding: const EdgeInsets.all(50.0),
                width: 250,
                height: 250,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset('img/logo.png'),
                ),
              ),
              
              Container(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: const Text(
                'Bem-vindo ao LevaEu!',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 28,
                    color: Color.fromRGBO(65, 65, 65, 1)
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsetsDirectional.all(15),
                constraints: const BoxConstraints(maxWidth: 300),
                child: const Text(
                  'Estamos aqui para tornar suas viagens mais fáceis, econômicas e amigáveis. Conecte-se com outros estudantes e compartilhe caronas de forma segura e conveniente.',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color.fromRGBO(160, 160, 160, 1)
                  ),
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
                      MaterialPageRoute(builder: (context) => Homelogin())
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