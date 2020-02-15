part of adv_time_picker;

class AdvTimePickerController extends ValueNotifier<AdvTimePickerValue> {
  DateTime get time => value.time;

  set time(DateTime newTime) {
    value = value.copyWith(
      time: newTime,
      minTime: this.minTime,
      maxTime: this.maxTime,
      error: this.error,
      enabled: this.enabled,
      obscureText: this.obscureText,
    );
  }

  DateTime get minTime => value.minTime;

  set minTime(DateTime newMinTime) {
    value = value.copyWith(
      time: this.time,
      minTime: newMinTime,
      maxTime: this.maxTime,
      error: this.error,
      enabled: this.enabled,
      obscureText: this.obscureText,
    );
  }

  DateTime get maxTime => value.maxTime;

  set maxTime(DateTime newMaxTime) {
    value = value.copyWith(
      time: this.time,
      minTime: this.minTime,
      maxTime: newMaxTime,
      error: this.error,
      enabled: this.enabled,
      obscureText: this.obscureText,
    );
  }

  String get error => value.error;

  set error(String newError) {
    value = value.copyWith(
      time: this.time,
      minTime: this.minTime,
      maxTime: this.maxTime,
      error: newError,
      enabled: this.enabled,
      obscureText: this.obscureText,
    );
  }

  bool get enabled => value.enabled;

  set enabled(bool newenabled) {
    value = value.copyWith(
      time: this.time,
      minTime: this.minTime,
      maxTime: this.maxTime,
      error: this.error,
      enabled: newenabled,
      obscureText: this.obscureText,
    );
  }

  bool get obscureText => value.obscureText;

  set obscureText(bool newObscureText) {
    value = value.copyWith(
      time: this.time,
      minTime: this.minTime,
      maxTime: this.maxTime,
      error: this.error,
      enabled: this.enabled,
      obscureText: newObscureText,
    );
  }

  AdvTimePickerController({
    DateTime time,
    DateTime minTime,
    DateTime maxTime,
    String error,
    bool enabled,
    bool obscureText,
  }) : super(
          time == null &&
                  minTime == null &&
                  maxTime == null &&
                  error == null &&
                  enabled == null &&
                  obscureText == null
              ? AdvTimePickerValue.empty
              : new AdvTimePickerValue(
                  time: time,
                  minTime: minTime,
                  maxTime: maxTime,
                  error: error,
                  enabled: enabled ?? true,
                  obscureText: obscureText ?? false,
                ),
        );

  AdvTimePickerController.fromValue(AdvTimePickerValue value)
      : super(value ?? AdvTimePickerValue.empty);

  void clear() {
    value = AdvTimePickerValue.empty;
  }
}

@immutable
class AdvTimePickerValue {
  const AdvTimePickerValue({
    this.time,
    this.minTime,
    this.maxTime,
    this.error,
    this.enabled = true,
    this.obscureText = false,
  });

  final DateTime time;
  final DateTime minTime;
  final DateTime maxTime;
  final String error;
  final bool enabled;
  final bool obscureText;

  static const AdvTimePickerValue empty = const AdvTimePickerValue();

  AdvTimePickerValue copyWith({
    DateTime time,
    DateTime minTime,
    DateTime maxTime,
    String error,
    bool enabled,
    bool obscureText,
  }) {
    return new AdvTimePickerValue(
      time: time,
      minTime: minTime,
      maxTime: maxTime,
      error: error,
      enabled: enabled,
      obscureText: obscureText,
    );
  }

  AdvTimePickerValue.fromValue(AdvTimePickerValue copy)
      : this.time = copy.time,
        this.minTime = copy.minTime,
        this.maxTime = copy.maxTime,
        this.error = copy.error,
        this.enabled = copy.enabled,
        this.obscureText = copy.obscureText;

  @override
  String toString() =>
      '$runtimeType(time: \u2524$time\u251C, minTime: \u2524$minTime\u251C, maxTime: \u2524$maxTime\u251C, error: \u2524$error\u251C, enabled: $enabled, obscureText: $obscureText)';

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (other is! AdvTimePickerValue) return false;
    final AdvTimePickerValue typedOther = other;
    return typedOther.time == time &&
        typedOther.minTime == minTime &&
        typedOther.maxTime == maxTime &&
        typedOther.error == error &&
        typedOther.enabled == enabled &&
        typedOther.obscureText == obscureText;
  }

  @override
  int get hashCode => hashValues(time.hashCode, minTime.hashCode,
      maxTime.hashCode, error.hashCode, enabled.hashCode, obscureText.hashCode);
}
