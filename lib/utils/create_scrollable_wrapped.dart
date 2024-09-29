import 'package:choice/choice.dart';
import 'package:flutter/material.dart';

ChoiceListBuilder createScrollableWrapped({
    Axis direction = Axis.horizontal,
    WrapAlignment alignment = WrapAlignment.start,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    double spacing = 10.0,
    WrapAlignment runAlignment = WrapAlignment.start,
    double runSpacing = 10.0,
    WrapCrossAlignment crossAxisAlignment = WrapCrossAlignment.start,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    Clip clipBehavior = Clip.none,
  }) {
    return (itemBuilder, itemCount) {
      return SingleChildScrollView(
        child: Padding(
          padding: padding,
          child: Wrap(
            direction: direction,
            alignment: alignment,
            spacing: spacing,
            runAlignment: runAlignment,
            runSpacing: runSpacing,
            crossAxisAlignment: crossAxisAlignment,
            textDirection: textDirection,
            verticalDirection: verticalDirection,
            clipBehavior: clipBehavior,
            children: List<Widget>.generate(
              itemCount,
              (i) => itemBuilder(i),
            ),
          ),
        ),
      );
    };
  }