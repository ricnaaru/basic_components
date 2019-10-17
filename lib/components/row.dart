import 'package:flutter/material.dart';

class AdvRow extends StatelessWidget {
  final Key key;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline textBaseline;
  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Widget divider;

  AdvRow({
    this.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.children = const <Widget>[],
    this.padding,
    this.margin,
    this.divider,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> newChildren = [];

    for (Widget child in children) {
      if (child != null) {
        newChildren.add(child);
        if (divider != null) newChildren.add(divider);
      }
    }

    if (newChildren.length > 0 && divider != null) newChildren.removeAt(newChildren.length - 1);

    return Container(
        padding: padding,
        margin: margin,
        child: Row(
          key: key,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
          children: newChildren,
        ));
  }
}

class RowDivider extends StatelessWidget {
  final double size;
  final Color color;

  RowDivider(double size, {Color color})
      : this.size = size ?? 0.0,
        this.color = color ?? Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Container(width: size, height: 1.0, color: color);
  }
}