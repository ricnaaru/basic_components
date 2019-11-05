library text_field;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'adv_text_field_controller.dart';

class AdvTextField extends StatefulWidget {
  final Key key;
  final String text;
  final AdvTextFieldController controller;
  final FocusNode focusNode;
  final EdgeInsets margin;
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final String measureText;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final TextDirection textDirection;
  final bool readOnly;
  final ToolbarOptions toolbarOptions;
  final bool showCursor;
  final bool autofocus;
  final bool obscureText;
  final bool autocorrect;
  final int maxLines;
  final int minLines;
  final bool expands;
  final int maxLength;
  final bool maxLengthEnforced;
  final ValueChanged<String> onChanged;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onSubmitted;
  final List<TextInputFormatter> inputFormatters;
  final bool enabled;
  final double cursorWidth;
  final Radius cursorRadius;
  final Color cursorColor;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding;
  final DragStartBehavior dragStartBehavior;
  final bool enableInteractiveSelection;
  final GestureTapCallback onTap;
  final InputCounterWidgetBuilder buildCounter;
  final ScrollController scrollController;
  final ScrollPhysics scrollPhysics;

  AdvTextField({
    this.key,
    this.text,
    this.controller,
    this.focusNode,
    this.decoration,
    this.margin,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.measureText,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    this.toolbarOptions,
    this.showCursor,
    this.autofocus = false,
    this.obscureText,
    this.autocorrect = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforced = true,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = true,
    this.onTap,
    this.buildCounter,
    this.scrollController,
    this.scrollPhysics,
  }) : assert(controller == null ||
            (text == null &&
                decoration?.errorText == null &&
                enabled == null &&
                obscureText == null));

  @override
  _AdvTextFieldState createState() => _AdvTextFieldState();
}

class _AdvTextFieldState extends State<AdvTextField> {
  AdvTextFieldController get _effectiveController => widget.controller ?? _ctrl;
  TextEditingController textEditingCtrl = TextEditingController();
  AdvTextFieldController _ctrl;

  @override
  void initState() {
    super.initState();

    _ctrl = widget.controller == null
        ? AdvTextFieldController(
      text: widget.text ?? "",
      error: widget.decoration?.errorText,
      enabled: widget.enabled ?? true,
      obscureText: widget.obscureText ?? false,
    )
        : null;

    textEditingCtrl.text = _effectiveController.text;

    _effectiveController.addListener(_update);

    textEditingCtrl.addListener(_updateTextEditing);
  }

  _updateTextEditing() {
    _effectiveController.removeListener(_update);
    _effectiveController.text = textEditingCtrl.text;
    _effectiveController.addListener(_update);
  }

  _update() {
    textEditingCtrl.removeListener(_updateTextEditing);
    textEditingCtrl.text = _effectiveController.text;
    textEditingCtrl.addListener(_updateTextEditing);

    if (this.mounted) setState(() {});
  }

  @override
  void didUpdateWidget(AdvTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && oldWidget.controller != null)
      _ctrl = AdvTextFieldController.fromValue(oldWidget.controller.value);
    else if (widget.controller != null && oldWidget.controller == null) _ctrl = null;

    _effectiveController.removeListener(_update);
    textEditingCtrl.removeListener(_updateTextEditing);
    textEditingCtrl.text = _effectiveController.text;
    textEditingCtrl.addListener(_updateTextEditing);
    _effectiveController.addListener(_update);
  }

  @override
  Widget build(BuildContext context) {
    InputDecoration decoration = widget.decoration ?? InputDecoration();
    ThemeData themeData = Theme.of(context);
    double width;
    if (widget.measureText != null) {
      var tp = new TextPainter(
          text: TextSpan(
              text: widget.measureText, style: (widget.style ?? themeData.textTheme.subhead)),
          textDirection: TextDirection.ltr);

      tp.layout();

      width = tp.width;
    }

    return Container(
      width: width,
      margin: widget.margin,
      child: TextField(
        key: widget.key,
        controller: textEditingCtrl,
        focusNode: widget.focusNode,
        decoration: decoration.copyWith(errorText: _effectiveController.error),
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        textCapitalization: widget.textCapitalization,
        style: widget.style,
        strutStyle: widget.strutStyle,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        textDirection: widget.textDirection,
        readOnly: widget.readOnly,
        toolbarOptions: widget.toolbarOptions,
        showCursor: widget.showCursor,
        autofocus: widget.autofocus,
        obscureText: _effectiveController.obscureText,
        autocorrect: widget.autocorrect,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        expands: widget.expands,
        maxLength: widget.maxLength,
        maxLengthEnforced: widget.maxLengthEnforced,
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComplete,
        onSubmitted: widget.onSubmitted,
        inputFormatters: widget.inputFormatters,
        enabled: _effectiveController.enabled,
        cursorWidth: widget.cursorWidth,
        cursorRadius: widget.cursorRadius,
        cursorColor: widget.cursorColor,
        keyboardAppearance: widget.keyboardAppearance,
        scrollPadding: widget.scrollPadding,
        dragStartBehavior: widget.dragStartBehavior,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        onTap: widget.onTap,
        buildCounter: widget.buildCounter,
        scrollController: widget.scrollController,
        scrollPhysics: widget.scrollPhysics,
      ),
    );
  }
}
