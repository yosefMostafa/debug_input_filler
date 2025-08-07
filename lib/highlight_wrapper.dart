import 'package:debug_input_filler/debug_input_filler_auto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HighlightWrapper extends StatefulWidget {
  final Widget child;
  final bool highlight;

  const HighlightWrapper({
    super.key,
    required this.child,
    this.highlight = false,
  });

  @override
  State<HighlightWrapper> createState() => _HighlightWrapperState();
}

class _HighlightWrapperState extends State<HighlightWrapper> {
  @override
  Widget build(BuildContext context) {
    if (!kDebugMode || !widget.highlight) {
      return widget.child;
    }
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orangeAccent, width: 2),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          widget.child,

          //add button to refresh generation
          Directionality(
            textDirection: TextDirection.ltr, // or rtl for Arabic/Hebrew

            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.refresh),
                iconSize: 18,
                onPressed: () {
                  DebugAutoFillerScopeState.triggerHighlightedRefresh(
                    context as Element,
                  );
                  // Trigger a rebuild to refresh the highlight
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
