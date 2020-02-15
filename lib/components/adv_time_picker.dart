library adv_time_picker;

import 'package:basic_components/components/basic/time_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

part 'adv_time_picker_controller.dart';

typedef String OnTimePicked(DateTime time);

class AdvTimePicker extends StatefulWidget {
  final Key key;
  final OnTimePicked onTimePicked;
  final DateTime time;
  final DateTime minTime;
  final DateTime maxTime;
  final String timeFormat;
  final AdvTimePickerController controller;
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
  final int maxLines;
  final int minLines;
  final bool expands;
  final int maxLength;
  final bool maxLengthEnforced;
  final bool enabled;
  final double cursorWidth;
  final Radius cursorRadius;
  final Color cursorColor;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding;
  final DragStartBehavior dragStartBehavior;
  final bool enableInteractiveSelection;
  final InputCounterWidgetBuilder buildCounter;
  final ScrollController scrollController;
  final ScrollPhysics scrollPhysics;

  AdvTimePicker({
    this.key,
    this.onTimePicked,
    this.time,
    this.minTime,
    this.maxTime,
    String timeFormat,
    this.controller,
    this.focusNode,
    this.decoration,
    this.margin,
    this.measureText,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.toolbarOptions,
    this.showCursor,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforced = true,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = true,
    this.buildCounter,
    this.scrollController,
    this.scrollPhysics,
  })  : assert(controller == null ||
            (time == null &&
                minTime == null &&
                maxTime == null &&
                decoration?.errorText == null &&
                enabled == null)),
        assert((minTime != null &&
                maxTime != null &&
                minTime.compareTo(maxTime) <= 0) ||
            !(minTime != null && maxTime != null)),
        this.timeFormat = timeFormat ?? "hh:mm a";

  @override
  _AdvTimePickerState createState() => _AdvTimePickerState();

  static Future<DateTime> pickTime(
    BuildContext context, {
    String title,
    DateTime time,
    DateTime minDate,
    DateTime maxDate,
  }) async {
    print("time => $time");
    DateTime result = await TimePicker.pickTime(context,
        time: time,
        displayType: DisplayType.bottomSheet,
        timePickType: TimePickType.hourMinute,
        title: title,
        fontSize: 24.0,
        isTwelveHourFormat: true);

    return result;
  }
}

class _AdvTimePickerState extends State<AdvTimePicker> {
  AdvTimePickerController get _effectiveController =>
      widget.controller ?? _ctrl;

  AdvTimePickerController _ctrl;

  @override
  void initState() {
    super.initState();

    _ctrl = widget.controller == null
        ? AdvTimePickerController(
            time: widget.time,
            minTime: widget.minTime,
            maxTime: widget.maxTime,
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
  void didUpdateWidget(AdvTimePicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller == null && oldWidget.controller != null)
      _ctrl = AdvTimePickerController.fromValue(oldWidget.controller.value);
    else if (widget.controller != null && oldWidget.controller == null)
      _ctrl = null;
  }

  @override
  Widget build(BuildContext context) {
    DateFormat df = DateFormat(widget.timeFormat);
    TextEditingController textEditingCtrl = new TextEditingController(
        text: _effectiveController.time == null
            ? ""
            : df.format(_effectiveController.time));

    InputDecoration decoration = widget.decoration ?? InputDecoration();
    ThemeData themeData = Theme.of(context);
    double fontSize =
        (widget.style?.fontSize ?? themeData.textTheme.subhead.fontSize);

    double iconSize = fontSize / 14.0 * 16.0;
    double verticalContentPadding = fontSize / 14.0 * 10.0;
    double leftContentPadding = fontSize / 14.0 * 8.0;
    double rightContentPadding = fontSize / 14.0 * 32.0;
    double paddingSize = fontSize / 14.0 * 8.0;
    double edgeMargin = fontSize / 14.0 * 4.0;

    EdgeInsets definedPadding = decoration.contentPadding;

    TextField textField = TextField(
      key: widget.key,
      controller: textEditingCtrl,
      focusNode: widget.focusNode,
      decoration: decoration.copyWith(
        errorText: _effectiveController.error,
        contentPadding: EdgeInsets.symmetric(
          vertical: verticalContentPadding + (definedPadding?.vertical ?? 0),
        ).copyWith(
          right: rightContentPadding + (definedPadding?.right ?? 0),
          left: leftContentPadding + (definedPadding?.left ?? 0),
        ),
      ),
      style: widget.style,
      strutStyle: StrutStyle(height: 1.4),
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textDirection: widget.textDirection,
      readOnly: true,
      toolbarOptions: widget.toolbarOptions,
      showCursor: widget.showCursor,
      autofocus: widget.autofocus,
      obscureText: _effectiveController.obscureText,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands,
      maxLength: widget.maxLength,
      maxLengthEnforced: widget.maxLengthEnforced,
      onChanged: null,
      enabled: _effectiveController.enabled,
      cursorWidth: widget.cursorWidth,
      cursorRadius: widget.cursorRadius,
      cursorColor: widget.cursorColor,
      keyboardAppearance: widget.keyboardAppearance,
      scrollPadding: widget.scrollPadding,
      dragStartBehavior: widget.dragStartBehavior,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      onTap: _onTap,
      buildCounter: widget.buildCounter,
      scrollController: widget.scrollController,
      scrollPhysics: widget.scrollPhysics,
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
          (fontSize + (paddingSize * 2)) +
          (edgeMargin) +
          leftContentPadding +
          (definedPadding?.horizontal ??
              0); //rightContentPadding sudah diwakilkan oleh (fontSize + (paddingSize * 2))
    }

    return Container(
      width: width,
      margin: widget.margin,
      child: Stack(
        children: [
          textField,
          Positioned(
            right: edgeMargin + (definedPadding?.right ?? 0),
            top: 8.0, // supaya kalo ada error, iconnya gk ke bawah
            child: IgnorePointer(
              child: Container(
                  width: fontSize + (paddingSize * 2),
                  height: fontSize + (paddingSize * 2),
                  padding: EdgeInsets.all(paddingSize),
                  child: Icon(Icons.alarm, size: iconSize)),
            ),
          ),
        ],
      ),
    );
  }

  void _onTap() async {
    if (!_effectiveController.enabled) return;

    DateTime time = await AdvTimePicker.pickTime(
      context,
      time: _effectiveController.time,
      title: widget.decoration?.labelText ?? "Pick Date",
      minDate: _effectiveController.minTime,
      maxDate: _effectiveController.maxTime,
    );

    if (time == null) return;

    _effectiveController.time = time;

    _effectiveController.error = null;

    if (widget.onTimePicked != null) widget.onTimePicked(time);
  }
}
