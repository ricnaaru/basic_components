import 'package:flutter/material.dart';

@immutable
class ComponentThemeData {
  const ComponentThemeData({
    ChooserTheme chooser,
    GroupCheckTheme groupCheck,
    GroupRadioTheme groupRadio,
    DatePickerTheme datePicker,
    TimePickerTheme timePicker,
    ButtonTheme button,
    LoadingTheme loading,
  })  : this.chooser = chooser ?? const ChooserTheme(),
        this.groupCheck = groupCheck ?? const GroupCheckTheme(),
        this.groupRadio = groupRadio ?? const GroupRadioTheme(),
        this.datePicker = datePicker ?? const DatePickerTheme(),
        this.timePicker = timePicker ?? const TimePickerTheme(),
        this.button = button ?? const ButtonTheme(),
        this.loading = loading ?? const LoadingTheme();

  final ChooserTheme chooser;
  final GroupCheckTheme groupCheck;
  final GroupRadioTheme groupRadio;
  final DatePickerTheme datePicker;
  final TimePickerTheme timePicker;
  final ButtonTheme button;
  final LoadingTheme loading;

  ComponentThemeData copyWith({
    Color chooserIconColor,
    Color groupCheckCheckColor,
    Color groupRadioCheckColor,
    String datePickerDateFormat,
    TextStyle datePickerDaysLabelTextStyle,
    TextStyle datePickerTodayTextStyle,
    Color datePickerTodayColor,
    Color datePickerSelectedColor,
    TextStyle datePickerSelectedDayTextStyle,
    Color datePickerIconColor,
    IconData datePickerIconPrevious,
    IconData datePickerIconNext,
    TextStyle datePickerWeekendTextStyle,
    TextStyle datePickerWeekdayTextStyle,
    Color datePickerToolbarColor,
    TextStyle datePickerHeaderTextStyle,
    Color datePickerPrevDaysColor,
    Color datePickerNextDaysColor,
    TextStyle datePickerMarkedDaysTextStyle,
    Color datePickerBackgroundColor,
    Color datePickerBorderColor,
    Color datePickerHintColor,
    Color datePickerLabelColor,
    Color datePickerErrorColor,
    List<String> datePickerWeekdaysArray,
    List<String> datePickerMonthsArray,
    String datePickerMarkedDatesTitle,
    double datePickerViewportFraction,
    Color datePickerPrevMonthDayBorderColor,
    Color datePickerThisMonthDayBorderColor,
    Color datePickerNextMonthDayBorderColor,
    double datePickerDayPadding,
    Color datePickerDayButtonColor,
    bool datePickerDaysHaveCircularBorder,
    EdgeInsets datePickerHeaderMargin,
    double datePickerChildAspectRatio,
    EdgeInsets datePickerWeekDayMargin,
    Color timePickerSelectedColor,
    Color timePickerNonSelectedColor,
    double timePickerFontSize,
    TextStyle timePickerButtonTextStyle,
    TextStyle timePickerTitleTextStyle,
    Color timePickerButtonColor,
    Color timePickerMeridiemButtonColor,
    TextStyle timePickerMeridiemTextStyle,
    IconData timePickerIcon,
    Color buttonTextColor,
    Color buttonBackgroundColor,
    String loadingAssetName,
    Color loadingBarrierColor,
    double loadingWidth,
    double loadingHeight,
  }) {
    return ComponentThemeData(
      chooser: chooser.copyWith(iconColor: chooserIconColor),
      groupCheck: groupCheck.copyWith(checkColor: groupCheckCheckColor),
      groupRadio: groupRadio.copyWith(checkColor: groupRadioCheckColor),
      datePicker: datePicker.copyWith(
        dateFormat: datePickerDateFormat,
        daysLabelTextStyle: datePickerDaysLabelTextStyle,
        todayTextStyle: datePickerTodayTextStyle,
        todayColor: datePickerTodayColor,
        selectedColor: datePickerSelectedColor,
        selectedDayTextStyle: datePickerSelectedDayTextStyle,
        iconColor: datePickerIconColor,
        iconPrevious: datePickerIconPrevious,
        iconNext: datePickerIconNext,
        weekendTextStyle: datePickerWeekendTextStyle,
        weekdayTextStyle: datePickerWeekdayTextStyle,
        toolbarColor: datePickerToolbarColor,
        headerTextStyle: datePickerHeaderTextStyle,
        prevDaysColor: datePickerPrevDaysColor,
        nextDaysColor: datePickerNextDaysColor,
        markedDaysTextStyle: datePickerMarkedDaysTextStyle,
        backgroundColor: datePickerBackgroundColor,
        borderColor: datePickerBorderColor,
        hintColor: datePickerHintColor,
        labelColor: datePickerLabelColor,
        errorColor: datePickerErrorColor,
        weekdaysArray: datePickerWeekdaysArray,
        monthsArray: datePickerMonthsArray,
        markedDatesTitle: datePickerMarkedDatesTitle,
        viewportFraction: datePickerViewportFraction,
        prevMonthDayBorderColor: datePickerPrevMonthDayBorderColor,
        thisMonthDayBorderColor: datePickerThisMonthDayBorderColor,
        nextMonthDayBorderColor: datePickerNextMonthDayBorderColor,
        dayPadding: datePickerDayPadding,
        dayButtonColor: datePickerDayButtonColor,
        daysHaveCircularBorder: datePickerDaysHaveCircularBorder,
        headerMargin: datePickerHeaderMargin,
        childAspectRatio: datePickerChildAspectRatio,
        weekDayMargin: datePickerWeekDayMargin,
      ),
      timePicker: timePicker.copyWith(
        selectedColor: timePickerSelectedColor,
        nonSelectedColor: timePickerNonSelectedColor,
        fontSize: timePickerFontSize,
        buttonTextStyle: timePickerButtonTextStyle,
        titleTextStyle: timePickerTitleTextStyle,
        buttonColor: timePickerButtonColor,
        meridiemButtonColor: timePickerMeridiemButtonColor,
        meridiemTextStyle: timePickerMeridiemTextStyle,
        icon: timePickerIcon,
      ),
      button: button.copyWith(
        textColor: buttonTextColor,
        backgroundColor: buttonBackgroundColor,
      ),
      loading: loading.copyWith(
        assetName: loadingAssetName,
        barrierColor: loadingBarrierColor,
        width: loadingWidth,
        height: loadingHeight,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    final ComponentThemeData otherData = other;
    return (otherData.chooser == chooser) &&
        (otherData.groupCheck == groupCheck) &&
        (otherData.groupRadio == groupRadio) &&
        (otherData.datePicker == datePicker) &&
        (otherData.button == button) &&
        (otherData.loading == loading);
  }

  @override
  int get hashCode {
    final List<Object> values = <Object>[
      chooser.hashCode,
      groupCheck.hashCode,
      groupRadio.hashCode,
      datePicker.hashCode,
      button.hashCode,
      loading.hashCode,
    ];
    return hashList(values);
  }
}

class ChooserTheme {
  final Color iconColor;

  const ChooserTheme({Color iconColor})
      : this.iconColor = iconColor ?? Colors.black;

  ChooserTheme copyWith({
    Color iconColor,
  }) {
    return ChooserTheme(
      iconColor: iconColor ?? this.iconColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    final ChooserTheme otherData = other;
    return (otherData.iconColor == iconColor);
  }

  @override
  int get hashCode => iconColor.hashCode;
}

class GroupCheckTheme {
  final Color checkColor;

  const GroupCheckTheme({Color checkColor})
      : this.checkColor = checkColor ?? Colors.blue;

  GroupCheckTheme copyWith({
    Color checkColor,
  }) {
    return GroupCheckTheme(
      checkColor: checkColor ?? this.checkColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    final GroupCheckTheme otherData = other;
    return (otherData.checkColor == checkColor);
  }

  @override
  int get hashCode => checkColor.hashCode;
}

class GroupRadioTheme {
  final Color checkColor;

  const GroupRadioTheme({Color checkColor})
      : this.checkColor = checkColor ?? Colors.blue;

  GroupRadioTheme copyWith({
    Color checkColor,
  }) {
    return GroupRadioTheme(
      checkColor: checkColor ?? this.checkColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    final GroupRadioTheme otherData = other;
    return (otherData.checkColor == checkColor);
  }

  @override
  int get hashCode => checkColor.hashCode;
}

class DatePickerTheme {
  final String dateFormat;
  final Color todayColor;
  final Color selectedColor;
  final Color iconColor;
  final IconData iconPrevious;
  final IconData iconNext;
  final Color toolbarColor;
  final Color prevDaysColor;
  final Color nextDaysColor;
  final Color backgroundColor;
  final Color borderColor;
  final Color hintColor;
  final Color labelColor;
  final Color errorColor;
  final List<String> weekdaysArray;
  final List<String> monthsArray;
  final String markedDatesTitle;
  final TextStyle headerTextStyle;
  final TextStyle weekdayTextStyle;
  final TextStyle todayTextStyle;
  final TextStyle selectedDayTextStyle;
  final TextStyle daysLabelTextStyle;
  final TextStyle markedDaysTextStyle;
  final TextStyle weekendTextStyle;
  final Widget markedDateWidget;
  final double viewportFraction;
  final Color prevMonthDayBorderColor;
  final Color thisMonthDayBorderColor;
  final Color nextMonthDayBorderColor;
  final double dayPadding;
  final Color dayButtonColor;
  final bool daysHaveCircularBorder;
  final EdgeInsets headerMargin;
  final double childAspectRatio;
  final EdgeInsets weekDayMargin;

  const DatePickerTheme({
    String dateFormat,
    Color todayColor,
    Color selectedColor,
    Color iconColor,
    IconData iconPrevious,
    IconData iconNext,
    Color toolbarColor,
    Color prevDaysColor,
    Color nextDaysColor,
    Color backgroundColor,
    Color borderColor,
    Color hintColor,
    Color labelColor,
    Color errorColor,
    List<String> weekdaysArray,
    List<String> monthsArray,
    String markedDatesTitle,
    TextStyle headerTextStyle,
    TextStyle weekdayTextStyle,
    TextStyle todayTextStyle,
    TextStyle selectedDayTextStyle,
    TextStyle daysLabelTextStyle,
    TextStyle markedDaysTextStyle,
    TextStyle weekendTextStyle,
    Widget markedDateWidget,
    double viewportFraction,
    Color prevMonthDayBorderColor,
    Color thisMonthDayBorderColor,
    Color nextMonthDayBorderColor,
    double dayPadding,
    Color dayButtonColor,
    bool daysHaveCircularBorder,
    EdgeInsets headerMargin,
    double childAspectRatio,
    EdgeInsets weekDayMargin,
  })  : this.dateFormat = dateFormat ?? "dd-MM-yyyy",
        this.daysLabelTextStyle =
            daysLabelTextStyle ?? const TextStyle(color: Color(0xff208e5d)),
        this.todayTextStyle =
            todayTextStyle ?? const TextStyle(color: Color(0xffffffff)),
        this.todayColor = todayColor ?? const Color(0xffff6378),
        this.selectedColor = selectedColor ?? const Color(0xff9bf0ff),
        this.selectedDayTextStyle =
            selectedDayTextStyle ?? const TextStyle(color: Color(0xffffffff)),
        this.iconColor = iconColor ?? Colors.blueAccent,
        this.iconPrevious = iconPrevious ?? Icons.keyboard_arrow_left,
        this.iconNext = iconNext ?? Icons.keyboard_arrow_right,
        this.weekendTextStyle =
            weekendTextStyle ?? const TextStyle(color: Color(0xffff235e)),
        this.weekdayTextStyle =
            weekdayTextStyle ?? const TextStyle(color: Color(0xff44363a)),
        this.toolbarColor = toolbarColor ?? const Color(0xfff4329a),
        this.headerTextStyle = headerTextStyle ??
            const TextStyle(fontSize: 20, color: Color(0xfff4329a)),
        this.prevDaysColor = prevDaysColor ?? const Color(0xffa6a6a6),
        this.nextDaysColor = nextDaysColor ?? const Color(0xffa6a6a6),
        this.markedDaysTextStyle =
            markedDaysTextStyle ?? const TextStyle(color: Colors.blue),
        this.markedDateWidget = markedDateWidget ??
            const Positioned(
              child: SizedBox(
                height: 4.0,
                width: 4.0,
                child: Material(
                  color: Colors.blue,
                ),
              ),
              bottom: 4.0,
              left: 18.0,
            ),
        this.backgroundColor = backgroundColor ?? const Color(0xffffffff),
        this.borderColor = borderColor ?? const Color(0xffa6a6a6),
        this.hintColor = hintColor ?? const Color(0xffa6a6a6),
        this.labelColor = labelColor ?? const Color(0xff777777),
        this.errorColor = errorColor ?? const Color(0xffd81920),
        this.weekdaysArray = weekdaysArray ??
            const ['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'],
        this.monthsArray = monthsArray ??
            const [
              'Jan',
              'Feb',
              'Mar',
              'Apr',
              'May',
              'Jun',
              'Jul',
              'Aug',
              'Sep',
              'Oct',
              'Nov',
              'Dec'
            ],
        this.markedDatesTitle = markedDatesTitle ?? "Marked date",
        this.viewportFraction = viewportFraction ?? 1.0,
        this.prevMonthDayBorderColor =
            prevMonthDayBorderColor ?? Colors.transparent,
        this.thisMonthDayBorderColor =
            thisMonthDayBorderColor ?? Colors.transparent,
        this.nextMonthDayBorderColor =
            nextMonthDayBorderColor ?? Colors.transparent,
        this.dayPadding = dayPadding ?? 2.0,
        this.dayButtonColor = dayButtonColor ?? Colors.transparent,
        this.daysHaveCircularBorder = daysHaveCircularBorder ?? true,
        this.headerMargin =
            headerMargin ?? const EdgeInsets.symmetric(vertical: 16.0),
        this.childAspectRatio = childAspectRatio ?? 1.0,
        this.weekDayMargin =
            weekDayMargin ?? const EdgeInsets.only(bottom: 4.0);

  DatePickerTheme copyWith({
    String dateFormat,
    TextStyle daysLabelTextStyle,
    Color todayColor,
    Color selectedColor,
    TextStyle selectedDayTextStyle,
    Color iconColor,
    IconData iconPrevious,
    IconData iconNext,
    TextStyle weekendTextStyle,
    TextStyle weekdayTextStyle,
    TextStyle todayTextStyle,
    Color toolbarColor,
    TextStyle headerTextStyle,
    Color prevDaysColor,
    Color nextDaysColor,
    TextStyle markedDaysTextStyle,
    Color backgroundColor,
    Color borderColor,
    Color hintColor,
    Color labelColor,
    Color errorColor,
    List<String> weekdaysArray,
    List<String> monthsArray,
    String markedDatesTitle,
    Widget markedDateWidget,
    double viewportFraction,
    Color prevMonthDayBorderColor,
    Color thisMonthDayBorderColor,
    Color nextMonthDayBorderColor,
    double dayPadding,
    Color dayButtonColor,
    bool daysHaveCircularBorder,
    EdgeInsets headerMargin,
    double childAspectRatio,
    EdgeInsets weekDayMargin,
  }) {
    return DatePickerTheme(
      dateFormat: dateFormat ?? this.dateFormat,
      daysLabelTextStyle: daysLabelTextStyle ?? this.daysLabelTextStyle,
      todayTextStyle: todayTextStyle ?? this.todayTextStyle,
      todayColor: todayColor ?? this.todayColor,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedDayTextStyle: selectedDayTextStyle ?? this.selectedDayTextStyle,
      iconColor: iconColor ?? this.iconColor,
      iconPrevious: iconPrevious ?? this.iconPrevious,
      iconNext: iconNext ?? this.iconNext,
      weekendTextStyle: weekendTextStyle ?? this.weekendTextStyle,
      weekdayTextStyle: weekdayTextStyle ?? this.weekdayTextStyle,
      toolbarColor: toolbarColor ?? this.toolbarColor,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
      prevDaysColor: prevDaysColor ?? this.prevDaysColor,
      nextDaysColor: nextDaysColor ?? this.nextDaysColor,
      markedDaysTextStyle: markedDaysTextStyle ?? this.markedDaysTextStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      hintColor: hintColor ?? this.hintColor,
      labelColor: labelColor ?? this.labelColor,
      errorColor: errorColor ?? this.errorColor,
      weekdaysArray: weekdaysArray ?? this.weekdaysArray,
      monthsArray: monthsArray ?? this.monthsArray,
      markedDatesTitle: markedDatesTitle ?? this.markedDatesTitle,
      markedDateWidget: markedDateWidget ?? this.markedDateWidget,
      viewportFraction: viewportFraction ?? this.viewportFraction,
      prevMonthDayBorderColor:
          prevMonthDayBorderColor ?? this.prevMonthDayBorderColor,
      thisMonthDayBorderColor:
          thisMonthDayBorderColor ?? this.thisMonthDayBorderColor,
      nextMonthDayBorderColor:
          nextMonthDayBorderColor ?? this.nextMonthDayBorderColor,
      dayPadding: dayPadding ?? this.dayPadding,
      dayButtonColor: dayButtonColor ?? this.dayButtonColor,
      daysHaveCircularBorder:
          daysHaveCircularBorder ?? this.daysHaveCircularBorder,
      headerMargin: headerMargin ?? this.headerMargin,
      childAspectRatio: childAspectRatio ?? this.childAspectRatio,
      weekDayMargin: weekDayMargin ?? this.weekDayMargin,
    );
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    final DatePickerTheme otherData = other;
    return (otherData.dateFormat == dateFormat) &&
        (otherData.daysLabelTextStyle == daysLabelTextStyle) &&
        (otherData.todayTextStyle == todayTextStyle) &&
        (otherData.todayColor == todayColor) &&
        (otherData.selectedColor == selectedColor) &&
        (otherData.selectedDayTextStyle == selectedDayTextStyle) &&
        (otherData.iconColor == iconColor) &&
        (otherData.iconPrevious == iconPrevious) &&
        (otherData.iconNext == iconNext) &&
        (otherData.weekendTextStyle == weekendTextStyle) &&
        (otherData.weekdayTextStyle == weekdayTextStyle) &&
        (otherData.toolbarColor == toolbarColor) &&
        (otherData.headerTextStyle == headerTextStyle) &&
        (otherData.prevDaysColor == prevDaysColor) &&
        (otherData.nextDaysColor == nextDaysColor) &&
        (otherData.markedDaysTextStyle == markedDaysTextStyle) &&
        (otherData.backgroundColor == backgroundColor) &&
        (otherData.borderColor == borderColor) &&
        (otherData.hintColor == hintColor) &&
        (otherData.labelColor == labelColor) &&
        (otherData.errorColor == errorColor) &&
        (otherData.weekdaysArray == weekdaysArray) &&
        (otherData.monthsArray == monthsArray) &&
        (otherData.markedDatesTitle == markedDatesTitle) &&
        (otherData.markedDateWidget == markedDateWidget) &&
        (otherData.viewportFraction == viewportFraction) &&
        (otherData.prevMonthDayBorderColor == prevMonthDayBorderColor) &&
        (otherData.thisMonthDayBorderColor == thisMonthDayBorderColor) &&
        (otherData.nextMonthDayBorderColor == nextMonthDayBorderColor) &&
        (otherData.dayPadding == dayPadding) &&
        (otherData.dayButtonColor == dayButtonColor) &&
        (otherData.daysHaveCircularBorder == daysHaveCircularBorder) &&
        (otherData.headerMargin == headerMargin) &&
        (otherData.childAspectRatio == childAspectRatio) &&
        (otherData.weekDayMargin == weekDayMargin);
  }

  @override
  int get hashCode {
    final List<Object> values = <Object>[
      dateFormat.hashCode,
      daysLabelTextStyle.hashCode,
      todayTextStyle.hashCode,
      todayColor.hashCode,
      selectedColor.hashCode,
      selectedDayTextStyle.hashCode,
      iconColor.hashCode,
      iconPrevious.hashCode,
      iconNext.hashCode,
      weekendTextStyle.hashCode,
      weekdayTextStyle.hashCode,
      toolbarColor.hashCode,
      headerTextStyle.hashCode,
      prevDaysColor.hashCode,
      nextDaysColor.hashCode,
      markedDaysTextStyle.hashCode,
      backgroundColor.hashCode,
      borderColor.hashCode,
      hintColor.hashCode,
      labelColor.hashCode,
      errorColor.hashCode,
      weekdaysArray.hashCode,
      monthsArray.hashCode,
      markedDatesTitle.hashCode,
      markedDateWidget.hashCode,
      viewportFraction.hashCode,
      prevMonthDayBorderColor.hashCode,
      thisMonthDayBorderColor.hashCode,
      nextMonthDayBorderColor.hashCode,
      dayPadding.hashCode,
      dayButtonColor.hashCode,
      daysHaveCircularBorder.hashCode,
      headerMargin.hashCode,
      childAspectRatio.hashCode,
      weekDayMargin.hashCode,
    ];
    return hashList(values);
  }
}

class TimePickerTheme {
  final Color selectedColor;
  final Color nonSelectedColor;
  final double fontSize;
  final TextStyle buttonTextStyle;
  final TextStyle titleTextStyle;
  final Color buttonColor;
  final Color meridiemButtonColor;
  final TextStyle meridiemTextStyle;
  final IconData icon;

  const TimePickerTheme({
    Color selectedColor,
    Color nonSelectedColor,
    double fontSize,
    TextStyle buttonTextStyle,
    TextStyle titleTextStyle,
    Color buttonColor,
    Color meridiemButtonColor,
    TextStyle meridiemTextStyle,
    IconData icon,
  })  : this.selectedColor = selectedColor ?? Colors.black,
        this.nonSelectedColor = nonSelectedColor ?? const Color(0xFF202020),
        this.fontSize = fontSize ?? 20.0,
        this.buttonTextStyle =
            buttonTextStyle ?? const TextStyle(color: Color(0xff208e5d)),
        this.titleTextStyle =
            titleTextStyle ?? const TextStyle(color: Color(0xffffffff)),
        this.buttonColor = buttonColor ?? const Color(0xffff6378),
        this.meridiemButtonColor =
            meridiemButtonColor ?? const Color(0xffff6378),
        this.meridiemTextStyle =
            meridiemTextStyle ?? const TextStyle(color: Color(0xffffffff), fontWeight:FontWeight.w500),
        this.icon = icon ?? Icons.alarm;

  TimePickerTheme copyWith({
    Color selectedColor,
    Color nonSelectedColor,
    double fontSize,
    TextStyle buttonTextStyle,
    TextStyle titleTextStyle,
    Color buttonColor,
    Color meridiemButtonColor,
    TextStyle meridiemTextStyle,
    IconData icon,
  }) {
    return TimePickerTheme(
      selectedColor: selectedColor ?? this.selectedColor,
      nonSelectedColor: nonSelectedColor ?? this.nonSelectedColor,
      fontSize: fontSize ?? this.fontSize,
      buttonTextStyle: buttonTextStyle ?? this.buttonTextStyle,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      buttonColor: buttonColor ?? this.buttonColor,
      meridiemButtonColor: meridiemButtonColor ?? this.meridiemButtonColor,
      meridiemTextStyle: meridiemTextStyle ?? this.meridiemTextStyle,
      icon: icon ?? this.icon,
    );
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    final TimePickerTheme otherData = other;
    return (otherData.selectedColor == selectedColor) &&
        (otherData.nonSelectedColor == nonSelectedColor) &&
        (otherData.fontSize == fontSize) &&
        (otherData.buttonTextStyle == buttonTextStyle) &&
        (otherData.titleTextStyle == titleTextStyle) &&
        (otherData.buttonColor == buttonColor) &&
        (otherData.meridiemButtonColor == meridiemButtonColor) &&
        (otherData.meridiemTextStyle == meridiemTextStyle) &&
        (otherData.icon == icon);
  }

  @override
  int get hashCode {
    final List<Object> values = <Object>[
      selectedColor.hashCode,
      nonSelectedColor.hashCode,
      fontSize.hashCode,
      buttonTextStyle.hashCode,
      titleTextStyle.hashCode,
      buttonColor.hashCode,
      meridiemButtonColor.hashCode,
      meridiemTextStyle.hashCode,
      icon.hashCode,
    ];
    return hashList(values);
  }
}

class ButtonTheme {
  final Color textColor;

  final Color backgroundColor;

  const ButtonTheme({Color textColor, Color backgroundColor})
      : this.textColor = textColor ?? const Color(0xffffffff),
        this.backgroundColor = backgroundColor ?? const Color(0xfff4329a);

  ButtonTheme copyWith({
    Color textColor,
    Color backgroundColor,
  }) {
    return ButtonTheme(
      textColor: textColor ?? this.textColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    final ButtonTheme otherData = other;
    return (otherData.textColor == textColor) &&
        (otherData.backgroundColor == backgroundColor);
  }

  @override
  int get hashCode {
    final List<Object> values = <Object>[
      textColor.hashCode,
      backgroundColor.hashCode,
    ];
    return hashList(values);
  }
}

class LoadingTheme {
  final String assetName;
  final Color barrierColor;
  final double width;
  final double height;

  const LoadingTheme(
      {String assetName, Color barrierColor, double width, double height})
      : this.assetName = assetName ?? "",
        this.barrierColor = barrierColor ?? const Color(0x10000000),
        this.width = width ?? 100.0,
        this.height = height ?? 100.0;

  LoadingTheme copyWith({
    String assetName,
    Color barrierColor,
    double width,
    double height,
  }) {
    return LoadingTheme(
      assetName: assetName ?? this.assetName,
      barrierColor: barrierColor ?? this.barrierColor,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    final LoadingTheme otherData = other;
    return (otherData.assetName == assetName) &&
        (otherData.barrierColor == barrierColor) &&
        (otherData.width == width) &&
        (otherData.height == height);
  }

  @override
  int get hashCode {
    // Warning: For the sanity of the reader, please make sure these properties
    // are in the exact same order as in operator == and in the raw constructor
    // and in the order of fields in the class and in the lerp() method.
    final List<Object> values = <Object>[
      assetName.hashCode,
      barrierColor.hashCode,
      width.hashCode,
      height.hashCode,
    ];
    return hashList(values);
  }
}
