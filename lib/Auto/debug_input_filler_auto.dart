import 'package:debug_input_filler/Auto/debug_auto_filler_handler.dart';
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
  late final DebugAutoFillerHandler _autoFillerHandler;
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _autoFillerHandler = DebugAutoFillerHandler();
        _autoFillerHandler.applyDebugValues();
      });
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
