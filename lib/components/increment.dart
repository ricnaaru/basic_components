library increment;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:basic_components/components/row.dart';

part 'increment_controller.dart';

class AdvIncrement extends StatefulWidget {
  final Key key;
  final num amount;
  final AdvIncrementController controller;
  final FocusNode focusNode;
  final InputDecoration decoration;
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

  AdvIncrement({
    this.key,
    this.amount,
    this.controller,
    this.focusNode,
    this.decoration,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
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

    Widget textField = TextField(
      key: widget.key,
      controller: textEditingCtrl,
      focusNode: widget.focusNode,
      decoration: decoration.copyWith(
        errorText: _effectiveController.error,
        contentPadding: EdgeInsets.symmetric(
          horizontal: horizontalContentPadding,
          vertical: verticalContentPadding,
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

    return Stack(
      children: [
        textField,
        Positioned(
          left: edgeMargin,
          top: 0.0,
          bottom: 0.0,
          child: Material(
              clipBehavior: Clip.antiAlias,
              shape: CircleBorder(),
              type: MaterialType.transparency,
              child: InkWell(
                  onTap: () {
                    widget.controller.error = null;
                    if (widget.controller.minAmount == widget.controller.amount) return;
                    widget.controller.amount--;
                    if (widget.onChanged != null)
                      widget.onChanged(widget.controller.amount);},
                  child: Container(
                      width: fontSize + (paddingSize * 2),
                      height: fontSize + (paddingSize * 2),
                      padding: EdgeInsets.all(paddingSize),
                      child: Icon(Icons.remove, size: fontSize)))),
        ),
        Positioned(
          right: edgeMargin,
          top: 0.0,
          bottom: 0.0,
          child: Material(
              clipBehavior: Clip.antiAlias,
              shape: CircleBorder(),
              type: MaterialType.transparency,
              child: InkWell(
                  onTap: () {
                    widget.controller.error = null;
                    if (widget.controller.maxAmount == widget.controller.amount) return;
                    widget.controller.amount++;
                    if (widget.onChanged != null) widget.onChanged(widget.controller.amount);
                  },
                  child: Container(
                      width: fontSize + (paddingSize * 2),
                      height: fontSize + (paddingSize * 2),
                      padding: EdgeInsets.all(paddingSize),
                      child: Icon(Icons.add, size: fontSize)))),
        ),
      ],
    );
  }
}
