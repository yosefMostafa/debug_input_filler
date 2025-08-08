import 'dart:math';

import 'package:debug_input_filler/utils/cmd_outpots.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ElementGenerator {
  engine(Element element, dynamic value) {
    if (element.widget is TextField ||
        element.widget is TextFormField ||
        element.widget is CupertinoTextField) {
      _genrateTextField(element.widget, value);
    } else if (element.widget is Checkbox ||
        element.widget is CheckboxListTile) {
      _generateCheckbox(element.widget, value);
    } else if (element.widget is DropdownMenu) {
      _generateDropDown(element.widget as DropdownMenu, value);
    } else {}
  }

  _genrateTextField(Widget textField, dynamic value) {
    final controllerField = (textField as dynamic).controller;
    if (controllerField != null) {
      debugPrint(
          '${CmdOutputs.libraryHeader} ${CmdOutputs.generatingValue} ${textField.runtimeType}');
      controllerField.text = value;
    } else {
      debugPrint(
          '${CmdOutputs.libraryHeader} ${CmdOutputs.noController} ${textField.runtimeType} ');
    }
  }

  _generateCheckbox(Widget checkbox, dynamic value) {
    if ((checkbox as dynamic).onChanged == null) {
      debugPrint(
          '${CmdOutputs.libraryHeader} ${CmdOutputs.unAbleToGenerate} ${checkbox.runtimeType} with no onChanged callback');
      return;
    }
    debugPrint(
        '${CmdOutputs.libraryHeader} ${CmdOutputs.generatingValue} ${checkbox.runtimeType}');
    (checkbox as dynamic).onChanged?.call(value != '');
  }

  _generateDropDown(DropdownMenu dropdownMenu, dynamic value) {
    final controller = dropdownMenu.controller;

    final entries = dropdownMenu.dropdownMenuEntries;
    if (entries.isEmpty) {
      debugPrint(
          '${CmdOutputs.libraryHeader} ${CmdOutputs.unAbleToGenerate} ${dropdownMenu.runtimeType} with no entries');
      return;
    }
    //select a random entry from the entries
    final selectedValue = entries[Random().nextInt(entries.length)].value;

    if (controller == null) {
      debugPrint(
          '${CmdOutputs.libraryHeader} ${CmdOutputs.noController} ${dropdownMenu.runtimeType}');
    } else {
      debugPrint(
          '${CmdOutputs.libraryHeader} ${CmdOutputs.generatingValue} ${dropdownMenu.runtimeType}');
      controller.text = value != '' ? selectedValue : value;
    }
  }
}
