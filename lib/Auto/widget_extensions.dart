import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:debug_input_filler/utils/cmd_outpots.dart';
import 'package:flutter/material.dart';

void _setControllerText(
    TextEditingController? controller, dynamic value, Type runtimeType) {
  if (controller != null) {
    debugPrint(
        '${CmdOutputs.libraryHeader} ${CmdOutputs.generatingValue} $runtimeType');
    controller.text = value?.toString() ?? '';
  } else {
    debugPrint(
        '${CmdOutputs.libraryHeader} ${CmdOutputs.noController} $runtimeType');
  }
}

void _checkersValue(Function? onChanged, dynamic value, Type runtimeType) {
  if (onChanged == null) {
    debugPrint(
        '${CmdOutputs.libraryHeader} ${CmdOutputs.unAbleToGenerate} $runtimeType with no onChanged callback');
    return;
  }
  debugPrint(
      '${CmdOutputs.libraryHeader} ${CmdOutputs.generatingValue} $runtimeType');
  onChanged.call(value != '');
}

extension TextFieldValueGen on TextField {
  void generateValue(dynamic value) =>
      _setControllerText(controller, value, runtimeType);
}

extension TextFormFieldGenerator on TextFormField {
  void generateValue(dynamic value) =>
      _setControllerText(controller, value, runtimeType);
}

extension CupertinoTextFieldGenerator on CupertinoTextField {
  void generateValue(dynamic value) =>
      _setControllerText(controller, value, runtimeType);
}

extension CheckboxGenerator on Checkbox {
  void generateValue(dynamic value) =>
      _checkersValue(onChanged, value, runtimeType);
}

extension CheckboxListTileGenerator on CheckboxListTile {
  void generateValue(dynamic value) =>
      _checkersValue(onChanged, value, runtimeType);
}

extension DropdownMenuGenerator on DropdownMenu {
  void generateValue(dynamic value) {
    final controller = this.controller;
    final entries = dropdownMenuEntries;
    if (entries.isEmpty) {
      debugPrint(
          '${CmdOutputs.libraryHeader} ${CmdOutputs.unAbleToGenerate} $runtimeType with no entries');
      return;
    }

    //select a random entry from the entries
    final selectedValue = entries[Random().nextInt(entries.length)].value;

    if (controller == null) {
      debugPrint(
          '${CmdOutputs.libraryHeader} ${CmdOutputs.noController} $runtimeType');
    } else {
      debugPrint(
          '${CmdOutputs.libraryHeader} ${CmdOutputs.generatingValue} $runtimeType');
      controller.text = value != '' ? selectedValue : value;
    }
  }
}

void triggerDropdown(dynamic widget) {
  final items = (widget as dynamic).items;
  if (items != null && items.isNotEmpty) {
    final randomItem = items[Random().nextInt(items.length)].value;
    final onChanged = (widget as dynamic).onChanged;
    if (onChanged != null) {
      (onChanged as dynamic).call(randomItem); // <-- the magic
    } else {
      debugPrint(
          '${CmdOutputs.libraryHeader} ${CmdOutputs.noOnChanged} ${widget.runtimeType}');
    }
  } else {
    debugPrint(
      '${CmdOutputs.libraryHeader} ${CmdOutputs.unAbleToGenerate} ${widget.runtimeType} (unsupported widget)',
    );
  }
}

void triggerRandomRadioInEachGroup(List<dynamic> foundWidgets) {
  // Group radios by their groupValue
  final radiosByGroup = <dynamic, List<dynamic>>{};
  for (final widget in foundWidgets) {
    final groupValue = (widget as dynamic).groupValue;
    radiosByGroup.putIfAbsent(groupValue, () => []).add(widget);
  }
  debugPrint(
    '${CmdOutputs.libraryHeader} Found ${radiosByGroup.length} radio groups with ${foundWidgets.length} total radios',
  );
  // Trigger random radio in each group
  radiosByGroup.forEach((groupValue, radios) {
    if (radios.isEmpty) return;

    final randomRadio = radios[Random().nextInt(radios.length)];
    final onChanged = (randomRadio as dynamic).onChanged;
    final radioValue = randomRadio.value;

    if (onChanged != null) {
      (onChanged as dynamic).call(radioValue);
    } else {
      debugPrint('No onChanged for ${randomRadio.runtimeType}');
    }
  });
}
