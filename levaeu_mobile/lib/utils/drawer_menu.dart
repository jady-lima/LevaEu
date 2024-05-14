import "package:flutter/material.dart";

class DrawerMenu{
  static Widget buildDrawerMenu(){
    return Drawer(
        backgroundColor:  const Color.fromRGBO(57, 96, 143, 1.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[

            //Cabeçalho
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(228, 226, 226, 1),
              ),
              child: Text("Nome usuário"),
            ),

            //Lista de elementos
            ListTile(
              title: Text(
                "Minha conta",
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
              ),
            ),

            //Lista de elementos
            ListTile(
              title: Text(
                "Discussões",
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
              ),
            ),

            //Lista de elementos
            ListTile(
              title: Text(
                "Histórico",
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
              ),
            ),

            //Lista de elementos
            ListTile(
              title: Text(
                "Formas de pagamento",
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
              ),
            ),

            //Lista de elementos
            ListTile(
              title: Text(
                "Suporte",
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
              ),
            ),

            //Lista de elementos
            ListTile(
              title: Text(
                "Sair",
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
              ),
            ),

          ],
        ),
      );
  }
}