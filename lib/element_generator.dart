import 'dart:math';

import 'package:debug_input_filler/cmd_outpots.dart';
import 'package:debug_input_filler/highlight_wrapper.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ElementGenerator {
  engine(Element element, String value) {
    if (element.widget is TextField ||
        element.widget is TextFormField ||
        element.widget is CupertinoTextField) {
      _genrateTextField(element.widget, value);
    } else if (element.widget is Checkbox ||
        element.widget is CheckboxListTile) {
      _generateCheckbox(element.widget);
    } else if (element.widget is DropdownMenu) {
      _generateDropDown(element.widget as DropdownMenu);
    } else {
      // Handle other widget types if necessary
      // debugPrint('Unhandled widget type: ${element.widget.runtimeType}');
    }
  }

  _genrateTextField(Widget textField, String value) {
    final controllerField = (textField as dynamic).controller;
    if (controllerField != null) {
      debugPrint(
          '${CmdOutputs.libraryHeader} ${CmdOutputs.generatingValue} ${textField.runtimeType}');
      controllerField.text = value;
    } else {
      debugPrint(
          '${CmdOutputs.libraryHeader} ${CmdOutputs.unAbleToGenerate} ${textField.runtimeType} with no controller');
    }
  }

  _generateCheckbox(
    Widget checkbox,
  ) {
    if ((checkbox as dynamic).onChanged == null) {
      debugPrint(
          '${CmdOutputs.libraryHeader} ${CmdOutputs.unAbleToGenerate} ${checkbox.runtimeType} with no onChanged callback');
      return;
    }
    debugPrint(
        '${CmdOutputs.libraryHeader} ${CmdOutputs.generatingValue} ${checkbox.runtimeType}');
    (checkbox as dynamic).onChanged?.call(true);
  }

  _generateDropDown(DropdownMenu dropdownMenu) {
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
          '${CmdOutputs.libraryHeader} ${CmdOutputs.unAbleToGenerate} ${dropdownMenu.runtimeType} with no controller');
    } else {
      debugPrint(
          '${CmdOutputs.libraryHeader} ${CmdOutputs.generatingValue} ${dropdownMenu.runtimeType}');
      controller.text = selectedValue;
    }
  }
}
