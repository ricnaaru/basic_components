part of adv_date_picker;

class MonthCalendar extends StatefulWidget {
  final BuildContext mainContext;
  final GlobalKey<DayCalendarState> dayKey;
  final GlobalKey<YearCalendarState> yearKey;
  final AnimationController dayMonthAnim;
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

  MonthCalendar({
    this.isLandscape,
    this.mainContext,
    Key key,
    this.dayKey,
    this.yearKey,
    this.dayMonthAnim,
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
  MonthCalendarState createState() => MonthCalendarState();
}

class MonthCalendarState extends State<MonthCalendar> with TickerProviderStateMixin {
  /// The first run, this will be shown (0.0 [widget.dayMonthAnim]'s value)
  ///
  /// After the first run, when [widget.dayMonthAnim]'s value is 0.0, this will
  /// be gone
  ///
  /// When the [DayCalendar]'s title is tapped [_handleDayTitleTapped],
  /// we will give this the fade in animation ([widget.dayMonthAnim]'s value
  /// will gradually change from 0.0 to 1.0)
  ///
  /// When one of this' boxes is tapped [_handleMonthBoxTapped], we will give
  /// this the fade out animation ([widget.dayMonthAnim]'s value will gradually
  /// change from 1.0 to 0.0)
  ///
  /// When this title is tapped [_handleMonthTitleTapped],
  /// we will give this the fade out animation ([widget.monthYearAnim]'s value
  /// will gradually change from 1.0 to 0.0)
  ///
  /// When one of [YearCalendar]'s boxes is tapped [_handleYearBoxTapped],
  /// we will give this the fade in animation ([widget.monthYearAnim]'s value
  /// will gradually change from 0.0 to 1.0)

  /// Page Controller
  PageController _pageCtrl;

  /// Start Date from each page
  /// the selected page is on index 1,
  /// 0 is for previous year,
  /// 2 is for next year
  List<DateTime> _pageDates = List(3);

  /// Selected DateTime
  List<DateTime> _selectedDateTimes = [];

  /// Marks whether the date range [SelectionType.range] is selected on both ends
  bool _selectRangeIsComplete = false;

  /// Array for each boxes position and size
  ///
  /// each boxes position and size is stored for the first time and after they
  /// are rendered, since their size and position at full extension is always
  /// the same. Later will be used by [DayCalender] to squeezed its whole content
  /// as big as one of these boxes and in its position, according to its month
  /// value
  List<Rect> boxRects = List(12);

  /// Opacity controller for [MonthCalender]
  AnimationController opacityCtrl;

  /// Transition that this Widget will go whenever [DayCalendar]' title is tapped
  /// [_handleDayTitleTapped] or one of this' boxes is tapped [_handleMonthBoxTapped]
  ///
  /// or
  ///
  /// whenever this' title is tapped [_handleMonthTitleTapped] or one of
  /// [YearCalendar]'s boxes is tapped [_handleYearBoxTapped]
  ///
  /// This tween will always begin from one of [YearCalendar]'s boxes offset and size
  /// and end to full expanded offset and size
  Tween<Rect> rectTween;

  /// On the first run, [MonthCalendar] will need to be drawn so [boxRects] will
  /// be set
  bool _firstRun = true;

  @override
  initState() {
    super.initState();

    /// if the [pickType] is month, then show [MonthCalendar] as front page,
    /// (there will be no [DayCalendar], otherwise, hide [MonthCalendar] and
    /// wait until [DayCalendar] request to be shown
    ///
    /// See [_handleDayTitleTapped]
    opacityCtrl = AnimationController(
        duration: Duration(milliseconds: _kAnimationDuration),
        vsync: this,
        value: widget.pickType == PickType.month ? 1.0 : 0.0);

    /// Change opacity controller's value equals month year controller's value
    widget.dayMonthAnim.addListener(() {
      opacityCtrl.value = widget.dayMonthAnim.value;
    });

    /// Whenever month to year animation is finished, reset rectTween to null
    /// Also change opacity controller's value equals month year controller's value
    widget.monthYearAnim.addListener(() {
      opacityCtrl.value = widget.monthYearAnim.value;

      if (widget.monthYearAnim.status == AnimationStatus.completed ||
          widget.monthYearAnim.status == AnimationStatus.dismissed) {
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

    /// Switch firstRun's value to false after the first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _firstRun = false;
    });
  }

  @override
  dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext parentContext) {
    Widget monthContent = _buildMonthContent(parentContext);

    return AnimatedBuilder(
        animation: opacityCtrl,
        builder: (BuildContext context, Widget child) {
          if (rectTween == null)
            return AdvVisibility(
                visibility: opacityCtrl.value == 0.0 && !_firstRun
                    ? VisibilityFlag.gone
                    : VisibilityFlag.visible,
                child: Opacity(opacity: opacityCtrl.value, child: monthContent));

          /// rect tween set when one of these two occasions occurs
          /// 1. Month Title tapped so it has to be squeezed inside year boxes
          ///
          ///     See also [_handleMonthTitleTapped]
          /// 2. One of year boxes is tapped, so Month content should be expanded
          ///     See also [_handleMonthBoxTapped]

          /// calculate lerp of destination rect according to current
          /// widget.dayMonthAnim.value or widget.monthYearAnim.value
          final Rect destRect = rectTween.evaluate(opacityCtrl);

          /// minus padding for each horizontal and vertical axis
          final Size destSize = Size(destRect.size.width - (widget.calendarStyle.dayPadding * 2),
              destRect.size.height - (widget.calendarStyle.dayPadding * 2));
          final double top = destRect.top + widget.calendarStyle.dayPadding;
          final double left = destRect.left + widget.calendarStyle.dayPadding;

          double xFactor = destSize.width / rectTween.end.width;
          double yFactor = destSize.height / rectTween.end.height;

          final Matrix4 transform = Matrix4.identity()..scale(xFactor, yFactor, 1.0);

          /// For the Width and Height :
          /// keep the initial size, so we can achieve destination scale
          /// example :
          /// rectTween.end.width * destSize.width / rectTween.end.width => destSize.width

          /// For the Opacity :
          /// as the scaling goes from 0.0 to 1.0, we progressively change the opacity
          ///
          /// Note: to learn how these animations controller's value work,
          /// read the documentation at start of this State's script
          return Positioned(
              top: top,
              width: rectTween.end.width,
              height: rectTween.end.height,
              left: left,
              child: Opacity(
                  opacity: opacityCtrl.value,
                  child: Transform(transform: transform, child: monthContent)));
        });
  }

  _buildMonthContent(BuildContext parentContext) {
    return Column(
      children: <Widget>[
        AdvRow(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () => _setPage(page: 0),
              icon: Icon(
                widget.calendarStyle.iconPrevious,
                color: widget.calendarStyle.iconColor,
              ),
            ),
            Builder(builder: (BuildContext childContext) {
              return Expanded(
                child: InkWell(
                  child: Container(
                    margin: widget.calendarStyle.headerMargin,
                    child: Text(
                      '${this._pageDates[1].year}',
                      textAlign: TextAlign.center,
                      style: widget.calendarStyle.defaultHeaderTextStyle,
                    ),
                  ),
                  onTap: () => _handleMonthTitleTapped(parentContext),
                ),
              );
            }),
            IconButton(
              onPressed: () => _setPage(page: 2),
              icon: Icon(
                widget.calendarStyle.iconNext,
                color: widget.calendarStyle.iconColor,
              ),
            ),
          ],
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
    );
  }

  _buildCalendar(int slideIndex) {
    int year = this._pageDates[slideIndex].year;

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: widget.isLandscape ? 6 : 4,
      childAspectRatio: widget.calendarStyle.childAspectRatio,
      padding: EdgeInsets.zero,
      children: List.generate(12, (index) {
        DateTime currentDate = DateTime(year, index + 1, 1);
        int currentDateInt = int.tryParse("$year${index + 1}");
        bool isToday =
            DateTime.now().month == currentDate.month && DateTime.now().year == currentDate.year;

        DateTime firstDate = _selectedDateTimes.length == 2 ? _selectedDateTimes.first : null;
        int firstDateInt = _selectedDateTimes.length == 2
            ? int.tryParse("${firstDate.year}${firstDate.month}")
            : 0;

        DateTime lastDate = _selectedDateTimes.length == 2 ? _selectedDateTimes.last : null;
        int lastDateInt =
        _selectedDateTimes.length == 2 ? int.tryParse("${lastDate.year}${lastDate.month}") : 0;

        bool isSelectedDay = (widget.selectionType != SelectionType.range &&
            _selectedDateTimes.length > 0 &&
            _selectedDateTimes
                .where((loopDate) =>
            loopDate.month == currentDate.month &&
                loopDate.year == currentDate.year)
                .length >
                0) ||
            (widget.selectionType == SelectionType.range &&
                _selectedDateTimes.length == 2 &&
                currentDateInt > firstDateInt &&
                currentDateInt < lastDateInt);

        bool isStartEndDay = _selectedDateTimes.length > 0 &&
            ((widget.selectionType == SelectionType.range &&
                _selectedDateTimes.length == 2 &&
                ((_selectedDateTimes.first.month == currentDate.month &&
                    _selectedDateTimes.first.year == currentDate.year) ||
                    (_selectedDateTimes.last.month == currentDate.month &&
                        _selectedDateTimes.last.year == currentDate.year))) ||
                (widget.selectionType != SelectionType.range &&
                    _selectedDateTimes.length > 0 &&
                    _selectedDateTimes
                        .where((loopDate) =>
                    loopDate.month == currentDate.month &&
                        loopDate.year == currentDate.year)
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

        int currentDateLong =
        int.tryParse("${currentDate.year}${StringHelper.leadingZeroInt(currentDate.month, 2)}");
        int minDateLong = int.tryParse(
            "${widget.minDate?.year ?? currentDate.year}${StringHelper.leadingZeroInt(widget.minDate?.month ?? currentDate.month, 2)}");
        int maxDateLong = int.tryParse(
            "${widget.maxDate?.year ?? currentDate.year}${StringHelper.leadingZeroInt(widget.maxDate?.month ?? currentDate.month, 2)}");

        bool availableDate = currentDateLong >= minDateLong && currentDateLong <= maxDateLong;

        return Builder(
          builder: (BuildContext context) {
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
                  onPressed: () => _handleMonthBoxTapped(context, index + 1, year),
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
                      '${BasicComponents.datePicker.monthsArray[currentDate.month - 1]}',
                      style: availableDate
                          ? textStyle
                          : textStyle.copyWith(color: Color.lerp(lerpColor, textStyle.color, 0.5)),
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _handleSubmitTapped() {
    if (widget.onDayPressed != null) widget.onDayPressed(_selectedDateTimes);
  }

  void _handleMonthTitleTapped(BuildContext context) {
    /// unless the whole content is fully expanded, cannot tap on title
    if (widget.monthYearAnim.value != 1.0) return;

    int yearMod = this._pageDates[1].year % 12;
    Rect boxRect =
    widget.yearKey.currentState.getBoxRectFromIndex((yearMod == 0 ? 12 : yearMod) - 1);

    RenderBox fullRenderBox = context.findRenderObject();
    var fullSize = fullRenderBox.size;
    var fullOffset = Offset.zero;

    Rect fullRect = Rect.fromLTWH(fullOffset.dx, fullOffset.dy, fullSize.width, fullSize.height);

    rectTween = RectTween(begin: boxRect, end: fullRect);

    setState(() {
      widget.monthYearAnim.reverse();
    });
  }

  void _handleMonthBoxTapped(BuildContext context, int month, int year) {
    /// check if whether this picker is enabled to pick only month and year
    if (widget.pickType != PickType.month) {
      /// unless the whole content is fully expanded, cannot tap on month
      if (widget.dayMonthAnim.value != 1.0 ||
          widget.dayMonthAnim.status != AnimationStatus.completed) return;
      if (widget.monthYearAnim.value != 1.0 ||
          widget.monthYearAnim.status != AnimationStatus.completed) return;

      DayCalendarState dayState = widget.dayKey.currentState;

      RenderBox monthBoxRenderBox = context.findRenderObject();
      Size monthBoxSize = monthBoxRenderBox.size;
      Offset monthBoxOffset = monthBoxRenderBox.localToGlobal(Offset.zero,
          ancestor: widget.mainContext.findRenderObject());
      Rect monthBoxRect = Rect.fromLTWH(
          monthBoxOffset.dx, monthBoxOffset.dy, monthBoxSize.width, monthBoxSize.height);

      RenderBox fullRenderBox = widget.mainContext.findRenderObject();
      var fullSize = fullRenderBox.size;
      var fullOffset = Offset.zero;
      Rect fullRect = Rect.fromLTWH(fullOffset.dx, fullOffset.dy, fullSize.width, fullSize.height);

      dayState.setState(() {
        dayState.setMonth(month, year);
        dayState.rectTween = RectTween(begin: fullRect, end: monthBoxRect);
        widget.dayMonthAnim.reverse();
      });
    } else {
      //pick month
      DateTime currentDate = DateTime(year, month);

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
      DateTime date0 = DateTime(DateTime.now().year - 1);
      DateTime date1 = DateTime(DateTime.now().year);
      DateTime date2 = DateTime(DateTime.now().year + 1);

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
        dates[2] = DateTime(dates[0].year + 1);
        dates[1] = DateTime(dates[0].year);
        dates[0] = DateTime(dates[0].year - 1);
        page = page + 1;
      } else if (page == 2) {
        /// next page
        dates[0] = DateTime(dates[2].year - 1);
        dates[1] = DateTime(dates[2].year);
        dates[2] = DateTime(dates[2].year + 1);
        page = page - 1;
      }

      this.setState(() {
        this._pageDates = dates;
      });

      /// animate to page right away after reset the values
      _pageCtrl.animateToPage(page, duration: Duration(milliseconds: 1), curve: Threshold(0.0));

      /// set year on [YearCalendar]
      widget.yearKey.currentState.setYear(_pageDates[1].year);
    }
  }

  /// an open method for [DayCalendar] to trigger whenever it itself changes
  /// its month value
  void setMonth(int month, int year) {
    List<DateTime> dates = List(3);
    dates[0] = DateTime(year, month - 1, 1);
    dates[1] = DateTime(year, month, 1);
    dates[2] = DateTime(year, month + 1, 1);

    this.setState(() {
      this._pageDates = dates;
    });
  }

  /// an open method for [DayCalendar] or [YearCalendar] to trigger whenever it
  /// itself changes its month value
  void setYear(int year) {
    List<DateTime> dates = List(3);
    int month = _pageDates[1].month;
    dates[0] = DateTime(year - 1, month, 1);
    dates[1] = DateTime(year, month, 1);
    dates[2] = DateTime(year + 1, month, 1);

    this.setState(() {
      this._pageDates = dates;
    });
  }

  void updateSelectedDateTimes(List<DateTime> selectedDateTimes) {
    setState(() {
      _selectedDateTimes = selectedDateTimes;
    });

    widget.yearKey.currentState.updateSelectedDateTimes(selectedDateTimes);
  }

  /// get boxes size by index
  Rect getBoxRectFromIndex(int index) => boxRects[index];
}