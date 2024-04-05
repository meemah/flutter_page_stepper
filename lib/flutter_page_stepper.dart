library flutter_page_stepper;

import 'package:flutter/material.dart';

class FlutterPageStepper extends StatelessWidget {
  ///number of stepper
  final int stepperLength;

  ///current index of stepper
  final int currentIndex;

  ///the pages
  final List<Widget> children;

  /// background color of the stepper when active
  final Color activeColor;

  /// background color of the stepper when inactive
  final Color? inactiveColor;

  /// textStyle of the number in the indicator
  final TextStyle? textStyle;

  /// vertical padding on the stepper header
  final double? headingVerticalPadding;

  /// width of divider in between each indicator
  final double? dividerWidth;

  /// size of the indicator
  final double? indicatorSize;

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
      this.indicatorSize = 35})
      : assert(stepperLength == children.length,
            'children has to be the same length to currentIndex');

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
                          height: indicatorSize,
                          width: indicatorSize,
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
