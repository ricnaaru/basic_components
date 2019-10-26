library increment;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:basic_components/components/adv_row.dart';

part 'adv_increment_controller.dart';

class AdvIncrement extends StatefulWidget {
  final Key key;
  final num amount;
  final AdvIncrementController controller;
  final FocusNode focusNode;
  final InputDecoration decoration;
  final EdgeInsets margin;
  final String measureText;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final TextDirection textDirection;
  final ToolbarOptions toolbarOptions;
  final bool showCursor;
  final bool autofocus;
  final ValueChanged<num> onChanged;
  final bool enabled;
  final double cursorWidth;
  final Radius cursorRadius;
  final Color cursorColor;
  final Brightness keyboardAppearance;
  final Icon subtractIcon;
  final Color subtractButtonColor;
  final ShapeBorder subtractButtonShapeBorder;
  final Icon addIcon;
  final Color addButtonColor;
  final ShapeBorder addButtonShapeBorder;

  AdvIncrement({
    this.key,
    this.amount,
    this.controller,
    this.focusNode,
    this.decoration,
    this.margin,
    this.measureText,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.center,
    this.textAlignVertical,
    this.textDirection,
    this.toolbarOptions,
    this.showCursor,
    this.autofocus = false,
    this.onChanged,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.subtractIcon,
    this.subtractButtonColor,
    this.subtractButtonShapeBorder,
    this.addIcon,
    this.addButtonColor,
    this.addButtonShapeBorder,
  }) : assert(controller == null ||
            (amount == null && decoration?.errorText == null && enabled == null));

  @override
  _AdvIncrementState createState() => _AdvIncrementState();
}

class _AdvIncrementState extends State<AdvIncrement> {
  AdvIncrementController get _effectiveController => widget.controller ?? _ctrl;

  AdvIncrementController _ctrl;

  @override
  void initState() {
    super.initState();

    _ctrl = widget.controller == null
        ? AdvIncrementController(
            amount: widget.amount ?? "",
            error: widget.decoration?.errorText,
            enabled: widget.enabled ?? true,
          )
        : null;

    _effectiveController.addListener(_update);
  }

  _update() {
    if (this.mounted) setState(() {});
  }

  @override
  void didUpdateWidget(AdvIncrement oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && oldWidget.controller != null)
      _ctrl = AdvIncrementController.fromValue(oldWidget.controller.value);
    else if (widget.controller != null && oldWidget.controller == null) _ctrl = null;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingCtrl =
        new TextEditingController(text: (_effectiveController.amount ?? 0).toInt().toString());

    textEditingCtrl.addListener(() {
      _effectiveController.removeListener(_update);
      _effectiveController.amount = num.tryParse(textEditingCtrl.text);
      _effectiveController.addListener(_update);
    });

    InputDecoration decoration = widget.decoration ?? InputDecoration();
    ThemeData themeData = Theme.of(context);
    double fontSize = (widget.style?.fontSize ?? themeData.textTheme.subhead.fontSize);
    double verticalContentPadding = fontSize / 14.0 * 10.0;
    double horizontalContentPadding = fontSize / 14.0 * 38.0;
    double paddingSize = fontSize / 14.0 * 8.0;
    double edgeMargin = fontSize / 14.0 * 4.0;

    EdgeInsets definedPadding = decoration.contentPadding;

    Widget textField = TextField(
      key: widget.key,
      controller: textEditingCtrl,
      focusNode: widget.focusNode,
      decoration: decoration.copyWith(
        errorText: _effectiveController.error,
        contentPadding: EdgeInsets.symmetric(
          horizontal: horizontalContentPadding + (definedPadding?.horizontal ?? 0),
          vertical: verticalContentPadding + (definedPadding?.vertical ?? 0),
        ),
      ),
      style: widget.style,
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textDirection: widget.textDirection,
      toolbarOptions: widget.toolbarOptions,
      showCursor: widget.showCursor,
      autofocus: widget.autofocus,
      enabled: _effectiveController.enabled,
      cursorWidth: widget.cursorWidth,
      cursorRadius: widget.cursorRadius,
      cursorColor: widget.cursorColor,
      keyboardAppearance: widget.keyboardAppearance,
      keyboardType: TextInputType.number,
    );
    double width;
    if (widget.measureText != null) {
      var tp = new TextPainter(
          text: TextSpan(
              text: widget.measureText, style: (widget.style ?? themeData.textTheme.subhead)),
          textDirection: TextDirection.ltr);

      tp.layout();

      width = tp.width + ((fontSize + (paddingSize * 2)) * 2) + (edgeMargin * 4);
    }

    return Container(
      width: width,
      margin: widget.margin,
      child: Stack(
        children: [
          textField,
          Positioned(
            left: edgeMargin + (definedPadding?.left ?? 0),
            top: 0.0,
            bottom: 0.0,
            child: Material(
                clipBehavior: Clip.antiAlias,
                color: widget.subtractButtonColor,
                shape: widget.subtractButtonShapeBorder ?? CircleBorder(),
                type:
                    widget.addButtonColor == null ? MaterialType.transparency : MaterialType.canvas,
                child: InkWell(
                    onTap: () {
                      _effectiveController.error = null;
                      if (_effectiveController.amount != null && _effectiveController.minAmount == _effectiveController.amount) return;
                      _effectiveController.amount = (_effectiveController.amount ?? 0) - 1;
                      if (widget.onChanged != null) widget.onChanged(_effectiveController.amount);
                    },
                    child: Container(
                        width: fontSize + (paddingSize * 2),
                        height: fontSize + (paddingSize * 2),
                        padding: EdgeInsets.all(paddingSize),
                        child: Icon(
                          widget.addIcon?.icon ?? Icons.remove,
                          size: fontSize,
                          color: widget.addIcon?.color,
                        )))),
          ),
          Positioned(
            right: edgeMargin + (definedPadding?.right ?? 0),
            top: 0.0,
            bottom: 0.0,
            child: Material(
                clipBehavior: Clip.antiAlias,
                color: widget.addButtonColor,
                shape: widget.addButtonShapeBorder ?? CircleBorder(),
                type:
                    widget.addButtonColor == null ? MaterialType.transparency : MaterialType.canvas,
                child: InkWell(
                    onTap: () {
                      _effectiveController.error = null;
                      if (_effectiveController.amount != null && _effectiveController.maxAmount == _effectiveController.amount) return;
                      _effectiveController.amount = (_effectiveController.amount ?? 0) + 1;
                      if (widget.onChanged != null) widget.onChanged(_effectiveController.amount);
                    },
                    child: Container(
                        width: fontSize + (paddingSize * 2),
                        height: fontSize + (paddingSize * 2),
                        padding: EdgeInsets.all(paddingSize),
                        child: Icon(
                          widget.subtractIcon?.icon ?? Icons.add,
                          size: fontSize,
                          color: widget.subtractIcon?.color,
                        )))),
          ),
        ],
      ),
    );
  }
}
