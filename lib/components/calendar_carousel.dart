part of date_picker;

const int _kAnimationDuration = 300;

enum PickType {
  day,
  month,
  year,
}

class CalendarStyle {
  final TextStyle defaultHeaderTextStyle =
      TextStyle(fontSize: 20.0, color: BasicComponents.datePicker.headerColor);
  final TextStyle defaultDaysTextStyle = TextStyle(color: BasicComponents.datePicker.weekdayColor);
  final TextStyle defaultTodayTextStyle =
      TextStyle(color: BasicComponents.datePicker.todayTextColor);
  final TextStyle defaultSelectedDayTextStyle =
      TextStyle(color: BasicComponents.datePicker.selectedTextColor);
  final TextStyle daysLabelTextStyle = TextStyle(color: BasicComponents.datePicker.daysLabelColor);
  final TextStyle defaultNotesTextStyle =
      TextStyle(color: BasicComponents.datePicker.markedDaysDaysColor);
  final TextStyle defaultWeekendTextStyle =
      TextStyle(color: BasicComponents.datePicker.weekendColor);
  final Widget defaultMarkedDateWidget = Positioned(
    child: Container(
      color: BasicComponents.datePicker.markedDaysDaysColor,
      height: 4.0,
      width: 4.0,
    ),
    bottom: 4.0,
    left: 18.0,
  );
  final Color todayBorderColor = BasicComponents.datePicker.todayColor;
  final Color todayButtonColor = BasicComponents.datePicker.todayColor;
  final Color selectedDayButtonColor = BasicComponents.datePicker.selectedColor;
  final Color iconColor = BasicComponents.datePicker.iconColor;
  final IconData iconPrevious = BasicComponents.datePicker.iconPrevious;
  final IconData iconNext = BasicComponents.datePicker.iconNext;

//  final Color selectedDayBorderColor = BasicComponents.datePickerSelectedColor;

  final List<String> weekDays;
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

  CalendarStyle({
    this.weekDays = const ['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'],
    this.viewportFraction = 1.0,
    this.prevMonthDayBorderColor = Colors.transparent,
    this.thisMonthDayBorderColor = Colors.transparent,
    this.nextMonthDayBorderColor = Colors.transparent,
    this.dayPadding = 2.0,
    this.dayButtonColor = Colors.transparent,
    this.daysHaveCircularBorder,
    this.headerMargin = const EdgeInsets.symmetric(vertical: 16.0),
    this.childAspectRatio = 1.0,
    this.weekDayMargin = const EdgeInsets.only(bottom: 4.0),
  });
}

class CalendarCarousel extends StatefulWidget {
  final PickType pickType;
  final List<DateTime> selectedDateTimes;
  final Function(List<DateTime>) onDayPressed;
  final List<MarkedDate> markedDates;
  final SelectionType selectionType;
  final CalendarStyle calendarStyle;
  final DateTime minDate;
  final DateTime maxDate;

  CalendarCarousel({
    PickType pickType,
    List<String> weekDays = const ['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'],
    double viewportFraction = 1.0,
    Color prevMonthDayBorderColor = Colors.transparent,
    Color thisMonthDayBorderColor = Colors.transparent,
    Color nextMonthDayBorderColor = Colors.transparent,
    double dayPadding = 2.0,
    Color dayButtonColor = Colors.transparent,
    this.selectedDateTimes,
    bool daysHaveCircularBorder,
    this.onDayPressed,
    Color iconColor = Colors.blueAccent,
    List<MarkedDate> markedDates = const [],
    this.selectionType = SelectionType.single,
    EdgeInsets headerMargin = const EdgeInsets.symmetric(vertical: 16.0),
    double childAspectRatio = 1.0,
    EdgeInsets weekDayMargin = const EdgeInsets.only(bottom: 4.0),
    this.minDate,
    this.maxDate,
  })  : this.pickType = pickType ?? PickType.day,
        this.markedDates = markedDates ?? const [],
        this.calendarStyle = CalendarStyle(
          weekDays: weekDays,
          viewportFraction: viewportFraction,
          prevMonthDayBorderColor: prevMonthDayBorderColor,
          thisMonthDayBorderColor: thisMonthDayBorderColor,
          nextMonthDayBorderColor: nextMonthDayBorderColor,
          dayPadding: dayPadding,
          dayButtonColor: dayButtonColor,
          daysHaveCircularBorder: daysHaveCircularBorder,
          headerMargin: headerMargin,
          childAspectRatio: childAspectRatio,
          weekDayMargin: weekDayMargin,
        );

  @override
  _CalendarCarouselState createState() => _CalendarCarouselState();
}

class _CalendarCarouselState extends State<CalendarCarousel> with TickerProviderStateMixin {
  GlobalKey<DayCalendarState> _dayKey = GlobalKey<DayCalendarState>();
  GlobalKey<MonthCalendarState> _monthKey = GlobalKey<MonthCalendarState>();
  GlobalKey<YearCalendarState> _yearKey = GlobalKey<YearCalendarState>();
  AnimationController _dayMonthAnim;
  AnimationController _monthYearAnim;
  int _dateCount = 0;

  @override
  void initState() {
    super.initState();
    _dateCount = widget.selectedDateTimes.length;
    _dayMonthAnim =
        AnimationController(duration: Duration(milliseconds: _kAnimationDuration), vsync: this);
    _monthYearAnim = AnimationController(
        duration: Duration(milliseconds: _kAnimationDuration), vsync: this, value: 1.0);
  }

  @override
  dispose() {
    _dayMonthAnim.dispose();
    _monthYearAnim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> _selectedDateTimes = widget.selectedDateTimes
        .map((DateTime dateTime) => DateTime(dateTime.year, dateTime.month, dateTime.day))
        .toList();
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return Stack(children: [
          AdvColumn(children: [
            Expanded(
              child: Builder(builder: (BuildContext context) {
                List<Widget> children = [
                  YearCalendar(
                    isLandscape: orientation == Orientation.landscape,
                    mainContext: context,
                    key: _yearKey,
                    pickType: widget.pickType,
                    monthKey: _monthKey,
                    calendarStyle: widget.calendarStyle,
                    monthYearAnim: _monthYearAnim,
                    selectedDateTimes: _selectedDateTimes,
                    onDayPressed: widget.onDayPressed,
                    markedDates: widget.markedDates,
                    selectionType: widget.selectionType,
                    minDate: widget.minDate,
                    maxDate: widget.maxDate,
                  ),
                ];

                if (widget.pickType == PickType.month || widget.pickType == PickType.day) {
                  children.add(
                    MonthCalendar(
                      isLandscape: orientation == Orientation.landscape,
                      mainContext: context,
                      key: _monthKey,
                      pickType: widget.pickType,
                      dayKey: _dayKey,
                      yearKey: _yearKey,
                      calendarStyle: widget.calendarStyle,
                      dayMonthAnim: _dayMonthAnim,
                      monthYearAnim: _monthYearAnim,
                      selectedDateTimes: _selectedDateTimes,
                      onDayPressed: widget.onDayPressed,
                      markedDates: widget.markedDates,
                      selectionType: widget.selectionType,
                      minDate: widget.minDate,
                      maxDate: widget.maxDate,
                    ),
                  );
                }

                if (widget.pickType == PickType.day) {
                  children.add(
                    DayCalendar(
                      isLandscape: orientation == Orientation.landscape,
                      mainContext: context,
                      key: _dayKey,
                      pickType: widget.pickType,
                      monthKey: _monthKey,
                      calendarStyle: widget.calendarStyle,
                      dayMonthAnim: _dayMonthAnim,
                      selectedDateTimes: _selectedDateTimes,
                      onDayPressed: widget.onDayPressed,
                      markedDates: widget.markedDates,
                      selectionType: widget.selectionType,
                      minDate: widget.minDate,
                      maxDate: widget.maxDate,
                      onDaySelected: (int dateCount) {
                        setState(() {
                          _dateCount = dateCount;
                        });
                      },
                    ),
                  );
                }

                return Stack(children: children);
              }),
            ),
            orientation == Orientation.portrait
                ? AnimatedBuilder(
                    animation: _dayMonthAnim,
                    builder: (BuildContext context, Widget child) {
                      return AdvVisibility(
                          visibility: (widget.selectionType == SelectionType.multi ||
                                      widget.selectionType == SelectionType.range) &&
                                  _dayMonthAnim.value != 1.0
                              ? VisibilityFlag.visible
                              : VisibilityFlag.invisible,
                          child: Opacity(
                            opacity: 1.0 - _dayMonthAnim.value,
                            child: Container(
                                margin: EdgeInsets.symmetric(vertical: 8.0),
                                child: AdvButton.text(
                                  "Submit ($_dateCount)",
                                  width: double.infinity,
                                  buttonSize: ButtonSize.large,
                                  onPressed: () {
                                    switch (widget.pickType) {
                                      case PickType.year:
                                        _yearKey.currentState._handleSubmitTapped();
                                        break;
                                      case PickType.month:
                                        _monthKey.currentState._handleSubmitTapped();
                                        break;
                                      case PickType.day:
                                        _dayKey.currentState._handleSubmitBottonTapped();
                                        break;
                                    }
                                  },
                                )),
                          ));
                    })
                : null,
          ]),
          orientation == Orientation.landscape
              ? Positioned(
                  right: 0.0,
                  bottom: 0.0,
                  child: AdvVisibility(
                    visibility: (widget.selectionType == SelectionType.multi ||
                                widget.selectionType == SelectionType.range) &&
                            _dayMonthAnim.value != 1.0
                        ? VisibilityFlag.visible
                        : VisibilityFlag.invisible,
                    child: Opacity(
                      opacity: 1.0 - _dayMonthAnim.value,
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: AdvButton.text(
                            "Submit ($_dateCount)",
                            buttonSize: ButtonSize.large,
                            onPressed: () {
                              switch (widget.pickType) {
                                case PickType.year:
                                  _yearKey.currentState._handleSubmitTapped();
                                  break;
                                case PickType.month:
                                  _monthKey.currentState._handleSubmitTapped();
                                  break;
                                case PickType.day:
                                  _dayKey.currentState._handleSubmitBottonTapped();
                                  break;
                              }
                            },
                          )),
                    ),
                  ),
                )
              : Container(
                  width: 0.0,
                  height: 0.0,
                )
        ]);
      },
    );
  }
}
