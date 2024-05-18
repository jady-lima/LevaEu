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

  static Widget buildElevatedButtonIcon(Color? colorButton, Color? colorText, Color colorBorder, double sizeWidth,  IconData? icon, String text, BuildContext context, Widget f){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(200, 80),
        maximumSize: const Size(320, 120),
        backgroundColor: colorButton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side:  BorderSide(
          color: colorBorder
        ),
        
      ),
      child: Row(
        children: <Widget>[
          if (icon != null) 
            Icon(icon),
          Text(
            " $text",
            style: TextStyle(
              color: colorText,
              fontSize: 16
            ),
          ),
        ],
      ),
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => f));        
      }, 
    );
  }
}