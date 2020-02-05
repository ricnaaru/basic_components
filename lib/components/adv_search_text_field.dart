//import 'dart:async';
//
//import 'package:basic_components/components/adv_text_field.dart';
//import 'package:flutter/gestures.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//
//typedef Future<void> SearchCallback(String s);
//
//class AdvSearchTextField extends StatefulWidget {
//  final Key key;
//  final String text;
//  final AdvTextFieldController controller;
//  final FocusNode focusNode;
//  final EdgeInsets margin;
//  final InputDecoration decoration;
//  final TextInputType keyboardType;
//  final TextInputAction textInputAction;
//  final TextCapitalization textCapitalization;
//  final String measureText;
//  final TextStyle style;
//  final StrutStyle strutStyle;
//  final TextAlign textAlign;
//  final TextAlignVertical textAlignVertical;
//  final TextDirection textDirection;
//  final bool readOnly;
//  final ToolbarOptions toolbarOptions;
//  final bool showCursor;
//  final bool autofocus;
//  final bool obscureText;
//  final bool autocorrect;
//  final int maxLines;
//  final int minLines;
//  final bool expands;
//  final int maxLength;
//  final bool maxLengthEnforced;
//  final SearchCallback onChanged;
//  final VoidCallback onEditingComplete;
//  final ValueChanged<String> onSubmitted;
//  final List<TextInputFormatter> inputFormatters;
//  final bool enabled;
//  final double cursorWidth;
//  final Radius cursorRadius;
//  final Color cursorColor;
//  final Brightness keyboardAppearance;
//  final EdgeInsets scrollPadding;
//  final DragStartBehavior dragStartBehavior;
//  final bool enableInteractiveSelection;
//  final GestureTapCallback onTap;
//  final InputCounterWidgetBuilder buildCounter;
//  final ScrollController scrollController;
//  final ScrollPhysics scrollPhysics;
//
//  AdvSearchTextField({
//    this.key,
//    this.text,
//    this.controller,
//    this.focusNode,
//    this.decoration,
//    this.margin,
//    this.keyboardType,
//    this.textInputAction,
//    this.textCapitalization = TextCapitalization.none,
//    this.measureText,
//    this.style,
//    this.strutStyle,
//    this.textAlign = TextAlign.start,
//    this.textAlignVertical,
//    this.textDirection,
//    this.readOnly = false,
//    this.toolbarOptions,
//    this.showCursor,
//    this.autofocus = false,
//    this.obscureText,
//    this.autocorrect = true,
//    this.maxLines = 1,
//    this.minLines,
//    this.expands = false,
//    this.maxLength,
//    this.maxLengthEnforced = true,
//    this.onChanged,
//    this.onEditingComplete,
//    this.onSubmitted,
//    this.inputFormatters,
//    this.enabled,
//    this.cursorWidth = 2.0,
//    this.cursorRadius,
//    this.cursorColor,
//    this.keyboardAppearance,
//    this.scrollPadding = const EdgeInsets.all(20.0),
//    this.dragStartBehavior = DragStartBehavior.start,
//    this.enableInteractiveSelection = true,
//    this.onTap,
//    this.buildCounter,
//    this.scrollController,
//    this.scrollPhysics,
//  }) : assert(controller == null ||
//      (text == null &&
//          decoration?.errorText == null &&
//          enabled == null &&
//          obscureText == null &&
//          decoration?.prefixIcon == null &&
//          decoration?.suffixIcon == null));
//
//  @override
//  State<StatefulWidget> createState() => _BorderedTextField();
//}
//
//class _BorderedTextField extends State<AdvSearchTextField>
//    with TickerProviderStateMixin {
//  AnimationController loadingController;
//  Timer _timer;
//
//  @override
//  void initState() {
//    super.initState();
//    loadingController =
//        AnimationController(duration: kTabScrollDuration, vsync: this);
//  }
//
//  @override
//  void dispose() {
//    _timer?.cancel();
//    _timer = null;
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    double radius = 8.0;
//
//    InputDecoration decoration = InputDecoration(
//      icon: widget.decoration?.icon,
//      labelText: widget.decoration?.labelText,
//      labelStyle: widget.decoration?.labelStyle,
//      helperText: widget.decoration?.helperText,
//      helperStyle: widget.decoration?.helperStyle,
//      hintText: widget.decoration?.hintText,
//      hintStyle: widget.decoration?.hintStyle,
//      hintMaxLines: widget.decoration?.hintMaxLines,
//      errorText: widget.decoration?.errorText,
//      errorStyle: widget.decoration?.errorStyle,
//      errorMaxLines: widget.decoration?.errorMaxLines,
//      hasFloatingPlaceholder: widget.decoration?.hasFloatingPlaceholder,
//      isDense: widget.decoration?.isDense,
//      contentPadding: widget.decoration?.contentPadding ??
//          EdgeInsets.symmetric(vertical: 16.0).copyWith(
//              left: (widget.decoration?.prefixIcon ??
//                  widget.controller?.prefixIcon) !=
//                  null
//                  ? 0.0
//                  : 16.0,
//              right: (widget.decoration?.suffixIcon ??
//                  widget.controller?.suffixIcon) !=
//                  null
//                  ? 0.0
//                  : 16.0),
//      prefixIcon: null,
//      prefix: widget.decoration?.prefix,
//      prefixText: widget.decoration?.prefixText,
//      prefixStyle: widget.decoration?.prefixStyle,
//      suffixIcon: null,
//      suffix: widget.decoration?.suffix,
//      suffixText: widget.decoration?.suffixText,
//      suffixStyle: widget.decoration?.suffixStyle,
//      counter: widget.decoration?.counter,
//      counterText: widget.decoration?.counterText,
//      counterStyle: widget.decoration?.counterStyle,
//      filled: widget.decoration?.filled ?? true,
//      fillColor: widget.decoration?.fillColor ?? Colors.white,
//      focusColor: widget.decoration?.focusColor,
//      hoverColor: widget.decoration?.hoverColor,
//      enabled: widget.decoration?.enabled ?? true,
//      semanticCounterText: widget.decoration?.semanticCounterText,
//      alignLabelWithHint: widget.decoration?.alignLabelWithHint,
//      enabledBorder: OutlineInputBorder(
//          borderRadius: BorderRadius.circular(radius),
//          borderSide: BorderSide(color: textFieldBorderColor)),
//      focusedBorder: OutlineInputBorder(
//          borderRadius: BorderRadius.circular(radius),
//          borderSide: BorderSide(color: textFieldBorderColor)),
//      focusedErrorBorder: OutlineInputBorder(
//          borderRadius: BorderRadius.circular(radius),
//          borderSide: BorderSide(color: systemRedColor)),
//      errorBorder: OutlineInputBorder(
//          borderRadius: BorderRadius.circular(radius),
//          borderSide: BorderSide(color: systemRedColor)),
//      disabledBorder: OutlineInputBorder(
//          borderRadius: BorderRadius.circular(radius),
//          borderSide: BorderSide(color: textFieldBorderColor)),
//      border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
//    );
//    if (widget.controller != null) {
//      widget.controller.prefixIcon = AnimatedBuilder(
//        animation: loadingController,
//        builder: (BuildContext context, Widget child) {
//          return Container(
//            width: 50,
//            height: 50,
//            margin: EdgeInsets.all(4.0),
//            child: Stack(children: [
//              Opacity(
//                opacity: loadingController.value,
//                child: Center(
//                  child: Container(
//                    width: 30),
//                    height: 30),
//                    child: CircularProgressIndicator(
//                      strokeWidth: 2.0,
//                      valueColor: ColorTween(
//                          begin: Colors.black, end: systemAccentColor)
//                          .animate(loadingController),
//                    ),
//                  ),
//                ),
//              ),
//              Opacity(
//                opacity: 1.0 - loadingController.value,
//                child: Center(
//                  child: Icon(Icons.search),
//                ),
//              ),
//            ]),
//          );
//        },
//      );
//    }
//    return AdvTextField(
//      key: widget.key,
//      measureText: widget.measureText,
//      controller: widget.controller,
//      focusNode: widget.focusNode,
//      decoration: decoration,
//      keyboardType: widget.keyboardType,
//      textInputAction: widget.textInputAction,
//      textCapitalization: widget.textCapitalization,
//      style: widget.style,
//      strutStyle: widget.strutStyle,
//      textAlign: widget.textAlign,
//      textAlignVertical: widget.textAlignVertical,
//      textDirection: widget.textDirection,
//      readOnly: widget.readOnly,
//      toolbarOptions: widget.toolbarOptions,
//      showCursor: widget.showCursor,
//      autofocus: widget.autofocus,
//      obscureText: widget.obscureText,
//      autocorrect: widget.autocorrect,
//      maxLines: widget.maxLines,
//      minLines: widget.minLines,
//      expands: widget.expands,
//      maxLength: widget.maxLength,
//      maxLengthEnforced: widget.maxLengthEnforced,
//      onChanged: (s) {
//        if (_timer?.isActive ?? false) _timer.cancel();
//
//        _timer = Timer(const Duration(milliseconds: 800), () {
//          _timer = null;
//          if (widget.controller != null) widget.controller.enabled = false;
//          if (loadingController.value < 1.0) {
//            loadingController.animateTo(1.0);
//          }
//          if (widget.onChanged != null) {
//            widget.onChanged(s).then((_) {
//              if (widget.controller != null) widget.controller.enabled = true;
//              loadingController.reverse();
//            });
//          } else {
//            if (widget.controller != null) widget.controller.enabled = true;
//            loadingController.reverse();
//          }
//        });
//      },
//      onEditingComplete: widget.onEditingComplete,
//      onSubmitted: widget.onSubmitted,
//      inputFormatters: widget.inputFormatters,
//      enabled: widget.enabled,
//      cursorWidth: widget.cursorWidth,
//      cursorRadius: widget.cursorRadius,
//      cursorColor: widget.cursorColor,
//      keyboardAppearance: widget.keyboardAppearance,
//      scrollPadding: widget.scrollPadding,
//      dragStartBehavior: widget.dragStartBehavior,
//      enableInteractiveSelection: widget.enableInteractiveSelection,
//      onTap: widget.onTap,
//      buildCounter: widget.buildCounter,
//      scrollController: widget.scrollController,
//      scrollPhysics: widget.scrollPhysics,
//    );
//  }
//}
