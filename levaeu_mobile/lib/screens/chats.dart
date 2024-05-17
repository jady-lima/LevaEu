import 'package:flutter/material.dart';

class Chats extends StatefulWidget{
  const Chats({super.key});

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          Container(
            height: 200,
            color: Colors.red,
            child: Center(child: Text('Tela de discussões')),
          ),
          
        ],
      ),
    );
  }
}