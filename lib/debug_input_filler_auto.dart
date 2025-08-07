import 'package:debug_input_filler/cmd_outpots.dart';
import 'package:debug_input_filler/element_generator.dart';
import 'package:debug_input_filler/faker.dart';
import 'package:debug_input_filler/keys.impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DebugAutoFillerScopeState extends StatefulWidget {
  final Widget child;
  const DebugAutoFillerScopeState({super.key, required this.child});

  @override
  State<DebugAutoFillerScopeState> createState() =>
      _DebugAutoFillerScopeState();

  static void triggerHighlightedRefresh(Element element) {
    final FakerDataGenrator faker = FakerDataGenrator();
    final ElementGenerator elementGenerator = ElementGenerator();
    final key = element.widget.key;
    if (key is DebugInputFillerKeys) {
      final value = faker.generateValueFromKey(key);
      debugPrint(
          '${CmdOutputs.libraryHeader} Processing element with key: ${key.toString()}');
      elementGenerator.engine(element, value);
    }
    element.visitChildElements(triggerHighlightedRefresh);
  }
}

class _DebugAutoFillerScopeState extends State<DebugAutoFillerScopeState> {
  final FakerDataGenrator _faker = FakerDataGenrator();
  final ElementGenerator _elementGenerator = ElementGenerator();
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
    rootElement?.visitChildElements(visit);
  }

  void visit(Element element) {
    final key = element.widget.key;
    if (key is DebugInputFillerKeys) {
      final value = _faker.generateValueFromKey(key);
      debugPrint(
          '${CmdOutputs.libraryHeader} Processing element with key: ${key.toString()}');
      _elementGenerator.engine(element, value);
    }
    element.visitChildElements(visit);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
