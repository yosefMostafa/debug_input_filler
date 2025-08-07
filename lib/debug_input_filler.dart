import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

typedef DebugFormBuilder = Widget Function(
  BuildContext context,
  // T Function<T>(String key), // Typed value getter
);
typedef DebugInitializer = void Function();

class DebugInitialValues extends StatelessWidget {
  final DebugInitializer initializeValues;
  final DebugFormBuilder builder;

  const DebugInitialValues({
    super.key,
    required this.initializeValues,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    kDebugMode ? initializeValues() : null;
    // T getValue<T>(String key) {
    //   final value = debugValues[key];
    //   if (value is T) return value;
    //   if (T == String) return '' as T;
    //   if (T == bool) return false as T;
    //   if (T == int) return 0 as T;
    //   if (T == double) return 0.0 as T;
    //   if (T == DateTime) return DateTime(2000) as T;

    //   return null as T;
    // }

    return builder(context);
  }
}
