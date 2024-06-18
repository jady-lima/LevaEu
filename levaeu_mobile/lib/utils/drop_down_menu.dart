import 'package:flutter/material.dart';

enum ListType {
  genderList,
  categoryList,
  vehicleList,
}

List<String> categoryList = ['', 'A', 'B', 'C', 'D', 'E'];
List<String> genderList = ['','Feminino', 'Masculino', 'Prefiro não informar'];
List<String> vehicleList = ['','Carro', 'Moto'];

class DropDownMenus {

  static Widget buildDropDownButton(String dropdownValue, ValueChanged<String?> onChanged, ListType listType) {
    List<String> itemList;
    
    switch(listType) {
      case ListType.categoryList:
        itemList = categoryList;
        break;
      case ListType.genderList:
        itemList = genderList;
        break;
      case ListType.vehicleList:
        itemList = vehicleList;
        break;
    }

    if (!itemList.contains(dropdownValue)) {
      dropdownValue = itemList.first;
    }

    itemList = itemList.toSet().toList();

    return DropdownButtonFormField<String>(
      value: dropdownValue,
      icon: const Icon(Icons.keyboard_arrow_down),
      elevation: 16,
      style: const TextStyle(color: Color.fromRGBO(57, 96, 143, 1.0)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, selecione uma opção';
        }
        return null;
      },
      onChanged: onChanged,
      items: itemList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value.isNotEmpty ? value : 'Selecione'),
        );
      }).toList(), 
    );
  }
}
