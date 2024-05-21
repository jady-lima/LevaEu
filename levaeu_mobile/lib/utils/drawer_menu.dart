import "package:flutter/material.dart";
import "package:levaeu_mobile/screens/navigation/settings/help.dart";
import "package:levaeu_mobile/screens/navigation/home_state.dart";
import "package:levaeu_mobile/screens/login/login.dart";
import "package:levaeu_mobile/screens/navigation/settings/payment/payment_screen.dart";
import "package:levaeu_mobile/screens/navigation/settings/profile.dart";

class DrawerMenu{  
  static Widget buildDrawerMenu(BuildContext context){

    return Drawer(
        backgroundColor:  const Color.fromRGBO(57, 96, 143, 1.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[

            //Cabeçalho
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(228, 226, 226, 1),
              ),
              child: Text("Nome usuário"),
            ),

            buildListItem("Home", context, const HomeState()),

            buildListItem("Minha conta", context, const Profile()),

            buildListItem("Formas de pagamento", context, const Payment()),

            buildListItem("Suporte", context, const Help()),

            buildListItem("Sair", context, const Login()),

          ],
        ),
      );
  }

  static Widget buildListItem(String label, BuildContext context, Widget f,){
    return ListTile(
      title: Text(
        label,
        style: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => f));
      },
    );
  }
}