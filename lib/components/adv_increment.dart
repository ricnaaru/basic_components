library adv_increment;

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final EdgeInsets subtractIconPadding;
  final EdgeInsets subtractIconMargin;
  final Icon addIcon;
  final Color addButtonColor;
  final ShapeBorder addButtonShapeBorder;
  final EdgeInsets addIconPadding;
  final EdgeInsets addIconMargin;

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
    EdgeInsets subtractIconPadding,
    EdgeInsets subtractIconMargin,
    this.addIcon,
    this.addButtonColor,
    this.addButtonShapeBorder,
    EdgeInsets addIconPadding,
    EdgeInsets addIconMargin,
  })  : this.subtractIconPadding = subtractIconPadding ?? EdgeInsets.all(0.0),
        this.subtractIconMargin = subtractIconMargin ?? EdgeInsets.all(0.0),
        this.addIconPadding = addIconPadding ?? EdgeInsets.all(0.0),
        this.addIconMargin = addIconMargin ?? EdgeInsets.all(0.0),
        assert(controller == null ||
            (amount == null &&
                decoration?.errorText == null &&
                enabled == null));

  @override
  _AdvIncrementState createState() => _AdvIncrementState();
}

class _AdvIncrementState extends State<AdvIncrement> {
  AdvIncrementController get _effectiveController => widget.controller ?? _ctrl;

  AdvIncrementController _ctrl;
  TextEditingController textEditingCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    _ctrl = widget.controller == null
        ? AdvIncrementController(
            amount: widget.amount ?? 0,
            error: widget.decoration?.errorText,
            enabled: widget.enabled ?? true,
          )
        : null;

    textEditingCtrl.text = _effectiveController.amount.toString();

    _effectiveController.addListener(_update);

    textEditingCtrl.addListener(_updateTextEditing);
  }

  _updateTextEditing() {
    textEditingCtrl.removeListener(_updateTextEditing);

    if (textEditingCtrl.text == null || textEditingCtrl.text.isEmpty) {
      textEditingCtrl.text = "0";
    }

    if (textEditingCtrl.text != null &&
        _effectiveController.minAmount != null &&
        ((num.tryParse(textEditingCtrl.text ?? "0") ?? 0) <
            _effectiveController.minAmount)) {
      textEditingCtrl.text = _effectiveController.minAmount.toString();
      textEditingCtrl.selection = new TextSelection.fromPosition(
          new TextPosition(offset: (textEditingCtrl.text).length));
    }

    if (textEditingCtrl.text != null &&
        _effectiveController.maxAmount != null &&
        ((num.tryParse(textEditingCtrl.text ?? "0") ?? 0) >
            _effectiveController.maxAmount)) {
      textEditingCtrl.text = _effectiveController.maxAmount.toString();
      textEditingCtrl.selection = new TextSelection.fromPosition(
          new TextPosition(offset: (textEditingCtrl.text).length));
    }

    textEditingCtrl.addListener(_updateTextEditing);

    _effectiveController.removeListener(_update);
    _effectiveController.amount =
        num.tryParse(textEditingCtrl.text ?? "0") ?? 0;

    if (textEditingCtrl.selection != _effectiveController.selection &&
        textEditingCtrl.selection.start <=
            ((_effectiveController.amount ?? 0).toString().length ?? 0) &&
        textEditingCtrl.selection.end <=
            ((_effectiveController.amount ?? 0).toString().length ?? 0)) {
      _effectiveController.selection = textEditingCtrl.selection;
    }

    _effectiveController.addListener(_update);

    if (widget.onChanged != null) widget.onChanged(_effectiveController.amount);
  }

  _update() {
    _effectiveController.removeListener(_update);

    var cursorPos = _effectiveController.selection;
    textEditingCtrl.removeListener(_updateTextEditing);
    textEditingCtrl.text = (_effectiveController.amount ?? 0).toString();

    if (cursorPos == null ||
        cursorPos.start > (textEditingCtrl.text ?? "0").length) {
      cursorPos = new TextSelection.fromPosition(
          new TextPosition(offset: (textEditingCtrl.text ?? "0").length));
      if (_effectiveController.selection == null)
        _effectiveController.selection = cursorPos;
    }

    textEditingCtrl.selection = cursorPos;

    textEditingCtrl.addListener(_updateTextEditing);
    _effectiveController.addListener(_update);

    if (this.mounted)
      setState(() {
        textEditingCtrl.selection = cursorPos;
      });
  }

  @override
  void didUpdateWidget(AdvIncrement oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller == null && oldWidget.controller != null)
      _ctrl = AdvIncrementController.fromValue(oldWidget.controller.value);
    else if (widget.controller != null && oldWidget.controller == null)
      _ctrl = null;

    if (textEditingCtrl.selection != _effectiveController.selection &&
        textEditingCtrl.selection.start <=
            ((_effectiveController.amount ?? 0).toString().length ?? 0) &&
        textEditingCtrl.selection.end <=
            ((_effectiveController.amount ?? 0).toString().length ?? 0)) {
      _effectiveController.removeListener(_update);
      _effectiveController.selection = textEditingCtrl.selection;
      _effectiveController.addListener(_update);
    }

    var cursorPos = _effectiveController.selection;
    textEditingCtrl.removeListener(_updateTextEditing);

    if (cursorPos.start > (textEditingCtrl.text ?? "0").length) {
      cursorPos = new TextSelection.fromPosition(
          new TextPosition(offset: (textEditingCtrl.text ?? "0").length));
    } else if ((textEditingCtrl.text == null ||
            textEditingCtrl.text.isEmpty ||
            textEditingCtrl.text == "0") &&
        cursorPos.start == -1) {
      cursorPos = new TextSelection.fromPosition(new TextPosition(offset: 0));
    }

    textEditingCtrl =
        TextEditingController(text: _effectiveController.amount.toString())
          ..selection = cursorPos;
    //untuk mencegah scroll focus, karena di didupdatewidget diset ulang textnya, kalo build increment di dalam scroll, akan scroll to focus dia

    textEditingCtrl.addListener(_updateTextEditing);

    if (!_effectiveController.hasListeners)
      _effectiveController.addListener(_update);
  }

  @override
  Widget build(BuildContext context) {
    InputDecoration decoration = widget.decoration ?? InputDecoration();
    ThemeData themeData = Theme.of(context);
    double fontSize =
        (widget.style?.fontSize ?? themeData.textTheme.subhead.fontSize);

    EdgeInsets definedPadding = decoration.contentPadding;

    Widget textField = TextField(
      key: widget.key,
      controller: textEditingCtrl,
      focusNode: widget.focusNode,
      decoration: decoration.copyWith(
        errorText: _effectiveController.error,
        enabled: _effectiveController.enabled,
        filled: !_effectiveController.enabled,
        fillColor: Colors.grey,
        contentPadding: EdgeInsets.only(
          left: (fontSize * 1.5) +
              (definedPadding?.left ?? 0) +
              (widget.subtractIconPadding?.horizontal ?? 0) +
              (widget.subtractIconMargin?.horizontal ?? 0),
          right: (fontSize * 1.5) +
              (definedPadding?.right ?? 0) +
              (widget.addIconPadding?.horizontal ?? 0) +
              (widget.addIconMargin?.horizontal ?? 0),
          top: (definedPadding?.top ?? 0) +
              (max(
                  (widget.subtractIconPadding?.top ?? 0) +
                      (widget.subtractIconMargin?.top ?? 0),
                  (widget.addIconPadding?.top ?? 0) +
                      (widget.addIconMargin?.top ?? 0))),
          bottom: (definedPadding?.bottom ?? 0) +
              (max(
                  (widget.subtractIconPadding?.bottom ?? 0) +
                      (widget.subtractIconMargin?.bottom ?? 0),
                  (widget.addIconPadding?.bottom ?? 0) +
                      (widget.addIconMargin?.bottom ?? 0))),
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
              text: widget.measureText,
              style: (widget.style ?? themeData.textTheme.subhead)),
          textDirection: TextDirection.ltr);

      tp.layout();

      width = tp.width +
          (fontSize * 1.5 * 2) +
          (widget.subtractIconMargin?.horizontal ?? 0) +
          (widget.addIconMargin?.horizontal ?? 0) +
          (widget.subtractIconPadding?.horizontal ?? 0) +
          (widget.addIconPadding?.horizontal ?? 0) +
          (definedPadding?.horizontal ??
              0) /*adjustment di fontsize 60, ukuran adjustment 8.0*/;
    }

    return Container(
      width: width,
      margin: widget.margin,
      child: Stack(
        children: [
          textField,
          Positioned(
            left: widget.subtractIconMargin.left,
            top: widget.subtractIconMargin.top + (fontSize * 0.8),// supaya kalo ada error, iconnya gk ke bawah
//            bottom: widget.subtractIconMargin.bottom,
            child: IncrementButton(
              controller: _effectiveController,
              color: widget.subtractButtonColor,
              shapeBorder: widget.subtractButtonShapeBorder,
              onChanged: widget.onChanged,
              fontSize: fontSize,
              icon: widget.subtractIcon,
              iconPadding: widget.subtractIconPadding,
              incrementType: IncrementType.subtract,
            ),
          ),
          Positioned(
            right: widget.addIconMargin.right,
            top: widget.addIconMargin.top + (fontSize * 0.8),// supaya kalo ada error, iconnya gk ke bawah
//            bottom: widget.addIconMargin.bottom,
            child: IncrementButton(
              controller: _effectiveController,
              color: widget.addButtonColor,
              shapeBorder: widget.addButtonShapeBorder,
              onChanged: widget.onChanged,
              fontSize: fontSize,
              icon: widget.addIcon,
              iconPadding: widget.addIconPadding,
              incrementType: IncrementType.add,
            ),
          ),
        ],
      ),
    );
  }
}

enum IncrementType { add, subtract }

class IncrementButton extends StatefulWidget {
  final AdvIncrementController controller;
  final Color color;
  final ShapeBorder shapeBorder;
  final ValueChanged<num> onChanged;
  final double fontSize;
  final Icon icon;
  final EdgeInsets iconPadding;
  final IncrementType incrementType;

  IncrementButton({
    this.controller,
    this.color,
    this.shapeBorder,
    this.onChanged,
    this.fontSize,
    this.icon,
    this.iconPadding,
    this.incrementType,
  });

  @override
  _IncrementButtonState createState() => _IncrementButtonState();
}

class _IncrementButtonState extends State<IncrementButton> {
  @override
  Widget build(BuildContext context) {
    bool disabled = (widget.controller.amount == widget.controller.maxAmount &&
            widget.incrementType == IncrementType.add) ||
        (widget.controller.amount == widget.controller.minAmount &&
            widget.incrementType == IncrementType.subtract);

    return Stack(
      children: [
        Center(
          child: Material(
            clipBehavior: Clip.antiAlias,
            color: widget.color,
            shape: widget.shapeBorder ?? CircleBorder(),
            type: widget.color == null
                ? MaterialType.transparency
                : MaterialType.canvas,
            child: InkWell(
              onTap: widget.controller.enabled
                  ? () {
                      if (widget.incrementType == IncrementType.add) {
                        int amount = widget.controller.amount ?? 0;
                        int maxAmount = widget.controller.maxAmount;

                        widget.controller.error = null;
                        if (amount != null &&
                            maxAmount != null &&
                            maxAmount <= amount) return;
                        widget.controller.amount = (amount ?? 0) + 1;
                        if (widget.onChanged != null)
                          widget.onChanged(widget.controller.amount);
                      } else {
                        int amount = widget.controller.amount ?? 0;
                        int minAmount = widget.controller.minAmount;

                        widget.controller.error = null;
                        if (amount != null &&
                            minAmount != null &&
                            minAmount >= amount) return;
                        widget.controller.amount = (amount ?? 0) - 1;
                        if (widget.onChanged != null)
                          widget.onChanged(widget.controller.amount);
                      }

                      if (widget.controller.amount ==
                              widget.controller.maxAmount ||
                          widget.controller.amount ==
                              widget.controller.minAmount) {
                        if (this.mounted) setState(() {});
                      }
                    }
                  : null,
              child: Container(
                width: (widget.fontSize * 1.5) + widget.iconPadding.horizontal,
                height: (widget.fontSize * 1.5) + widget.iconPadding.vertical,
                padding: widget.iconPadding,
                child: Icon(
                  widget.icon?.icon ??
                      (widget.incrementType == IncrementType.add
                          ? Icons.add
                          : Icons.remove),
                  size: (widget.fontSize * 1.5),
                  color: widget.icon?.color,
                ),
              ),
            ),
          ),
        ),
        Center(
          child: disabled
              ? Material(
                  clipBehavior: Clip.antiAlias,
                  shape: widget.shapeBorder ?? CircleBorder(),
                  type: MaterialType.transparency,
                  child: Container(
                    width:
                        (widget.fontSize * 1.5) + widget.iconPadding.horizontal,
                    height:
                        (widget.fontSize * 1.5) + widget.iconPadding.vertical,
                    padding: widget.iconPadding,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                )
              : Container(),
        ),
      ],
    );
  }
}
