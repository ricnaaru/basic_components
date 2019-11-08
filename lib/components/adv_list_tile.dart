import 'package:flutter/material.dart';
import 'package:basic_components/components/adv_row.dart';

typedef GestureTapCallback = void Function();

class AdvListTile extends StatelessWidget {
  final Widget start;
  final Widget expanded;
  final Widget end;
  final EdgeInsetsGeometry padding;
  final double divider;
  final GestureTapCallback onTap;
  final CrossAxisAlignment crossAxisAlignment;

  AdvListTile(
      {this.start,
      this.expanded,
      this.end,
      EdgeInsetsGeometry padding,
      double divider,
      this.onTap,
      this.crossAxisAlignment = CrossAxisAlignment.center})
      : this.padding = padding ?? EdgeInsets.all(16.0),
        this.divider = divider ?? 10.0;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (start != null) children.add(start);
    if (expanded != null) children.add(Expanded(child: expanded));
    if (end != null) children.add(end);

    return Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(
              padding: padding,
              child: AdvRow(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: crossAxisAlignment,
                  divider: RowDivider(divider),
                  children: children)),
          onTap: onTap,
        ));
  }
}
