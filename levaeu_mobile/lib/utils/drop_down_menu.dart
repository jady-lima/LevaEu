import "package:flutter/material.dart";

const List<String> genderList = <String>['','Feminino', 'Masculino', 'Prefiro não informar'];
const List<String> categoriaList = <String>['','A', 'B', 'C', 'D', 'E'];

class DropDownMenus{

  static Widget buildDropDownButton(String dropdownValue, ValueChanged<String?> onChanged,) {

    List<String> selectedList = categoriaList.indexOf == 'feminino' ? genderList : categoriaList; 
    return DropdownButtonFormField<String>(
      value: dropdownValue,
      icon: const Icon(Icons.keyboard_arrow_down),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, selecione uma opção';
        }
        return null;
      },
      onChanged: onChanged,
      items: genderList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value.isNotEmpty ? value : 'Selecione'),
        );
      }).toList(), 
    );
  }
}