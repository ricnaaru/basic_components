part of adv_date_picker;

enum SelectionType { single, multi, range }

class MarkedDate {
  final DateTime date;
  final String note;

  MarkedDate(this.date, this.note);
}

class CalendarPage extends StatefulWidget {
  final String title;
  final List<DateTime> currentDate;
  final List<MarkedDate> markedDates;
  final SelectionType selectionType;
  final DateTime minDate;
  final DateTime maxDate;

  CalendarPage(
      {this.title, this.currentDate = const [],
        this.markedDates = const [],
        this.selectionType,
        this.minDate,
        this.maxDate});

  @override
  State createState() => new _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with SingleTickerProviderStateMixin {
  List<DateTime> _currentDate;
  SelectionType _selectionType;
  bool _datePicked = false;

  @override
  void initState() {
    super.initState();
    _selectionType = widget.selectionType ?? SelectionType.single;
    _currentDate = widget.currentDate ?? [DateTime.now()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(widget.title ?? ""),
        elevation: 1.0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        child: CalendarCarousel(
          selectionType: _selectionType,
          onDayPressed: (List<DateTime> dates) async {
            if (_datePicked) return;
            _datePicked = true;
            this.setState(() => _currentDate = dates);
            Navigator.pop(context, _currentDate);
          },
          selectedDateTimes: _currentDate,
          markedDates: widget.markedDates,
          minDate: widget.minDate,
          maxDate: widget.maxDate,
        ),
      ),
    );
  }
}
