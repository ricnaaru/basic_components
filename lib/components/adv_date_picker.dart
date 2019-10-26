library date_picker;

import 'dart:ui' as ui;
import 'dart:math';

import 'package:intl/intl.dart' show DateFormat;
import 'package:basic_components/basic_components.dart';
import 'package:basic_components/components/adv_column.dart';
import 'package:basic_components/utilities/string_helper.dart';
import 'package:basic_components/components/adv_row.dart';
import 'package:basic_components/components/adv_visibility.dart';
import 'package:basic_components/components/adv_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

part "adv_date_picker_controller.dart";

part "calendar_page.dart";

part "calendar_carousel.dart";

part "calendar_day.dart";

part "calendar_month.dart";

part "calendar_year.dart";

typedef String OnDatePicked(List<DateTime> dates);

class AdvDatePicker extends StatefulWidget {
  final Key key;
  final OnDatePicked onDatePicked;
  final DateTime date;
  final DateTime minDate;
  final DateTime maxDate;
  final List<MarkedDate> markedDates;
  final SelectionType selectionType;
  final String dateFormat;
  final List<DateTime> dates;
  final AdvDatePickerController controller;
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
  final ValueChanged<List<DateTime>> onChanged;
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

  AdvDatePicker({
    this.key,
    this.onDatePicked,
    this.date,
    this.minDate,
    this.maxDate,
    this.markedDates,
    this.selectionType,
    String dateFormat,
    this.dates,
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
    this.onChanged,
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
            (date == null &&
                minDate == null &&
                maxDate == null &&
                dates == null &&
                decoration?.errorText == null &&
                enabled == null)),
        assert((minDate != null && maxDate != null && minDate.compareTo(maxDate) <= 0) ||
            !(minDate != null && maxDate != null)),
        this.dateFormat = dateFormat ?? BasicComponents.datePicker.dateFormat;

  @override
  _AdvDatePickerState createState() => _AdvDatePickerState();

  static Future<List<DateTime>> pickDate(
    BuildContext context, {
    String title,
    List<DateTime> dates,
    List<MarkedDate> markedDates,
    SelectionType selectionType,
    DateTime minDate,
    DateTime maxDate,
  }) async {
    List<DateTime> result = await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) {
          return CalendarPage(
            title: title,
            currentDate: dates ?? const [],
            markedDates: markedDates ?? const [],
            selectionType: selectionType ?? SelectionType.single,
            minDate: minDate,
            maxDate: maxDate,
          );
        },
        transitionsBuilder: (context, animation1, animation2, child) {
          return SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation1),
            child: child,
          );
        },
        settings: RouteSettings(name: "ComDatePickerPage"),
      ),
    );

    return result;
  }
}

class _AdvDatePickerState extends State<AdvDatePicker> {
  AdvDatePickerController get _effectiveController => widget.controller ?? _ctrl;

  AdvDatePickerController _ctrl;

  @override
  void initState() {
    super.initState();

    _ctrl = widget.controller == null
        ? AdvDatePickerController(
            date: widget.date,
            minDate: widget.minDate,
            maxDate: widget.maxDate,
            dates: widget.dates,
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
  void didUpdateWidget(AdvDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && oldWidget.controller != null)
      _ctrl = AdvDatePickerController.fromValue(oldWidget.controller.value);
    else if (widget.controller != null && oldWidget.controller == null) _ctrl = null;
  }

  @override
  Widget build(BuildContext context) {
    DateFormat df = DateFormat(widget.dateFormat);
    TextEditingController textEditingCtrl = new TextEditingController(
        text: _effectiveController.date == null ? "" : df.format(_effectiveController.date));

    InputDecoration decoration = widget.decoration ?? InputDecoration();
    ThemeData themeData = Theme.of(context);
    double fontSize = (widget.style?.fontSize ?? themeData.textTheme.subhead.fontSize);
    double iconSize = fontSize / 14.0 * 20.0;
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
      strutStyle: widget.strutStyle,
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
              text: widget.measureText, style: (widget.style ?? themeData.textTheme.subhead)),
          textDirection: TextDirection.ltr);

      tp.layout();

      width = tp.width +
          (fontSize + (paddingSize * 2)) +
          (edgeMargin) +
          leftContentPadding; //rightContentPadding sudah diwakilkan oleh (fontSize + (paddingSize * 2))
    }

    return Container(
      width: width,
      margin: widget.margin,
      child: Stack(
        children: [
          textField,
          Positioned(
            right: edgeMargin + (definedPadding?.right ?? 0),
            top: 0.0,
            bottom: 0.0,
            child: IgnorePointer(
              child: Container(
                  width: fontSize + (paddingSize * 2),
                  height: fontSize + (paddingSize * 2),
                  padding: EdgeInsets.all(paddingSize),
                  child: Icon(Icons.calendar_today, size: iconSize)),
            ),
          ),
        ],
      ),
    );
  }

  void _onTap() async {
    if (!_effectiveController.enabled) return;

    List<DateTime> dates = await AdvDatePicker.pickDate(
      context,
      title: widget.decoration?.labelText ?? "Pick Date",
      dates: _effectiveController.dates,
      selectionType: widget.selectionType,
      minDate: _effectiveController.minDate,
      maxDate: _effectiveController.maxDate,
      markedDates: widget.markedDates,
    );

    if (dates == null) return;

    _effectiveController.dates = dates;
    _effectiveController.date = dates.first;

    if (widget.onChanged != null) widget.onChanged(dates);
  }
}
