import "package:flutter/material.dart";

class CheckBoxMenus{
  static Widget buildCheckBoxMenu(bool isChecked, ValueChanged<bool?> onChanged){
    return CheckboxMenuButton(
      value: isChecked,
      onChanged: onChanged,
      child: const Text("Motorista"),
    );
  }
}