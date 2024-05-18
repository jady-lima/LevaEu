import 'package:flutter/material.dart';
import 'package:levaeu_mobile/screens/navigation/settings/security/autentication.dart';
import 'package:levaeu_mobile/screens/navigation/settings/security/change_pass.dart';
import 'package:levaeu_mobile/utils/elevated_buttons.dart';

class Security extends StatefulWidget {
  const Security({Key? key}) : super(key: key);

  @override
  SecurityState createState() => SecurityState();
}

class SecurityState extends State<Security> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,

      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(57, 96, 143, 1.0),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            
          Container(
            constraints: const BoxConstraints(maxWidth: 380, minWidth: 200, maxHeight: 100, minHeight: 50),
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 10),
            child: ElevatedButtonsForms.buildElevatedButtonIcon(
              Icons.lock_outline_rounded, 
              "Autenticação de dois fatores", 
              context, 
              () => const Autentication(), 
              rootNavigator: true
            ),
          ),

          Container(
            constraints: const BoxConstraints(maxWidth: 380, minWidth: 200, maxHeight: 100, minHeight: 50),
            alignment: Alignment.center,
            child: ElevatedButtonsForms.buildElevatedButtonIcon(
              Icons.key, 
              "Alterar senha", 
              context, 
              () => const ChangePass(), 
              rootNavigator: true
            ),
          ),],),),
    );
  }
}
