import 'package:flutter/material.dart';

class ControlButtonLayout extends StatelessWidget {
  final Widget child;
  const ControlButtonLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: SizedBox(
        width: 30,
        height: 30,
        child: child,
      ),
    );
  }
}
