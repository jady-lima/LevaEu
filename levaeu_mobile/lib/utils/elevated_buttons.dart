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
}