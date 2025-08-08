import 'package:debug_input_filler/Auto/debug_auto_filler_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HighlightWrapper extends StatefulWidget {
  final Widget child;
  final bool highlight;
  final bool enableProfile;
  final bool onAndOff;
  final bool refresh;

  const HighlightWrapper({
    super.key,
    required this.child,
    this.highlight = false,
    this.enableProfile = true,
    this.onAndOff = true,
    this.refresh = true,
  });

  @override
  State<HighlightWrapper> createState() => _HighlightWrapperState();
}

class _HighlightWrapperState extends State<HighlightWrapper> {
  final DebugAutoFillerHandler _autoFillerHandler = DebugAutoFillerHandler();
  bool generatinonOn = true;
  @override
  Widget build(BuildContext context) {
    if (!kDebugMode || !widget.highlight) {
      return widget.child;
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: Theme.of(context).colorScheme.secondary, width: 2),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _autoFillerHandler.hasProfile() && widget.enableProfile
                      ? ControlButtonLayout(
                          child: PopupMenuButton(
                          icon: const Icon(Icons.more_vert, size: 16),
                          itemBuilder: (context) {
                            return _autoFillerHandler
                                .getProfiles()
                                .map((profile) {
                              return PopupMenuItem(
                                value: profile,
                                child: Text(profile.name),
                              );
                            }).toList();
                          },
                          onSelected: (value) {
                            _autoFillerHandler.setProfileIndex(
                              _autoFillerHandler.getProfiles().indexOf(value),
                            );

                            _autoFillerHandler.refresh(
                              context as Element,
                            );
                          },
                        ))
                      : const SizedBox.shrink(),
                  widget.onAndOff
                      ? ControlButtonLayout(
                          child: Transform.scale(
                            scale: 0.5,
                            child: Switch(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                padding: const EdgeInsets.all(0.0),
                                value: generatinonOn,
                                onChanged: (value) {
                                  if (value) {
                                    _autoFillerHandler.refresh(
                                      context as Element,
                                    );
                                  } else {
                                    _autoFillerHandler.switchOff(
                                      context as Element,
                                    );
                                  }
                                  setState(() {
                                    generatinonOn = value;
                                  });
                                }),
                          ),
                        )
                      : const SizedBox.shrink(),
                  widget.refresh
                      ? ControlButtonLayout(
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(Icons.refresh),
                            iconSize: 18,
                            onPressed: () {
                              _autoFillerHandler.refresh(
                                context as Element,
                              );
                              // Trigger a rebuild to refresh the highlight
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
