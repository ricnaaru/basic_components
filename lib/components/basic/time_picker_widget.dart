part of time_picker;

class TimePickerWidget extends StatefulWidget {
  final DateTime time;
  final TimePickType timePickType;
  final bool isTwelveHourFormat;
  final String buttonName;
  final String title;

  const TimePickerWidget({
    Key key,
    this.time,
    this.timePickType,
    this.isTwelveHourFormat,
    this.buttonName,
    this.title,
  }) : super(key: key);

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  FixedExtentScrollController _hourController = FixedExtentScrollController();
  FixedExtentScrollController _minuteController = FixedExtentScrollController();
  FixedExtentScrollController _secondController = FixedExtentScrollController();
  int _hour;
  int _minute = 0;
  int _second = 0;
  String _ampm;
  DateTime _now = DateTime.now();
  DateTime _result;

  @override
  void initState() {
    if (widget.isTwelveHourFormat) _ampm = "AM";

    _hour =
    widget.isTwelveHourFormat ? Constant.hours12[0] : Constant.hours24[0];
    if (widget.time != null) {
      _hour = widget.time.hour;
      if (widget.isTwelveHourFormat) {
        if (_hour > 11) {
          _hour -= 12;
          _ampm = "PM";
        }
      }
      _minute = widget.time.minute;
      _second = widget.time.second;
    }

    _hourController = FixedExtentScrollController(initialItem: _hour - 1);
    _minuteController = FixedExtentScrollController(initialItem: _minute);
    _secondController = FixedExtentScrollController(initialItem: _second);

    _hourController.jumpToItem(_hour - 1);

    _result =
        DateTime(_now.year, _now.month, _now.day, _hour, _minute, _second);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget timePickerWidget;

    if (widget.timePickType == TimePickType.hour) {
      timePickerWidget = _hourWidget(context);
    } else if (widget.timePickType == TimePickType.hourMinute) {
      timePickerWidget = _hourMinutesWidget(context);
    } else if (widget.timePickType == TimePickType.hourMinuteSecond) {
      timePickerWidget = _hourMinuteSecondWidget(context);
    }

    return AdvColumn(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AdvListTile(
          padding: EdgeInsets.all(16.0),
          start: Icon(Icons.close),
          expanded: Text(widget.title,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        timePickerWidget,
        Container(
          margin: EdgeInsets.all(16.0),
          child: AdvButton.text(
            widget.buttonName,
            width: double.infinity,
            buttonSize: ButtonSize.large,
            bold: true,
            onPressed: () {
              _setResult();
              Navigator.pop(context, _result);
            },
          ),
        )
      ],
    );
  }

  Widget _hourWidget(BuildContext context) {
    ComponentThemeData componentTheme = ComponentTheme.of(context);

    return AdvRow(
      divider: RowDivider(16.0),
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ScrollableTimePicker(
            controller: _hourController,
            selectedColor: componentTheme.timePicker.selectedColor,
            nonSelectedColor: componentTheme.timePicker.nonSelectedColor,
            fontSize: componentTheme.timePicker.fontSize,
            callback: (result) {
              _hour = result;
            },
            dataList: widget.isTwelveHourFormat
                ? Constant.hours12
                : Constant.hours24),
        widget.isTwelveHourFormat ? _twelveHourFormatButton(context) : Container()
      ],
    );
  }

  Widget _hourMinutesWidget(BuildContext context) {
    ComponentThemeData componentTheme = ComponentTheme.of(context);

    return AdvRow(
      divider: RowDivider(32.0),
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AdvRow(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ScrollableTimePicker(
                controller: _hourController,
                selectedColor: componentTheme.timePicker.selectedColor,
                nonSelectedColor: componentTheme.timePicker.nonSelectedColor,
                fontSize: componentTheme.timePicker.fontSize,
                callback: (result) {
                  _hour = result;
                },
                dataList: widget.isTwelveHourFormat
                    ? Constant.hours12
                    : Constant.hours24),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(":",
                  style: TextStyle(
                      color: componentTheme.timePicker.nonSelectedColor,
                      fontSize: componentTheme.timePicker.fontSize),
                  textAlign: TextAlign.center),
            ),
            ScrollableTimePicker(
                controller: _minuteController,
                selectedColor: componentTheme.timePicker.selectedColor,
                nonSelectedColor: componentTheme.timePicker.nonSelectedColor,
                fontSize: componentTheme.timePicker.fontSize,
                callback: (result) {
                  _minute = result;
                },
                dataList: Constant.minutes),
          ],
        ),
        widget.isTwelveHourFormat ? _twelveHourFormatButton(context) : Container()
      ],
    );
  }

  Widget _hourMinuteSecondWidget(BuildContext context) {
    ComponentThemeData componentTheme = ComponentTheme.of(context);

    return AdvRow(
      divider: RowDivider(16.0),
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AdvRow(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ScrollableTimePicker(
                controller: _hourController,
                selectedColor: componentTheme.timePicker.selectedColor,
                nonSelectedColor: componentTheme.timePicker.nonSelectedColor,
                fontSize: componentTheme.timePicker.fontSize,
                callback: (result) {
                  _hour = result;
                },
                dataList: widget.isTwelveHourFormat
                    ? Constant.hours12
                    : Constant.hours24),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(":",
                  style: TextStyle(
                      color: componentTheme.timePicker.nonSelectedColor,
                      fontSize: componentTheme.timePicker.fontSize),
                  textAlign: TextAlign.center),
            ),
            ScrollableTimePicker(
                controller: _minuteController,
                selectedColor: componentTheme.timePicker.selectedColor,
                nonSelectedColor: componentTheme.timePicker.nonSelectedColor,
                fontSize: componentTheme.timePicker.fontSize,
                callback: (result) {
                  _minute = result;
                },
                dataList: Constant.minutes),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(":",
                  style: TextStyle(
                      color: componentTheme.timePicker.nonSelectedColor,
                      fontSize: componentTheme.timePicker.fontSize),
                  textAlign: TextAlign.center),
            ),
            ScrollableTimePicker(
                controller: _secondController,
                selectedColor: componentTheme.timePicker.selectedColor,
                nonSelectedColor: componentTheme.timePicker.nonSelectedColor,
                fontSize: componentTheme.timePicker.fontSize,
                callback: (result) {
                  _second = result;
                },
                dataList: Constant.minutes),
          ],
        ),
        widget.isTwelveHourFormat ? _twelveHourFormatButton(context) : Container()
      ],
    );
  }

  void _setResult() {
    int day = _now.day;
    if (widget.isTwelveHourFormat) {
      _hour = _hour == 12 ? 0 : _hour;
      if (_ampm == "PM") {
        if (_hour != 0) _hour = _hour + 12;
        if (_hour == 0) day = _now.day + 1;
      }
    }
    _result = DateTime(_now.year, _now.month, day, _hour, _minute, _second);
  }

  Widget _twelveHourFormatButton(BuildContext context) {
    ComponentThemeData componentTheme = ComponentTheme.of(context);

    return AdvColumn(
      divider: ColumnDivider(8.0),
      children: <Widget>[
        AdvButton.custom(
          child: Text('AM',
              style: componentTheme.timePicker.meridiemTextStyle.copyWith(
                  color: _ampm == "AM"
                      ? componentTheme.timePicker.meridiemTextStyle.color
                      : componentTheme.timePicker.meridiemButtonColor)),
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          primaryColor:
          _ampm == "AM" ? componentTheme.timePicker.meridiemButtonColor
              : componentTheme.timePicker.meridiemTextStyle.color,
          buttonSize: ButtonSize.large,
          bold: true,
          onPressed: () {
            if (this.mounted)
              setState(() {
                _ampm = "AM";
              });
          },
        ),
        AdvButton.custom(
          child: Text('PM',
              style: componentTheme.timePicker.meridiemTextStyle.copyWith(
                  color: _ampm == "PM"
                      ? componentTheme.timePicker.meridiemTextStyle.color
                      : componentTheme.timePicker.meridiemButtonColor)),
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          primaryColor:
          _ampm == "PM" ? componentTheme.timePicker.meridiemButtonColor
              : componentTheme.timePicker.meridiemTextStyle.color,
          buttonSize: ButtonSize.large,
          bold: true,
          onPressed: () {
            if (this.mounted)
              setState(() {
                _ampm = "PM";
              });
          },
        ),
      ],
    );
  }
}
