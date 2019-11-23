import 'package:basic_components/helper/theme_helper.dart';
import 'package:flutter/material.dart';

class AdvLink extends StatelessWidget {
  final String text;
  final EdgeInsets padding;
  final VoidCallback onTap;
  final TextStyle style;

  const AdvLink(this.text, {this.padding, this.onTap, this.style});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Container(
        padding: padding ?? EdgeInsets.all(4.0),
        child: Text(
          text,
          style: style == null
              ? TextStyle(color: linkColor)
              : style.copyWith(color: linkColor),
        ),
      ),
    );
  }
}
