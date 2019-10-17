part of date_picker;

class DayCalendar extends StatefulWidget {
  final BuildContext mainContext;
  final GlobalKey<MonthCalendarState> monthKey;
  final AnimationController dayMonthAnim;
  final CalendarStyle calendarStyle;
  final PickType pickType;
  final SelectionType selectionType;
  final List<MarkedDate> markedDates;
  final List<DateTime> selectedDateTimes;
  final Function(List<DateTime>) onDayPressed;
  final DateTime minDate;
  final DateTime maxDate;
  final Function(int) onDaySelected;
  final bool isLandscape;

  DayCalendar({
    this.isLandscape,
    this.mainContext,
    Key key,
    this.monthKey,
    this.dayMonthAnim,
    this.calendarStyle,
    this.pickType,
    this.selectionType,
    this.markedDates,
    this.selectedDateTimes,
    this.onDayPressed,
    this.minDate,
    this.maxDate,
    this.onDaySelected,
  }) : super(key: key);

  @override
  DayCalendarState createState() => DayCalendarState();
}

class DayCalendarState extends State<DayCalendar> {
  /// The first run, this will be shown (0.0 [widget.dayMonthAnim]'s value)
  ///
  /// When this title is tapped [_handleDayTitleTapped], we will give this the
  /// fade out animation ([widget.dayMonthAnim]'s value will gradually change
  /// from 0.0 to 1.0)
  ///
  /// When one of [MonthCalendar]'s boxes is tapped [_handleMonthBoxTapped],
  /// we will give this the fade in animation ([widget.dayMonthAnim]'s value
  /// will gradually change from 1.0 to 0.0)

  // Page Controller
  PageController _pageCtrl;

  /// Start Date from each page
  /// the selected page is on index 1,
  /// 0 is for previous month,
  /// 2 is for next month
  List<DateTime> _pageDates = List(3);

  /// Used to mark start and end of week days for rendering boxes purpose
  int _startWeekday = 0;
  int _endWeekday = 0;

  /// Selected DateTime
  List<DateTime> _selectedDateTimes = [];

  /// Marks whether the date range [SelectionType.range] is selected on both ends
  bool _selectRangeIsComplete = false;

  /// Transition that this Widget will go whenever this' title is tapped
  /// [_handleDayTitleTapped] or one of [MonthCalendar]'s boxes is tapped
  /// [_handleMonthBoxTapped]
  ///
  /// This tween will always begin from full expanded offset and size
  /// and end to one of [MonthCalendar]'s boxes offset and size
  Tween<Rect> rectTween;

  @override
  initState() {
    super.initState();

    /// Whenever day to month animation is finished, reset rectTween to null
    widget.dayMonthAnim.addListener(() {
      if (widget.dayMonthAnim.status == AnimationStatus.completed ||
          widget.dayMonthAnim.status == AnimationStatus.dismissed) {
        rectTween = null;
      }
    });

    _selectedDateTimes = widget.selectedDateTimes;

    _selectRangeIsComplete =
        widget.selectionType == SelectionType.range && _selectedDateTimes.length % 2 == 0;

    /// setup pageController
    _pageCtrl = PageController(
      initialPage: 1,
      keepPage: true,
      viewportFraction: widget.calendarStyle.viewportFraction,
    );

    /// set _pageDates for the first time
    this._setPage();
  }

  @override
  dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext parentContext) {
//    timeDilation = 5.0;

  print("build");
    Widget dayContent = widget.isLandscape
        ? _buildDayContentLandscape(parentContext)
        : _buildDayContentPortrait(parentContext);

    return AnimatedBuilder(
        animation: widget.dayMonthAnim,
        builder: (BuildContext context, Widget child) {
          if (rectTween == null)
            return AdvVisibility(
                visibility:
                    widget.dayMonthAnim.value == 1.0 ? VisibilityFlag.gone : VisibilityFlag.visible,
                child: dayContent);

          /// rect tween set when one of these two occasions occurs
          /// 1. Day Title tapped so it has to be squeezed inside month boxes
          ///
          ///     See also [_handleDayTitleTapped]
          /// 2. One of month boxes is tapped, so Day content should be expanded
          ///     See also [_handleDayBoxTapped]

          /// calculate lerp of destination rect according to current widget.dayMonthAnim.value
          final Rect destRect = rectTween.evaluate(widget.dayMonthAnim);

          /// minus padding for each horizontal and vertical axis
          final Size destSize = Size(destRect.size.width - (widget.calendarStyle.dayPadding * 2),
              destRect.size.height - (widget.calendarStyle.dayPadding * 2));
          final double top = destRect.top + widget.calendarStyle.dayPadding;
          final double left = destRect.left + widget.calendarStyle.dayPadding;

          double xFactor = destSize.width / rectTween.begin.width;
          double yFactor = destSize.height / rectTween.begin.height;

          /// scaling the content inside
          final Matrix4 transform = Matrix4.identity()..scale(xFactor, yFactor, 1.0);

          /// keep the initial size, so we can achieve destination scale
          /// example :
          /// rectTween.begin.width * destSize.width / rectTween.begin.width => destSize.width

          /// For the Opacity :
          /// as the scaling goes from 0.0 to 1.0, we progressively change the opacity from 1.0 to 0.0
          return Positioned(
              top: top,
              width: rectTween.begin.width,
              height: rectTween.begin.height,
              left: left,
              child: Opacity(
                  opacity: 1.0 - widget.dayMonthAnim.value,
                  child: Transform(transform: transform, child: dayContent)));
        });
  }

  Widget _buildDayContentPortrait(BuildContext context) {
    return Column(
      children: <Widget>[
        AdvRow(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          children: <Widget>[
            IconButton(
              onPressed: () => _setPage(page: 0),
              icon: Icon(
                widget.calendarStyle.iconPrevious,
                color: widget.calendarStyle.iconColor,
              ),
            ),
            Builder(builder: (BuildContext childContext) {
              String title = DateFormat.yMMM().format(this._pageDates[1]);
              return Expanded(
                child: InkWell(
                  child: Container(
                    padding: widget.calendarStyle.headerMargin,
                    child: Text(
                      '$title',
                      textAlign: TextAlign.center,
                      style: widget.calendarStyle.defaultHeaderTextStyle,
                    ),
                  ),
                  onTap: () => _handleDayTitleTapped(context),
                ),
              );
            }),
            IconButton(
              padding: widget.calendarStyle.headerMargin,
              onPressed: () => _setPage(page: 2),
              icon: Icon(
                widget.calendarStyle.iconNext,
                color: widget.calendarStyle.iconColor,
              ),
            ),
          ],
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: this._renderWeekDays(),
          ),
        ),
        Expanded(
          child: PageView.builder(
            itemCount: 3,
            onPageChanged: (value) {
              this._setPage(page: value);
            },
            controller: _pageCtrl,
            itemBuilder: (context, index) {
              return _buildCalendarPortrait(index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDayContentLandscape(BuildContext context) {
    int year = this._pageDates[1].year;
    int month = this._pageDates[1].month;
    DateFormat df = DateFormat("dd MMM");

    return Row(children: [
      LayoutBuilder(builder: (BuildContext context, BoxConstraints constraint) {
        double width = ((constraint.maxHeight - 32.0) / 6 * 7).clamp(0.0, 500.0);

        return Container(
          width: width,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: this._renderWeekDays(),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: 3,
                  onPageChanged: (value) {
                    this._setPage(page: value);
                  },
                  controller: _pageCtrl,
                  itemBuilder: (context, index) {
                    print("itemBuilder => $index");
                    return _buildCalendarLandscape(index);
                  },
                ),
              ),
            ],
          ),
        );
      }),
      Expanded(
          child: Column(children: [
        AdvRow(
          children: <Widget>[
            IconButton(
              onPressed: () => _setPage(page: 0),
              icon: Icon(
                widget.calendarStyle.iconPrevious,
                color: widget.calendarStyle.iconColor,
              ),
            ),
            Builder(builder: (BuildContext childContext) {
              String title = DateFormat.yMMM().format(this._pageDates[1]);
              return Expanded(
                child: InkWell(
                  child: Container(
                    padding: widget.calendarStyle.headerMargin,
                    child: Text(
                      '$title',
                      textAlign: TextAlign.center,
                      style: widget.calendarStyle.defaultHeaderTextStyle,
                    ),
                  ),
                  onTap: () => _handleDayTitleTapped(context),
                ),
              );
            }),
            IconButton(
              padding: widget.calendarStyle.headerMargin,
              onPressed: () => _setPage(page: 2),
              icon: Icon(
                widget.calendarStyle.iconNext,
                color: widget.calendarStyle.iconColor,
              ),
            ),
          ],
        ),
        Visibility(
            visible: widget.markedDates
                    .where((markedDate) =>
                        markedDate.date.month == month && markedDate.date.year == year)
                    .toList()
                    .length >
                0,
            child: Container(
              child: Text(
                BasicComponents.datePicker.markedDatesTitle,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
              ),
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 4.0),
            )),
        Expanded(
            child: ListView(
                children: widget.markedDates
                    .where((markedDate) =>
                        markedDate.date.month == month && markedDate.date.year == year)
                    .toList()
                    .map((markedDate) {
          var tp = new TextPainter(
              text: TextSpan(text: "99 Nov", style: widget.calendarStyle.defaultNotesTextStyle),
              textDirection: ui.TextDirection.ltr);

          tp.layout();
          return AdvRow(
              crossAxisAlignment: CrossAxisAlignment.start,
              divider: Text(" - "),
              children: [
                Container(
                    child: Text(
                      "${df.format(markedDate.date)}",
                      textAlign: TextAlign.end,
                      style: widget.calendarStyle.defaultNotesTextStyle,
                    ),
                    width: tp.width),
                Expanded(
                  child: Text(
                    "${markedDate.note}",
                    style: widget.calendarStyle.defaultNotesTextStyle,
                  ),
                )
              ]);
        }).toList())),
        AdvVisibility(
          //temp solution
          visibility: VisibilityFlag.invisible,
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: AdvButton.text(
                "Submit",
                buttonSize: ButtonSize.large,
                onPressed: () {},
              )),
        ),
      ]))
    ]);
  }

  _buildCalendarPortrait(int slideIndex) {
    int totalItemCount = DateTime(
          this._pageDates[slideIndex].year,
          this._pageDates[slideIndex].month + 1,
          0,
        ).day +
        this._startWeekday +
        (7 - this._endWeekday);
    int year = this._pageDates[slideIndex].year;
    int month = this._pageDates[slideIndex].month;
    DateFormat df = DateFormat("dd MMM");

    /// build calendar and marked dates notes
    return AdvColumn(
      children: <Widget>[
        Container(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 7,
            childAspectRatio: widget.calendarStyle.childAspectRatio,
            padding: EdgeInsets.zero,
            children: List.generate(totalItemCount, (index) {
              DateTime currentDate = DateTime(year, month, index + 1 - this._startWeekday);
              bool isToday = DateTime.now().day == currentDate.day &&
                  DateTime.now().month == currentDate.month &&
                  DateTime.now().year == currentDate.year;
              bool isSelectedDay = (widget.selectionType != SelectionType.range &&
                      _selectedDateTimes.length > 0 &&
                      _selectedDateTimes.indexOf(currentDate) >= 0) ||
                  (widget.selectionType == SelectionType.range &&
                      _selectedDateTimes.length == 2 &&
                      currentDate.difference(_selectedDateTimes[0]).inDays > 0 &&
                      _selectedDateTimes.last.difference(currentDate).inDays > 0);

              /// this is for range selection type
              bool isStartEndDay = _selectedDateTimes.length > 0 &&
                  ((_selectedDateTimes.indexOf(currentDate) == 0 ||
                          _selectedDateTimes.indexOf(currentDate) ==
                              _selectedDateTimes.length - 1) ||
                      (widget.selectionType != SelectionType.range &&
                          _selectedDateTimes.indexOf(currentDate) >= 0));

              bool isPrevMonthDay = index < this._startWeekday;
              bool isNextMonthDay =
                  index >= (DateTime(year, month + 1, 0).day) + this._startWeekday;
              bool isThisMonthDay = !isPrevMonthDay && !isNextMonthDay;

              TextStyle textStyle;
              Color borderColor;
              if (isPrevMonthDay) {
                textStyle = isSelectedDay || isStartEndDay
                    ? widget.calendarStyle.defaultSelectedDayTextStyle
                    : isToday
                        ? widget.calendarStyle.defaultTodayTextStyle
                        : (index % 7 == 0 || index % 7 == 6)
                            ? widget.calendarStyle.defaultWeekendTextStyle
                            : widget.calendarStyle.defaultDaysTextStyle;
                textStyle =
                    textStyle.copyWith(color: Color.lerp(textStyle.color, Colors.white, 0.7));
                borderColor = widget.calendarStyle.prevMonthDayBorderColor;
              } else if (isThisMonthDay) {
                textStyle = isSelectedDay || isStartEndDay
                    ? widget.calendarStyle.defaultSelectedDayTextStyle
                    : isToday
                        ? widget.calendarStyle.defaultTodayTextStyle
                        : (index % 7 == 0 || index % 7 == 6)
                            ? widget.calendarStyle.defaultWeekendTextStyle
                            : widget.calendarStyle.defaultDaysTextStyle;
                borderColor = isToday
                    ? widget.calendarStyle.todayBorderColor
                    : widget.calendarStyle.nextMonthDayBorderColor;
              } else if (isNextMonthDay) {
                textStyle = isSelectedDay || isStartEndDay
                    ? widget.calendarStyle.defaultSelectedDayTextStyle
                    : isToday
                        ? widget.calendarStyle.defaultTodayTextStyle
                        : (index % 7 == 0 || index % 7 == 6)
                            ? widget.calendarStyle.defaultWeekendTextStyle
                            : widget.calendarStyle.defaultDaysTextStyle;
                textStyle =
                    textStyle.copyWith(color: Color.lerp(textStyle.color, Colors.white, 0.7));
                borderColor = widget.calendarStyle.nextMonthDayBorderColor;
              }

              Color boxColor;
              if (isStartEndDay && widget.calendarStyle.selectedDayButtonColor != null) {
                boxColor = widget.calendarStyle.selectedDayButtonColor;
              } else if (isSelectedDay && widget.calendarStyle.selectedDayButtonColor != null) {
                boxColor = widget.calendarStyle.selectedDayButtonColor.withAlpha(150);
              } else if (isToday && widget.calendarStyle.todayBorderColor != null) {
                boxColor = widget.calendarStyle.todayButtonColor;
              } else {
                boxColor = widget.calendarStyle.dayButtonColor;
              }

              int currentDateLong = currentDate.millisecondsSinceEpoch;
              int minDateLong = widget.minDate?.millisecondsSinceEpoch ?? currentDateLong;
              int maxDateLong = widget.maxDate?.millisecondsSinceEpoch ?? currentDateLong;
              bool availableDate = currentDateLong >= minDateLong && currentDateLong <= maxDateLong;

              return Container(
                margin: EdgeInsets.all(widget.calendarStyle.dayPadding),
                child: IgnorePointer(
                  ignoring: !availableDate,
                  child: FlatButton(
                    color: availableDate ? boxColor : Color.lerp(lerpColor, boxColor, 0.8),
                    onPressed: () => _handleDayBoxTapped(currentDate),
                    padding: EdgeInsets.all(widget.calendarStyle.dayPadding),
                    shape: (widget.calendarStyle.daysHaveCircularBorder ?? false)
                        ? CircleBorder(side: BorderSide(color: borderColor))
                        : RoundedRectangleBorder(side: BorderSide(color: borderColor)),
                    child: Stack(children: <Widget>[
                      Center(
                        child: Text(
                          '${currentDate.day}',
                          style: availableDate
                              ? textStyle
                              : textStyle.copyWith(
                                  color: Color.lerp(lerpColor, textStyle.color, 0.5)),
                          maxLines: 1,
                        ),
                      ),
                      _renderMarked(currentDate),
                    ]),
                  ),
                ),
              );
            }),
          ),
        ),
        Visibility(
            visible: widget.markedDates
                    .where((markedDate) =>
                        markedDate.date.month == month && markedDate.date.year == year)
                    .toList()
                    .length >
                0,
            child: Container(
              child: Text(
                BasicComponents.datePicker.markedDatesTitle,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
              ),
              width: double.infinity,
              padding: EdgeInsets.only(top: 8.0, bottom: 4.0),
            )),
        Expanded(
            child: Container(
          child: ListView(
              children: widget.markedDates
                  .where((markedDate) =>
                      markedDate.date.month == month && markedDate.date.year == year)
                  .toList()
                  .map((markedDate) {
                var tp = new TextPainter(
                    text: TextSpan(text: "99 Nov", style: widget.calendarStyle.defaultNotesTextStyle),
                    textDirection: ui.TextDirection.ltr);

                tp.layout();
                return AdvRow(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    divider: Text(" - "),
                    children: [
                      Container(
                          child: Text(
                            "${df.format(markedDate.date)}",
                            textAlign: TextAlign.end,
                            style: widget.calendarStyle.defaultNotesTextStyle,
                          ),
                          width: tp.width),
                      Expanded(
                        child: Text(
                          "${markedDate.note}",
                          style: widget.calendarStyle.defaultNotesTextStyle,
                        ),
                      )
                    ]);
          }).toList()),
        )),
      ],
    );
  }

  _buildCalendarLandscape(int slideIndex) {
    int totalItemCount = DateTime(
          this._pageDates[slideIndex].year,
          this._pageDates[slideIndex].month + 1,
          0,
        ).day +
        this._startWeekday +
        (7 - this._endWeekday);
    int year = this._pageDates[slideIndex].year;
    int month = this._pageDates[slideIndex].month;

    /// build calendar and marked dates notes
    return GridView.count(
            shrinkWrap: true,
            crossAxisCount: 7,
            childAspectRatio: widget.calendarStyle.childAspectRatio,
            padding: EdgeInsets.zero,
            children: List.generate(totalItemCount, (index) {
              DateTime currentDate = DateTime(year, month, index + 1 - this._startWeekday);
              bool isToday = DateTime.now().day == currentDate.day &&
                  DateTime.now().month == currentDate.month &&
                  DateTime.now().year == currentDate.year;
              bool isSelectedDay = (widget.selectionType != SelectionType.range &&
                      _selectedDateTimes.length > 0 &&
                      _selectedDateTimes.indexOf(currentDate) >= 0) ||
                  (widget.selectionType == SelectionType.range &&
                      _selectedDateTimes.length == 2 &&
                      currentDate.difference(_selectedDateTimes[0]).inDays > 0 &&
                      _selectedDateTimes.last.difference(currentDate).inDays > 0);

              /// this is for range selection type
              bool isStartEndDay = _selectedDateTimes.length > 0 &&
                  ((_selectedDateTimes.indexOf(currentDate) == 0 ||
                          _selectedDateTimes.indexOf(currentDate) ==
                              _selectedDateTimes.length - 1) ||
                      (widget.selectionType != SelectionType.range &&
                          _selectedDateTimes.indexOf(currentDate) >= 0));

              bool isPrevMonthDay = index < this._startWeekday;
              bool isNextMonthDay =
                  index >= (DateTime(year, month + 1, 0).day) + this._startWeekday;
              bool isThisMonthDay = !isPrevMonthDay && !isNextMonthDay;

              TextStyle textStyle;
              Color borderColor;
              if (isPrevMonthDay) {
                textStyle = isSelectedDay || isStartEndDay
                    ? widget.calendarStyle.defaultSelectedDayTextStyle
                    : isToday
                        ? widget.calendarStyle.defaultTodayTextStyle
                        : (index % 7 == 0 || index % 7 == 6)
                            ? widget.calendarStyle.defaultWeekendTextStyle
                            : widget.calendarStyle.defaultDaysTextStyle;
                textStyle =
                    textStyle.copyWith(color: Color.lerp(textStyle.color, Colors.white, 0.7));
                borderColor = widget.calendarStyle.prevMonthDayBorderColor;
              } else if (isThisMonthDay) {
                textStyle = isSelectedDay || isStartEndDay
                    ? widget.calendarStyle.defaultSelectedDayTextStyle
                    : isToday
                        ? widget.calendarStyle.defaultTodayTextStyle
                        : (index % 7 == 0 || index % 7 == 6)
                            ? widget.calendarStyle.defaultWeekendTextStyle
                            : widget.calendarStyle.defaultDaysTextStyle;
                borderColor = isToday
                    ? widget.calendarStyle.todayBorderColor
                    : widget.calendarStyle.nextMonthDayBorderColor;
              } else if (isNextMonthDay) {
                textStyle = isSelectedDay || isStartEndDay
                    ? widget.calendarStyle.defaultSelectedDayTextStyle
                    : isToday
                        ? widget.calendarStyle.defaultTodayTextStyle
                        : (index % 7 == 0 || index % 7 == 6)
                            ? widget.calendarStyle.defaultWeekendTextStyle
                            : widget.calendarStyle.defaultDaysTextStyle;
                textStyle =
                    textStyle.copyWith(color: Color.lerp(textStyle.color, Colors.white, 0.7));
                borderColor = widget.calendarStyle.nextMonthDayBorderColor;
              }

              Color boxColor;
              if (isStartEndDay && widget.calendarStyle.selectedDayButtonColor != null) {
                boxColor = widget.calendarStyle.selectedDayButtonColor;
              } else if (isSelectedDay && widget.calendarStyle.selectedDayButtonColor != null) {
                boxColor = widget.calendarStyle.selectedDayButtonColor.withAlpha(150);
              } else if (isToday && widget.calendarStyle.todayBorderColor != null) {
                boxColor = widget.calendarStyle.todayButtonColor;
              } else {
                boxColor = widget.calendarStyle.dayButtonColor;
              }

              int currentDateLong = currentDate.millisecondsSinceEpoch;
              int minDateLong = widget.minDate?.millisecondsSinceEpoch ?? currentDateLong;
              int maxDateLong = widget.maxDate?.millisecondsSinceEpoch ?? currentDateLong;
              bool availableDate = currentDateLong >= minDateLong && currentDateLong <= maxDateLong;

              return Container(
                margin: EdgeInsets.all(widget.calendarStyle.dayPadding),
                child: IgnorePointer(
                  ignoring: !availableDate,
                  child: FlatButton(
                    color: availableDate ? boxColor : Color.lerp(lerpColor, boxColor, 0.8),
                    onPressed: () => _handleDayBoxTapped(currentDate),
                    padding: EdgeInsets.all(widget.calendarStyle.dayPadding),
                    shape: (widget.calendarStyle.daysHaveCircularBorder ?? false)
                        ? CircleBorder(side: BorderSide(color: borderColor))
                        : RoundedRectangleBorder(side: BorderSide(color: borderColor)),
                    child: Stack(children: <Widget>[
                      Center(
                        child: Text(
                          '${currentDate.day}',
                          style: availableDate
                              ? textStyle
                              : textStyle.copyWith(
                                  color: Color.lerp(lerpColor, textStyle.color, 0.5)),
                          maxLines: 1,
                        ),
                      ),
                      _renderMarked(currentDate),
                    ]),
                  ),
                ),
              );
            }),
    );
  }

  List<Widget> _renderWeekDays() {
    List<Widget> list = [];
    for (var weekDay in widget.calendarStyle.weekDays) {
      list.add(
        Expanded(
            child: Container(
          margin: widget.calendarStyle.weekDayMargin,
          child: Center(
            child: Text(
              weekDay,
              style: widget.calendarStyle.daysLabelTextStyle,
            ),
          ),
        )),
      );
    }
    return list;
  }

  /// draw a little dot inside the each boxes (only if it's one of the
  /// [widget.markedDates] and slightly below day text
  Widget _renderMarked(DateTime now) {
    if (widget.markedDates != null &&
        widget.markedDates.length > 0 &&
        widget.markedDates.where((markedDate) => markedDate.date == now).toList().length > 0) {
      return widget.calendarStyle.defaultMarkedDateWidget;
    }

    return Container();
  }

  void _handleSubmitBottonTapped() {
    if (widget.onDayPressed != null) widget.onDayPressed(_selectedDateTimes);
  }

  void _handleDayTitleTapped(BuildContext context) {
    /// unless the whole content is fully expanded, cannot tap on title
    if (widget.dayMonthAnim.value != 0.0) return;

    RenderBox fullRenderBox = context.findRenderObject();
    var fullSize = fullRenderBox.size;
    var fullOffset = Offset.zero;

    Rect fullRect = Rect.fromLTWH(fullOffset.dx, fullOffset.dy, fullSize.width, fullSize.height);
    Rect boxRect = widget.monthKey.currentState.getBoxRectFromIndex(this._pageDates[1].month - 1);

    rectTween = RectTween(begin: fullRect, end: boxRect);

    setState(() {
      widget.dayMonthAnim.forward();
    });
  }

  void _handleDayBoxTapped(DateTime currentDate) {
    /// unless the whole content is fully expanded, cannot tap on date
    if (widget.dayMonthAnim.value != 0.0) return;

    if (widget.selectionType == SelectionType.single) {
      _selectedDateTimes.clear();
      _selectedDateTimes.add(currentDate);
      if (widget.onDayPressed != null) widget.onDayPressed(_selectedDateTimes);
    } else if (widget.selectionType == SelectionType.multi) {
      if (_selectedDateTimes.where((date) => date == currentDate).length == 0) {
        _selectedDateTimes.add(currentDate);
      } else {
        _selectedDateTimes.remove(currentDate);
      }

      if (widget.onDaySelected != null) widget.onDaySelected(_selectedDateTimes.length);
    } else if (widget.selectionType == SelectionType.range) {
      if (!_selectRangeIsComplete) {
        var dateDiff = _selectedDateTimes[0].difference(currentDate).inDays;
        DateTime loopDate;
        DateTime endDate;

        if (dateDiff > 0) {
          loopDate = currentDate;
          endDate = _selectedDateTimes[0];
        } else {
          loopDate = _selectedDateTimes[0];
          endDate = currentDate;
        }

        _selectedDateTimes.clear();
        _selectedDateTimes.add(loopDate);
        _selectedDateTimes.add(endDate);

//        if (widget.onDayPressed != null) widget.onDayPressed(_selectedDateTimes);
      } else {
        _selectedDateTimes.clear();
        _selectedDateTimes.add(currentDate);
      }

      _selectRangeIsComplete = !_selectRangeIsComplete;

      if (widget.onDaySelected != null) widget.onDaySelected(_selectedDateTimes.length);
    }

    setState(() {});

    widget.monthKey.currentState.updateSelectedDateTimes(_selectedDateTimes);
  }

  void _setPage({int page}) {
    print("_setPage => $page");
    /// for initial set
    if (page == null) {
      DateTime selectedDate = _selectedDateTimes != null && _selectedDateTimes.length > 0
          ? _selectedDateTimes.first
          : DateTime.now();

      DateTime date0 = DateTime(selectedDate.year, selectedDate.month - 1, 1);
      DateTime date1 = DateTime(selectedDate.year, selectedDate.month, 1);
      DateTime date2 = DateTime(selectedDate.year, selectedDate.month + 1, 1);

      this.setState(() {
        _startWeekday = date1.weekday;
        _endWeekday = date2.weekday;
        this._pageDates = [
          date0,
          date1,
          date2,
        ];
      });
    } else if (page == 1) {
      /// return right away if the selected page is current page
      return;
    } else {
      /// processing for the next or previous page
      List<DateTime> dates = this._pageDates;

      /// previous page
      if (page == 0) {
        dates[2] = DateTime(dates[0].year, dates[0].month + 1, 1);
        dates[1] = DateTime(dates[0].year, dates[0].month, 1);
        dates[0] = DateTime(dates[0].year, dates[0].month - 1, 1);
        page = page + 1;
      } else if (page == 2) {
        /// next page
        dates[0] = DateTime(dates[2].year, dates[2].month - 1, 1);
        dates[1] = DateTime(dates[2].year, dates[2].month, 1);
        dates[2] = DateTime(dates[2].year, dates[2].month + 1, 1);
        page = page - 1;
      }

      this.setState(() {
        _startWeekday = dates[page].weekday;
        _endWeekday = dates[page + 1].weekday;
        this._pageDates = dates;
      });

      /// animate to page right away after reset the values
      _pageCtrl.animateToPage(page, duration: Duration(milliseconds: 1), curve: Threshold(0.0));
    }

    /// set current month and year in the [MonthCalendar] and
    /// [YearCalendar (via MonthCalendar)]
    widget.monthKey.currentState.setMonth(_pageDates[1].month, _pageDates[1].year);
    widget.monthKey.currentState.setYear(_pageDates[1].year);
  }

  /// an open method for [MonthCalendar] to trigger whenever it itself changes
  /// its month value
  void setMonth(
    int month,
    int year,
  ) {
    List<DateTime> dates = List(3);
    dates[0] = DateTime(year, month - 1, 1);
    dates[1] = DateTime(year, month, 1);
    dates[2] = DateTime(year, month + 1, 1);

    this.setState(() {
      _startWeekday = dates[1].weekday;
      _endWeekday = dates[2].weekday;
      this._pageDates = dates;
    });
  }
}
