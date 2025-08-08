import 'package:debug_input_filler/cmd_outpots.dart';
import 'package:debug_input_filler/element_generator.dart';
import 'package:debug_input_filler/faker.dart';
import 'package:debug_input_filler/keys.impl.dart';
import 'package:debug_input_filler/profiling/profiling.model.dart';
import 'package:debug_input_filler/profiling/profiling_register.dart';
import 'package:flutter/material.dart';

class DebugAutoFillerHandler {
  static final FakerDataGenrator _faker = FakerDataGenrator();
  static final ElementGenerator _elementGenerator = ElementGenerator();
  late final DebugProfileRegistry _profileRegistry =
      DebugProfileRegistry.instance;
  late DebugProfile _currentProfile;

  DebugAutoFillerHandler() {
    if (_profileRegistry.hasProfiles) {
      _currentProfile = _profileRegistry.currentProfile;
    }
  }

  void applyDebugValues() {
    // final root = context.findRenderObject();
    final rootElement = WidgetsBinding.instance.rootElement;
    rootElement?.visitChildElements(_visit);
  }

  void refresh(Element element) {
    element.visitChildElements(_visit);
  }

  void switchOff(Element element) {
    element.visitChildElements(_clean);
  }

  bool hasProfile() {
    return _profileRegistry.hasProfiles;
  }

  List<DebugProfile> getProfiles() {
    return _profileRegistry.profiles;
  }

  DebugProfile get currentProfile => _currentProfile;
  void setProfileIndex(int index) {
    if (_profileRegistry.hasProfiles) {
      _currentProfile = _profileRegistry.profiles[index];
      _profileRegistry.currentProfileIndex = index;
      debugPrint(
          '${CmdOutputs.libraryHeader} Current profile set to: ${_currentProfile.name}');
    }
  }

  void _clean(Element element) {
    final key = element.widget.key;
    if (key is DebugInputFillerKeys) {
      final String value = '';
      debugPrint(
          '${CmdOutputs.libraryHeader} Processing element with key: ${key.toString()}');
      _elementGenerator.engine(element, value);
    }
    element.visitChildElements(_clean);
  }

  dynamic getValue(DebugInputFillerKeys key) {
    if (_profileRegistry.hasProfiles) {
      return _currentProfile.values[key.keyType];
    }
    return _faker.generateValueFromKey(key);
  }

  void _visit(Element element) {
    final key = element.widget.key;
    if (key is DebugInputFillerKeys) {
      final value = getValue(key);
      debugPrint(
          '${CmdOutputs.libraryHeader} Processing element with key: ${key.toString()}');
      _elementGenerator.engine(element, value);
    }
    element.visitChildElements(_visit);
  }
}
