library flutter_page_stepper;

import 'package:flutter/material.dart';

class FlutterPageStepper extends StatelessWidget {
  final int stepperLength;
  final int currentIndex;
  final List<Widget> children;
  final Color activeColor;
  final Color? inactiveColor;
  final TextStyle? textStyle;
  final double? headingVerticalPadding;
  final double? dividerWidth;
  final double? indexContainerSize;

  const FlutterPageStepper(
      {super.key,
      required this.stepperLength,
      required this.currentIndex,
      required this.children,
      required this.activeColor,
      this.inactiveColor,
      this.textStyle,
      this.headingVerticalPadding = 0,
      this.dividerWidth = 50,
      this.indexContainerSize = 35});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: headingVerticalPadding ?? 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(stepperLength, (index) => null)
                .asMap()
                .map((index, element) => MapEntry(
                    index,
                    Row(
                      children: [
                        Container(
                          height: indexContainerSize,
                          width: indexContainerSize,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex <= index - 1
                                  ? (inactiveColor ??
                                      activeColor.withOpacity(0.5))
                                  : activeColor),
                          child: Center(
                              child: Text("${index + 1}", style: textStyle)),
                        ),
                        index == (stepperLength - 1)
                            ? const SizedBox()
                            : Container(
                                height: 0.4,
                                width: dividerWidth,
                                color: Colors.black,
                              )
                      ],
                    )))
                .values
                .toList(),
          ),
        ),
        Expanded(
          child: IndexedStack(
            index: currentIndex,
            children: children,
          ),
        )
      ],
    );
  }
}
