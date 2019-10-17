library date_picker;

import 'dart:ui' as ui;
import 'dart:math';

import 'package:intl/intl.dart' show DateFormat;
import 'package:basic_components/basic_components.dart';
import 'package:basic_components/components/column.dart';
import 'package:basic_components/utilities/string_helper.dart';
import 'package:basic_components/components/row.dart';
import 'package:basic_components/components/visibility.dart';
import 'package:basic_components/components/button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

part "date_picker_controller.dart";

part "calendar_page.dart";

part "calendar_carousel.dart";

part "calendar_day.dart";

part "calendar_month.dart";

part "calendar_year.dart";

typedef String OnDatePicked(List<DateTime> dates);

class AdvDatePicker extends StatefulWidget {
  final Key key;
  final OnDatePicked onDatePicked;
  final String text;
  final List<DateTime> dates;
  final DatePickerController controller;
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
  final int maxLines;
  final int minLines;
  final bool expands;
  final int maxLength;
  final bool maxLengthEnforced;
  final ValueChanged<String> onChanged;
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
    this.text,
    this.dates,
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
  }) : assert(controller == null ||
            (text == null && dates == null && decoration?.errorText == null && enabled == null));

  @override
  _AdvDatePickerState createState() => _AdvDatePickerState();
}

class _AdvDatePickerState extends State<AdvDatePicker> {
  DatePickerController get _effectiveController => widget.controller ?? _ctrl;

  DatePickerController _ctrl;

  @override
  void initState() {
    super.initState();

    _ctrl = widget.controller == null
        ? DatePickerController(
            text: widget.text ?? "",
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
      _ctrl = DatePickerController.fromValue(oldWidget.controller.value);
    else if (widget.controller != null && oldWidget.controller == null) _ctrl = null;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingCtrl =
        new TextEditingController(text: _effectiveController.text);

    textEditingCtrl.addListener(() {
      _effectiveController.removeListener(_update);
      _effectiveController.text = textEditingCtrl.text;
      _effectiveController.addListener(_update);
    });

    InputDecoration decoration = widget.decoration ?? InputDecoration();
    ThemeData themeData = Theme.of(context);
    double fontSize = (widget.style?.fontSize ?? themeData.textTheme.subhead.fontSize);
    double iconSize = fontSize / 14.0 * 20.0;
    double verticalContentPadding = fontSize / 14.0 * 10.0;
    double rightContentPadding = fontSize / 14.0 * 38.0;
    double paddingSize = fontSize / 14.0 * 8.0;
    double edgeMargin = fontSize / 14.0 * 4.0;

    TextField textField = TextField(
      key: widget.key,
      controller: textEditingCtrl,
      focusNode: widget.focusNode,
      decoration: decoration.copyWith(
        errorText: _effectiveController.error,
        contentPadding: EdgeInsets.symmetric(
          vertical: verticalContentPadding,
        ).copyWith(
          right: rightContentPadding,
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
      onChanged: widget.onChanged,
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

    return Stack(
      children: [
        textField,
        Positioned(
          right: edgeMargin,
          top: 0.0,
          bottom: 0.0,
          child: Container(
              width: fontSize + (paddingSize * 2),
              height: fontSize + (paddingSize * 2),
              padding: EdgeInsets.all(paddingSize),
              child: Icon(Icons.calendar_today, size: iconSize)),
        ),
      ],
    );
  }

  void _onTap() {
    if (!_effectiveController.enabled) return;

    pickDate(context,
        title: "widget.controller.label",
        dates: _effectiveController.dates,
        markedDates: [
          MarkedDate(DateTime(2019, 10, 1), "Damn! Damn! Damn!"),
          MarkedDate(DateTime(2019, 10, 2), "Damn! Damn! Damn!"),
          MarkedDate(DateTime(2019, 10, 3), "Damn! Damn! Damn!"),
          MarkedDate(DateTime(2019, 10, 5), "Damn! Damn! Damn!"),
          MarkedDate(DateTime(2019, 10, 6), "Damn! Damn! Damn!"),
          MarkedDate(DateTime(2019, 10, 7), "Damn! Damn! Damn!"),
          MarkedDate(DateTime(2019, 10, 8), "Damn! Damn! Damn!"),
          MarkedDate(DateTime(2019, 10, 13), "Damn! Damn! Damn!"),
          MarkedDate(DateTime(2019, 10, 15), "Damn! Damn! Damn! Damn! Damn! Damn!"),
          MarkedDate(DateTime(2019, 10, 16), "Damn! Damn! Damn!"),
          MarkedDate(DateTime(2019, 10, 17), "Damn! Damn! Damn!"),
          MarkedDate(DateTime(2019, 10, 18), "Damn! Damn! Damn! Damn! Damn! Damn!"),
        ]).then((picked) {});
  }

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
            selectionType: selectionType ?? SelectionType.multi,
            minDate: minDate,
            maxDate: maxDate,
          );
        },
        transitionsBuilder: (context, animation1, animation2, child) {
          return new SlideTransition(
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
