part of date_picker;

class YearCalendar extends StatefulWidget {
  final BuildContext mainContext;
  final GlobalKey<MonthCalendarState> monthKey;
  final AnimationController monthYearAnim;
  final CalendarStyle calendarStyle;
  final PickType pickType;
  final SelectionType selectionType;
  final List<MarkedDate> markedDates;
  final List<DateTime> selectedDateTimes;
  final Function(List<DateTime>) onDayPressed;
  final DateTime minDate;
  final DateTime maxDate;
  final bool isLandscape;

  YearCalendar({
    this.isLandscape,
    this.mainContext,
    Key key,
    this.monthKey,
    this.monthYearAnim,
    this.calendarStyle,
    this.pickType,
    this.selectionType,
    this.markedDates,
    this.selectedDateTimes,
    this.onDayPressed,
    this.minDate,
    this.maxDate,
  }) : super(key: key);

  @override
  YearCalendarState createState() => YearCalendarState();
}

class YearCalendarState extends State<YearCalendar> with SingleTickerProviderStateMixin {
  /// The first run, this will be hidden (1.0 [widget.monthYearAnim]'s value)
  ///
  /// When the [MonthCalendar]'s title is tapped [_handleMonthTitleTapped],
  /// we will give this the fade in animation ([widget.monthYearAnim]'s value
  /// will gradually change from 1.0 to 0.0)
  ///
  /// When one of this' boxes is tapped [_handleYearBoxTapped], we will give
  /// this the fade out animation ([widget.dayMonthAnim]'s value will gradually
  /// change from 0.0 to 1.0)
  ///
  PageController _pageCtrl;

  /// Start Date from each page
  /// the selected page is on index 1,
  /// 0 is for previous 12 years,
  /// 2 is for next 12 years
  List<DateTime> _pageDates = List(3);

  /// Selected DateTime
  List<DateTime> _selectedDateTimes = [];

  /// Marks whether the date range [SelectionType.range] is selected on both ends
  bool _selectRangeIsComplete = false;

  /// Array for each boxes position and size
  ///
  /// each boxes position and size is stored for the first time and after they
  /// are rendered, since their size and position at full extension is always
  /// the same. Later will be used by [MonthCalender] to squeezed its whole content
  /// as big as one of these boxes and in its position, according to its year
  /// value
  List<Rect> boxRects = List(12);

  /// Opacity controller for this
  ///
  /// This Opacity Controller is kinda different from [MonthCalendar]'s
  /// Since this AnimationController's value is reversed from [MonthCalendar]
  /// Explanation:
  /// [MonthCalendar.dayMonthAnim]'s 0.0 value would mean hidden for [MonthCalendar]
  /// and
  /// [MonthCalendar.dayMonthAnim]'s 1.0 value would mean shown for [MonthCalendar]
  ///
  /// therefore
  ///
  /// [MonthCalendar.opacityCtrl]'s 0.0 value would mean hidden for [MonthCalendar]
  /// and
  /// [MonthCalendar.opacityCtrl]'s 1.0 value would mean shown for [MonthCalendar]
  ///
  /// in order for [MonthCalendar]'s title can be tapped, it has to be in its full
  /// extension size ([MonthCalendar.opacityCtrl]'s 1.0 value) and when
  /// [MonthCalendar]'s title is tapped (_handleMonthTitleTapped), it has to reverse
  /// [MonthCalendar.opacityCtrl]'s value from 1.0 to 0.0, and if we link it to
  /// [MonthCalendar.monthYearCtrl] which is [this.monthYearCtrl] also,
  /// 0.0 would mean shown for this, thus, 1.0 would mean hidden.
  ///
  /// therefore
  ///
  /// this' opacity would be [1.0 - opacityCtrl.value]
  AnimationController opacityCtrl;

  @override
  initState() {
    super.initState();

    /// if the [pickType] is year, then show this as front page,
    /// (there will be no [DayCalendar] and [MonthCalendar], otherwise,
    /// hide this and wait until [MonthCalendar] request to be shown
    ///
    /// See [_handleMonthTitleTapped]
    opacityCtrl = AnimationController(
        duration: Duration(milliseconds: _kAnimationDuration),
        vsync: this,
        value: widget.pickType == PickType.year ? 0.0 : 1.0);

    /// Change opacity controller's value equals month year controller's value
    widget.monthYearAnim.addListener(() {
      opacityCtrl.value = widget.monthYearAnim.value;
    });

    _selectedDateTimes = widget.selectedDateTimes;

    _selectRangeIsComplete =
        widget.selectionType == SelectionType.range && _selectedDateTimes.length % 2 == 0;

    /// setup pageController
    _pageCtrl = PageController(
      initialPage: 1,
      keepPage: true,
      viewportFraction: widget.calendarStyle.viewportFraction,

      /// width percentage
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
  Widget build(BuildContext ccontext) {
    return AnimatedBuilder(
        animation: opacityCtrl,
        builder: (BuildContext parentContext, Widget child) {
          /// this opacity is kinda different from [MonthCalendar]
          ///
          /// See [opacityCtrl]
          return Opacity(
            opacity: 1.0 - opacityCtrl.value,
            child: Column(
              children: <Widget>[
                Container(
                  margin: widget.calendarStyle.headerMargin,
                  child: DefaultTextStyle(
                    style: widget.calendarStyle.defaultHeaderTextStyle,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          onPressed: () => _setPage(page: 0),
                          icon: Icon(
                            widget.calendarStyle.iconPrevious,
                            color: widget.calendarStyle.iconColor,
                          ),
                        ),
                        Container(
                          child: Text(
                            '${this._pageDates[1].year + 1} - ${this._pageDates[1].year + 12}',
                          ),
                        ),
                        IconButton(
                          onPressed: () => _setPage(page: 2),
                          icon: Icon(
                            widget.calendarStyle.iconNext,
                            color: widget.calendarStyle.iconColor,
                          ),
                        ),
                      ],
                    ),
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
                      return _buildCalendar(index);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  _buildCalendar(int slideIndex) {
    int year = this._pageDates[slideIndex].year;

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: widget.isLandscape ? 6 : 4,
      childAspectRatio: widget.calendarStyle.childAspectRatio,
      padding: EdgeInsets.zero,
      children: List.generate(12, (index) {
        bool isToday = DateTime.now().year == year + index + 1;
        DateTime currentDate = DateTime(year + index + 1);
        bool isSelectedDay = (widget.selectionType != SelectionType.range &&
            _selectedDateTimes.length > 0 &&
            _selectedDateTimes.where((loopDate) => loopDate.year == currentDate.year).length >
                0) ||
            (widget.selectionType == SelectionType.range &&
                _selectedDateTimes.length == 2 &&
                currentDate.year > _selectedDateTimes.first.year &&
                currentDate.year < _selectedDateTimes.last.year);
        bool isStartEndDay = _selectedDateTimes.length > 0 &&
            ((widget.selectionType == SelectionType.range &&
                ((_selectedDateTimes.first.year == currentDate.year) ||
                    (_selectedDateTimes.last.year == currentDate.year))) ||
                (widget.selectionType != SelectionType.range &&
                    _selectedDateTimes.length > 0 &&
                    _selectedDateTimes
                        .where((loopDate) => loopDate.year == currentDate.year)
                        .length >
                        0));

        TextStyle textStyle;
        Color borderColor;
        Color boxColor;
        if (isStartEndDay && widget.calendarStyle.selectedDayButtonColor != null) {
          textStyle = widget.calendarStyle.defaultSelectedDayTextStyle;
          boxColor = widget.calendarStyle.selectedDayButtonColor;
          borderColor = widget.calendarStyle.thisMonthDayBorderColor;
        } else if (isSelectedDay) {
          textStyle = widget.calendarStyle.defaultSelectedDayTextStyle;
          boxColor = widget.calendarStyle.selectedDayButtonColor.withAlpha(150);
          borderColor = widget.calendarStyle.thisMonthDayBorderColor;
        } else if (isToday) {
          textStyle = widget.calendarStyle.defaultTodayTextStyle;
          boxColor = widget.calendarStyle.todayButtonColor;
          borderColor = widget.calendarStyle.todayBorderColor;
        } else {
          textStyle = widget.calendarStyle.defaultDaysTextStyle;
          boxColor = widget.calendarStyle.dayButtonColor;
          borderColor = widget.calendarStyle.thisMonthDayBorderColor;
        }

        bool availableDate = currentDate.year >= (widget.minDate?.year ?? currentDate.year) &&
            currentDate.year <= (widget.maxDate?.year ?? currentDate.year);

        TextStyle fixedTextStyle = isToday ? widget.calendarStyle.defaultTodayTextStyle : textStyle;

        return Builder(builder: (BuildContext context) {
          /// if [index]' boxRect is still null, set post frame callback to
          /// set boxRect after first render
          if (boxRects[index] == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              RenderBox renderBox = context.findRenderObject();
              RenderBox mainRenderBox = widget.mainContext.findRenderObject();
              var offset = renderBox.localToGlobal(Offset.zero, ancestor: mainRenderBox);
              var size = renderBox.size;
              Rect rect = Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height);
              boxRects[index] = rect;
            });
          }

          return Container(
            margin: EdgeInsets.all(widget.calendarStyle.dayPadding),
            child: IgnorePointer(
              ignoring: !availableDate,
              child: FlatButton(
                color: availableDate ? boxColor : Color.lerp(lerpColor, boxColor, 0.8),
                onPressed: () => _handleYearBoxTapped(context, currentDate.year),
                padding: EdgeInsets.all(widget.calendarStyle.dayPadding),
                shape: (widget.calendarStyle.daysHaveCircularBorder ?? false)
                    ? CircleBorder(
                  side: BorderSide(color: borderColor),
                )
                    : RoundedRectangleBorder(
                  side: BorderSide(color: borderColor),
                ),
                child: Center(
                  child: Text(
                    "${currentDate.year}",
                    style: availableDate
                        ? fixedTextStyle
                        : fixedTextStyle.copyWith(
                        color: Color.lerp(lerpColor, fixedTextStyle.color, 0.5)),
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          );
        });
      }),
    );
  }

  void _handleSubmitTapped() {
    if (widget.onDayPressed != null) widget.onDayPressed(_selectedDateTimes);
  }

  void _handleYearBoxTapped(BuildContext context, int year) {
    /// check if whether this picker is enabled to pick only year
    if (widget.pickType != PickType.year) {
      /// unless the whole content is shown, cannot tap on year
      if (widget.monthYearAnim.value != 0.0 ||
          widget.monthYearAnim.status != AnimationStatus.dismissed) return;

      MonthCalendarState monthState = widget.monthKey.currentState;

      RenderBox yearBoxRenderBox = context.findRenderObject();
      Size yearBoxSize = yearBoxRenderBox.size;
      Offset yearBoxOffset = yearBoxRenderBox.localToGlobal(Offset.zero,
          ancestor: widget.mainContext.findRenderObject());
      Rect yearBoxRect =
      Rect.fromLTWH(yearBoxOffset.dx, yearBoxOffset.dy, yearBoxSize.width, yearBoxSize.height);

      RenderBox fullRenderBox = widget.mainContext.findRenderObject();
      Offset fullOffset = Offset.zero;
      Size fullSize = fullRenderBox.size;
      Rect fullRect = Rect.fromLTWH(fullOffset.dx, fullOffset.dy, fullSize.width, fullSize.height);

      monthState.setState(() {
        monthState.setYear(year);
        monthState.rectTween = RectTween(begin: yearBoxRect, end: fullRect);
        widget.monthYearAnim.forward();
      });
    } else {
      //pick year
      DateTime currentDate = DateTime(year);
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

          if (widget.onDayPressed != null) widget.onDayPressed(_selectedDateTimes);
        } else {
          _selectedDateTimes.clear();
          _selectedDateTimes.add(currentDate);
        }

        _selectRangeIsComplete = !_selectRangeIsComplete;
      }

      setState(() {});
    }
  }

  void _setPage({int page}) {
    /// for initial set
    if (page == null) {
      int year = (DateTime.now().year / 12).floor();

      DateTime date0 = DateTime((year - 1) * 12);
      DateTime date1 = DateTime(year * 12);
      DateTime date2 = DateTime((year + 1) * 12);

      this.setState(() {
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
        int year = (dates[0].year / 12).floor();
        if (year < 0) return;
        dates[2] = DateTime((year + 1) * 12);
        dates[1] = DateTime(year * 12);
        dates[0] = DateTime((year - 1) * 12);
        page = page + 1;
      } else if (page == 2) {
        /// next page
        int year = (dates[2].year / 12).floor();
        dates[0] = DateTime((year - 1) * 12);
        dates[1] = DateTime(year * 12);
        dates[2] = DateTime((year + 1) * 12);
        page = page - 1;
      }

      this.setState(() {
        this._pageDates = dates;
      });

      /// animate to page right away after reset the values
      _pageCtrl.animateToPage(page, duration: Duration(milliseconds: 1), curve: Threshold(0.0));
    }
  }

  /// an open method for [MonthCalendar] to trigger whenever it itself changes
  /// its year value
  void setYear(int year) {
    int pageYear = (year / 12).floor();

    List<DateTime> dates = List(3);
    dates[0] = DateTime((pageYear - 1) * 12);
    dates[1] = DateTime(pageYear * 12);
    dates[2] = DateTime((pageYear + 1) * 12);

    this.setState(() {
      this._pageDates = dates;
    });
  }

  void updateSelectedDateTimes(List<DateTime> selectedDateTimes) {
    setState(() {
      _selectedDateTimes = selectedDateTimes;
    });
  }

  /// get boxes size by index
  Rect getBoxRectFromIndex(int index) => boxRects[index];
}