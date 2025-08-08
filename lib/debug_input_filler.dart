import 'package:debug_input_filler/Auto/debug_input_filler_auto.dart';
import 'package:debug_input_filler/utils/enums.dart';
import 'package:debug_input_filler/widgets/highlight_wrapper.dart';
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
  final DebugInitializer? initializeValues;
  final bool enableAutoFillerHighlight;
  final DebugFormBuilder builder;
  final DebugInputFillerTypes detctionAlgorithm;
  const DebugInitialValues({
    super.key,
    this.initializeValues,
    this.enableAutoFillerHighlight = false,
    required this.builder,
    this.detctionAlgorithm = DebugInputFillerTypes.simpleBuilderFunction,
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
    if (detctionAlgorithm == DebugInputFillerTypes.auto) {
      return DebugAutoFillerScopeState(
        child: HighlightWrapper(
            highlight: enableAutoFillerHighlight, child: builder(context)),
      );
    } else if (detctionAlgorithm ==
        DebugInputFillerTypes.simpleBuilderFunction) {
      initializeValues != null ? initializeValues!() : () {};
      return builder(context);
    }
    return builder(context);
  }
}
