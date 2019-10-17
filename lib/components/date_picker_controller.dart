part of date_picker;

class DatePickerController extends ValueNotifier<DatePickerValue> {
  String get text => value.text;

  set text(String newText) {
    value = value.copyWith(
      text: newText,
      dates: this.dates,
      error: this.error,
      enabled: this.enabled,
      obscureText: this.obscureText,
    );
  }

  List<DateTime> get dates => value.dates;

  set dates(List<DateTime> newDates) {
    value = value.copyWith(
      text: this.text,
      dates: newDates,
      error: this.error,
      enabled: this.enabled,
      obscureText: this.obscureText,
    );
  }

  String get error => value.error;

  set error(String newError) {
    value = value.copyWith(
      text: this.text,
      dates: this.dates,
      error: newError,
      enabled: this.enabled,
      obscureText: this.obscureText,
    );
  }

  bool get enabled => value.enabled;

  set enabled(bool newenabled) {
    value = value.copyWith(
      text: this.text,
      dates: this.dates,
      error: this.error,
      enabled: newenabled,
      obscureText: this.obscureText,
    );
  }

  bool get obscureText => value.obscureText;

  set obscureText(bool newObscureText) {
    value = value.copyWith(
      text: this.text,
      dates: this.dates,
      error: this.error,
      enabled: this.enabled,
      obscureText: newObscureText,
    );
  }

  DatePickerController({
    String text,
    List<DateTime> dates,
    String error,
    bool enabled,
    bool obscureText,
  }) : super(
            text == null && dates == null && error == null && enabled == null && obscureText == null
                ? DatePickerValue.empty
                : new DatePickerValue(
                    text: text,
                    dates: dates,
                    error: error,
                    enabled: enabled ?? true,
                    obscureText: obscureText ?? false,
                  ));

  DatePickerController.fromValue(DatePickerValue value) : super(value ?? DatePickerValue.empty);

  void clear() {
    value = DatePickerValue.empty;
  }
}

@immutable
class DatePickerValue {
  const DatePickerValue({
    this.text = '',
    this.dates,
    this.error,
    this.enabled = true,
    this.obscureText = false,
  });

  final String text;
  final List<DateTime> dates;
  final String error;
  final bool enabled;
  final bool obscureText;

  static const DatePickerValue empty = const DatePickerValue();

  DatePickerValue copyWith({
    String text,
    List<DateTime> dates,
    String error,
    bool enabled,
    bool obscureText,
  }) {
    return new DatePickerValue(
      text: text,
      dates: dates,
      error: error,
      enabled: enabled,
      obscureText: obscureText,
    );
  }

  DatePickerValue.fromValue(DatePickerValue copy)
      : this.text = copy.text,
        this.dates = copy.dates,
        this.error = copy.error,
        this.enabled = copy.enabled,
        this.obscureText = copy.obscureText;

  @override
  String toString() =>
      '$runtimeType(text: \u2524$text\u251C, dates: $dates, error: \u2524$error\u251C, enabled: $enabled, obscureText: $obscureText)';

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (other is! DatePickerValue) return false;
    final DatePickerValue typedOther = other;
    return typedOther.text == text &&
        typedOther.dates == dates &&
        typedOther.error == error &&
        typedOther.enabled == enabled &&
        typedOther.obscureText == obscureText;
  }

  @override
  int get hashCode =>
      hashValues(text.hashCode, dates.hashCode, error.hashCode, enabled.hashCode, obscureText.hashCode);
}
