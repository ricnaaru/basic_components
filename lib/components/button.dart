import 'package:flutter/material.dart';

import '../basic_components.dart';

enum ButtonSize { small, large }

final Color lerpColor = Color(0xffD1D1D1);

class AdvButton extends StatelessWidget {
  final Widget child;
  final bool enable;
  final VoidCallback onPressed;
  final bool circular;
  final ButtonSize buttonSize;
  final bool onlyBorder;
  final bool reverse;
  final Color primaryColor;
  final Color accentColor;
  final double width;
  final EdgeInsets padding;

  AdvButton._(
      {this.child,
      bool circular = true,
      bool enable = true,
      bool onlyBorder = false,
      bool reverse = false,
      this.onPressed,
      this.buttonSize = ButtonSize.large,
      Color primaryColor,
      Color accentColor,
      this.width,
      EdgeInsets padding})
      : this.enable = enable ?? true,
        this.circular = circular ?? true,
        this.onlyBorder = onlyBorder ?? false,
        this.reverse = reverse ?? false,
        this.primaryColor = !reverse
            ? primaryColor ?? BasicComponents.button.backgroundColor
            : accentColor ?? BasicComponents.button.textColor,
        this.accentColor = !reverse
            ? accentColor ?? BasicComponents.button.textColor
            : primaryColor ?? BasicComponents.button.backgroundColor,
        this.padding = padding ?? EdgeInsets.all(0.0);

  factory AdvButton.text(String text,
      {bool circular = true,
        bool enable = true,
        bool onlyBorder = false,
        bool reverse = false,
        bool bold = false,
        VoidCallback onPressed,
        ButtonSize buttonSize,
        Color backgroundColor,
        Color textColor,
        double width,
        EdgeInsets padding}) {
    Color primaryColor = !reverse
        ? backgroundColor ?? BasicComponents.button.backgroundColor
        : textColor ?? BasicComponents.button.textColor;
    Color accentColor = !reverse
        ? textColor ?? BasicComponents.button.textColor
        : backgroundColor ?? BasicComponents.button.backgroundColor;
    double fontSize = buttonSize == ButtonSize.large ? 16.0 : 12.0;
    FontWeight fontWeight = buttonSize == ButtonSize.large
        ? bold ? FontWeight.w700 : FontWeight.w600
        : FontWeight.normal;
    Color disableTextColor = Color.lerp(!reverse ? Colors.white : Colors.black54, lerpColor, 0.6);
    Color disableBackgroundColor =
    Color.lerp(reverse ? Colors.white : Colors.black54, lerpColor, 0.6);
    Color _textColor = !onlyBorder ? accentColor : primaryColor;
    Color _disableTextColor = !onlyBorder ? disableTextColor : disableBackgroundColor;
    TextStyle textStyle = TextStyle(
        fontSize: fontSize, fontWeight: fontWeight, color: enable ? _textColor : _disableTextColor);

    return AdvButton._(
      child: Text(text, style: textStyle),
      circular: circular,
      enable: enable = true,
      onlyBorder: onlyBorder = false,
      reverse: reverse = false,
      onPressed: onPressed,
      buttonSize: buttonSize,
      primaryColor: primaryColor,
      accentColor: accentColor,
      width: width,
      padding: padding,
    );
  }

  factory AdvButton.custom({@required Widget child, bool circular = true,
        bool enable = true,
        bool onlyBorder = false,
        bool reverse = false,
        bool bold = false,
        VoidCallback onPressed,
        ButtonSize buttonSize,
        Color primaryColor,
        Color accentColor,
        double width,
        EdgeInsets padding}) {
    return AdvButton._(
      child: child,
      circular: circular,
      enable: enable = true,
      onlyBorder: onlyBorder = false,
      reverse: reverse = false,
      onPressed: onPressed,
      buttonSize: buttonSize,
      primaryColor: primaryColor,
      accentColor: accentColor,
      width: width,
      padding: padding,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildButton(context);
  }

  _defaultCallback() {}

  Widget _buildButton(BuildContext context) {
    double borderWidth = onlyBorder ? 1.0 : 0.0;
    double borderWidthAdditional = !onlyBorder ? 0.0 : 0.0;
    Color disableBackgroundColor =
        Color.lerp(reverse ? Colors.white : Colors.black54, lerpColor, 0.6);
    Color disableTextColor = Color.lerp(!reverse ? Colors.white : Colors.black54, lerpColor, 0.6);

    ShapeBorder border = RoundedRectangleBorder(
        side: BorderSide(color: enable ? primaryColor : disableBackgroundColor, width: borderWidth),
        borderRadius: new BorderRadius.circular(this.circular ? 5.0 : 0.0));

    Color _color = onlyBorder ? accentColor : primaryColor;
    Color _disableColor = onlyBorder ? disableTextColor : disableBackgroundColor;
    Color _disableTextColor = !onlyBorder ? disableTextColor : disableBackgroundColor;

    double extraPadding = this.buttonSize == ButtonSize.large ? 14.0 : 8.0;

    return ButtonTheme(
        minWidth: 0.0,
        height: 0.0,
        child: Container(
            width: width,
            child: FlatButton(
              padding: EdgeInsets.only(
                  left: this.padding.left + extraPadding + borderWidthAdditional,
                  top: this.padding.top + extraPadding + borderWidthAdditional,
                  right: this.padding.right + extraPadding + borderWidthAdditional,
                  bottom: this.padding.bottom + extraPadding + borderWidthAdditional),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: _color,
              disabledColor: _disableColor,
              disabledTextColor: _disableTextColor,
              highlightColor: Theme.of(context).dividerColor,
              splashColor: Theme.of(context).dividerColor,
              child: this.child,
              onPressed: enable ? this.onPressed ?? _defaultCallback : null,
              shape: border,
            )));
  }
}
