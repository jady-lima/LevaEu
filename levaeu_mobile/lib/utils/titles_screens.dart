import "package:flutter/material.dart";

class TitlesScreens{
  
  static Widget buildMainTitle(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      softWrap: true,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 24,
        color: Color.fromRGBO(65, 65, 65, 1)
      ),
    );
  }

  static Widget buildSecondaryTitle(String title){
    return Text(
      title,
      textAlign: TextAlign.center,
      softWrap: true,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: Color.fromRGBO(160, 160, 160, 1)
      ),
    );
  }

  static Widget buildStartSecondaryTitle(String title){
    return Text(
      title,
      textAlign: TextAlign.center,
      softWrap: true,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Color.fromRGBO(160, 160, 160, 1)
      ),
    );
  }
}