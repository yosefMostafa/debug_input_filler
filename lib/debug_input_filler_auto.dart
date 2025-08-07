import 'package:debug_input_filler/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DebugAutoFillerScopeState extends StatefulWidget {
  final Widget child;
  const DebugAutoFillerScopeState({super.key, required this.child});

  @override
  State<DebugAutoFillerScopeState> createState() =>
      _DebugAutoFillerScopeState();
}

class _DebugAutoFillerScopeState extends State<DebugAutoFillerScopeState> {
  final FakerDataGenrator _faker = FakerDataGenrator();
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _applyDebugValues();
      });
    }
  }

  void _applyDebugValues() {
    // final root = context.findRenderObject();
    final rootElement = WidgetsBinding.instance.rootElement;

    void visit(Element element) {
      final key = element.widget.key;
      if (key is ValueKey<String>) {
        final String value = _faker.generateValueFromKey(key);

        // Detect and update TextField
        if (element.widget is TextField) {
          // how to get the TextEditingController from the TextField?
          final textField = element.widget as TextField;
          final controllerField = textField.controller;

          if (controllerField != null) {
            controllerField.text = value;
          }
        }

        // Handle Checkbox similarly...
      }

      element.visitChildElements(visit);
    }

    rootElement?.visitChildElements(visit);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
