import 'package:debug_input_filler/utils/enums.dart';

class DebugProfile {
  final String name; // For user selection in debug UI
  final Map<InputTypes, dynamic> values; // The actual data to inject

  const DebugProfile({required this.name, required this.values});
}

class DebugProfileAuto extends DebugProfile {
  const DebugProfileAuto()
      : super(name: 'Auto', values: const <InputTypes, String>{});
}
