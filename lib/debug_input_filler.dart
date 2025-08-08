import 'package:debug_input_filler/Auto/debug_input_filler_auto.dart';
import 'package:debug_input_filler/Exeptions/profiling.exceptions.dart';
import 'package:debug_input_filler/enums.dart';
import 'package:debug_input_filler/highlight_wrapper.dart';
import 'package:debug_input_filler/profiling/profiling.model.dart';
import 'package:debug_input_filler/profiling/profiling_register.dart';
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
  final DebugInputFillerTypes detctionAlgorithm;
  const DebugInitialValues({
    super.key,
    required this.initializeValues,
    required this.builder,
    required this.detctionAlgorithm,
  });
  void configProfiles({
    required List<DebugProfile> profiles,
    int profileIndex = 0,
  }) {
    DebugProfileRegistry.instance.initialize(
      initialProfiles: profiles,
      profileIndex: profileIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) {
      return builder(context);
    }

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
    if (detctionAlgorithm == DebugInputFillerTypes.auto) {
      return DebugAutoFillerScopeState(
        child: HighlightWrapper(child: builder(context)),
      );
    } else if (detctionAlgorithm ==
        DebugInputFillerTypes.simpleBuilderFunction) {
      return builder(context);
    }
    return builder(context);
  }
}
