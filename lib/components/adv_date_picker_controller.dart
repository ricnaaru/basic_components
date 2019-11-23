part of adv_date_picker;

class AdvDatePickerController extends ValueNotifier<AdvDatePickerValue> {
  DateTime get date => value.date;

  set date(DateTime newDate) {
    value = value.copyWith(
      date: newDate,
      minDate: this.minDate,
      maxDate: this.maxDate,
      dates: this.dates,
      error: this.error,
      enabled: this.enabled,
      obscureText: this.obscureText,
    );
  }

  DateTime get minDate => value.minDate;

  set minDate(DateTime newMinDate) {
    value = value.copyWith(
      date: this.date,
      minDate: newMinDate,
      maxDate: this.maxDate,
      dates: this.dates,
      error: this.error,
      enabled: this.enabled,
      obscureText: this.obscureText,
    );
  }

  DateTime get maxDate => value.maxDate;

  set maxDate(DateTime newMaxDate) {
    value = value.copyWith(
      date: this.date,
      minDate: this.minDate,
      maxDate: newMaxDate,
      dates: this.dates,
      error: this.error,
      enabled: this.enabled,
      obscureText: this.obscureText,
    );
  }

  List<DateTime> get dates => value.dates;

  set dates(List<DateTime> newDates) {
    value = value.copyWith(
      date: this.date,
      minDate: this.minDate,
      maxDate: this.maxDate,
      dates: newDates,
      error: this.error,
      enabled: this.enabled,
      obscureText: this.obscureText,
    );
  }

  String get error => value.error;

  set error(String newError) {
    value = value.copyWith(
      date: this.date,
      minDate: this.minDate,
      maxDate: this.maxDate,
      dates: this.dates,
      error: newError,
      enabled: this.enabled,
      obscureText: this.obscureText,
    );
  }

  bool get enabled => value.enabled;

  set enabled(bool newenabled) {
    value = value.copyWith(
      date: this.date,
      minDate: this.minDate,
      maxDate: this.maxDate,
      dates: this.dates,
      error: this.error,
      enabled: newenabled,
      obscureText: this.obscureText,
    );
  }

  bool get obscureText => value.obscureText;

  set obscureText(bool newObscureText) {
    value = value.copyWith(
      date: this.date,
      minDate: this.minDate,
      maxDate: this.maxDate,
      dates: this.dates,
      error: this.error,
      enabled: this.enabled,
      obscureText: newObscureText,
    );
  }

  AdvDatePickerController({
    DateTime date,
    DateTime minDate,
    DateTime maxDate,
    List<DateTime> dates,
    String error,
    bool enabled,
    bool obscureText,
  }) : super(
          date == null &&
                  minDate == null &&
                  maxDate == null &&
                  dates == null &&
                  error == null &&
                  enabled == null &&
                  obscureText == null
              ? AdvDatePickerValue.empty
              : new AdvDatePickerValue(
                  date: date,
                  minDate: minDate,
                  maxDate: maxDate,
                  dates: dates,
                  error: error,
                  enabled: enabled ?? true,
                  obscureText: obscureText ?? false,
                ),
        );

  AdvDatePickerController.fromValue(AdvDatePickerValue value)
      : super(value ?? AdvDatePickerValue.empty);

  void clear() {
    value = AdvDatePickerValue.empty;
  }
}

@immutable
class AdvDatePickerValue {
  const AdvDatePickerValue({
    this.date,
    this.minDate,
    this.maxDate,
    this.dates,
    this.error,
    this.enabled = true,
    this.obscureText = false,
  });

  final DateTime date;
  final DateTime minDate;
  final DateTime maxDate;
  final List<DateTime> dates;
  final String error;
  final bool enabled;
  final bool obscureText;

  static const AdvDatePickerValue empty = const AdvDatePickerValue();

  AdvDatePickerValue copyWith({
    DateTime date,
    DateTime minDate,
    DateTime maxDate,
    List<DateTime> dates,
    String error,
    bool enabled,
    bool obscureText,
  }) {
    return new AdvDatePickerValue(
      date: date,
      minDate: minDate,
      maxDate: maxDate,
      dates: dates,
      error: error,
      enabled: enabled,
      obscureText: obscureText,
    );
  }

  AdvDatePickerValue.fromValue(AdvDatePickerValue copy)
      : this.date = copy.date,
        this.minDate = copy.minDate,
        this.maxDate = copy.maxDate,
        this.dates = copy.dates,
        this.error = copy.error,
        this.enabled = copy.enabled,
        this.obscureText = copy.obscureText;

  @override
  String toString() =>
      '$runtimeType(date: \u2524$date\u251C, minDate: \u2524$minDate\u251C, maxDate: \u2524$maxDate\u251C, dates: $dates, error: \u2524$error\u251C, enabled: $enabled, obscureText: $obscureText)';

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (other is! AdvDatePickerValue) return false;
    final AdvDatePickerValue typedOther = other;
    return typedOther.date == date &&
        typedOther.minDate == minDate &&
        typedOther.maxDate == maxDate &&
        typedOther.dates == dates &&
        typedOther.error == error &&
        typedOther.enabled == enabled &&
        typedOther.obscureText == obscureText;
  }

  @override
  int get hashCode => hashValues(
      date.hashCode, minDate.hashCode, maxDate.hashCode, dates.hashCode, error.hashCode, enabled.hashCode, obscureText.hashCode);
}
