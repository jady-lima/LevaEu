import 'package:flutter/material.dart';

class Login extends StatefulWidget{
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<Login>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        centerTitle: true,
      ),

      body: Text("Tela de login")
    );
  }

}