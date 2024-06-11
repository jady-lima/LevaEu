import "package:flutter/material.dart";
import "package:levaeu_mobile/model/user_data.dart";
import "package:levaeu_mobile/screens/navigation/settings/help.dart";
import "package:levaeu_mobile/screens/navigation/home_state.dart";
import "package:levaeu_mobile/screens/login/login.dart";
import "package:levaeu_mobile/screens/navigation/settings/profile.dart";
import "package:levaeu_mobile/screens/navigation/settings/share.dart";
import "package:provider/provider.dart";

class DrawerMenu{  
  static Widget buildDrawerMenu(BuildContext context){
    final userData = Provider.of<UserData>(context);

    return Drawer(
        backgroundColor:  const Color.fromRGBO(57, 96, 143, 1.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[

            //Cabeçalho
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(228, 226, 226, 1),
              ),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(0),
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    const Icon(
                      Icons.person,
                      size: 50,
                      color: Color.fromRGBO(57, 96, 143, 1.0),
                    ),

                    const SizedBox(width: 10),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget> [
                        Text(
                          userData.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),

                        Text(
                          userData.matricula,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )

                  ]
                )

              )
            ),

            buildListItem("Home", context, const HomeState()),

            buildListItem("Minha conta", context, const Profile()),

            buildListItem("Indique um amigo", context, const Share()),

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