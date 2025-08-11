import 'package:debug_input_filler/Auto/widget_extensions.dart';
import 'package:debug_input_filler/utils/cmd_outpots.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef GeneratorFn = void Function(dynamic widget, dynamic value);

class ElementGenerator {
  static final List<(bool Function(Widget), GeneratorFn)> _generators = [
    ((w) => w is TextField, (w, v) => (w as TextField).generateValue(v)),
    (
      (w) => w is TextFormField,
      (w, v) => (w as TextFormField).generateValue(v)
    ),
    (
      (w) => w is CupertinoTextField,
      (w, v) => (w as CupertinoTextField).generateValue(v)
    ),
    ((w) => w is Checkbox, (w, v) => (w as Checkbox).generateValue(v)),
    ((w) => w is DropdownMenu, (w, v) => (w as DropdownMenu).generateValue(v)),
    (
      (w) => w is CheckboxListTile,
      (w, v) => (w as CheckboxListTile).generateValue(v)
    ),
    ((w) => w is DropdownButton, (w, v) => triggerDropdown(w)),
  ];
  engine(Element element, dynamic value) {
    final widget = element.widget;

    // Try to find and call generateValue dynamically
    for (final (predicate, generator) in _generators) {
      if (predicate(widget)) {
        generator(widget, value);
        return;
      }
    }
    if (widget is Radio) {
      return;
    }

    debugPrint(
      '${CmdOutputs.libraryHeader} ${CmdOutputs.unAbleToGenerate} ${widget.runtimeType} (unsupported widget)',
    );
  }
}
