import "package:flutter/material.dart";

class ElevatedButtonsForms{
  static Widget buildElevatedButton(Color? colorButton, Color? colorText, Color colorBorder, double sizeWidth, double sizeHeight, String text, BuildContext context, Widget f, GlobalKey<FormState>? formkey){

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(sizeWidth, sizeHeight),
        backgroundColor: colorButton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side:  BorderSide(
          color: colorBorder
        ),
      ),
      child:Text(
        " $text",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: colorText,
          fontSize: 16,
        ),
      ),
      onPressed: (){
        if (formkey == null || formkey.currentState!.validate()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => f));
        }        
      }, 
    );
  }

  static Widget buildElevatedButtonSubmitUserData(
      Color? colorButton,
      Color? colorText,
      Color colorBorder,
      double sizeWidth,
      double sizeHeight,
      String text,
      BuildContext context,
      GlobalKey<FormState>? formkey,
      VoidCallback onSubmit) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(sizeWidth, sizeHeight),
        backgroundColor: colorButton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide(color: colorBorder),
      ),
      child: Text(
        " $text",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: colorText,
          fontSize: 16,
        ),
      ),
      onPressed: () {
        if (formkey == null || formkey.currentState!.validate()) {
          onSubmit();
        }
      },
    );
  }



  static Widget buildElevatedButtonIcon(IconData? icon, String text, BuildContext context, Function() onPressed, {bool rootNavigator = false}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(200, 80),
        maximumSize: const Size(320, 120),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side:  const BorderSide(
          color: Color.fromRGBO(196, 198, 208, 1.0), 
        ),
      ),      
      onPressed: () {
        if (rootNavigator) {
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => onPressed()));
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => onPressed()));
        }
      },
      child: Row(
        children: <Widget>[
          if (icon != null) 
            Icon(icon),
          Text(
            " $text",
            style: const TextStyle(
              color: Color.fromRGBO(90, 90, 90, 1.0),
              fontSize: 16
            ),
          ),

        ],
      ) 
    );
  }
}