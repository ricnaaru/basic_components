part of adv_chooser;

class AdvChooserController extends ValueNotifier<AdvChooserValue> {
  String get text => value.text;

  set text(String newText) {
    value = value.copyWith(
      text: newText,
      items: this.items,
      error: this.error,
      enabled: this.enabled,
      obscureText: this.obscureText,
    );
  }

  Map<String, String> get items => value.items;

  set items(Map<String, String> newItems) {
    value = value.copyWith(
      text: this.text,
      items: newItems,
      error: this.error,
      enabled: this.enabled,
      obscureText: this.obscureText,
    );
  }

  String get error => value.error;

  set error(String newError) {
    value = value.copyWith(
      text: this.text,
      items: this.items,
      error: newError,
      enabled: this.enabled,
      obscureText: this.obscureText,
    );
  }

  bool get enabled => value.enabled;

  set enabled(bool newenabled) {
    value = value.copyWith(
      text: this.text,
      items: this.items,
      error: this.error,
      enabled: newenabled,
      obscureText: this.obscureText,
    );
  }

  bool get obscureText => value.obscureText;

  set obscureText(bool newObscureText) {
    value = value.copyWith(
      text: this.text,
      items: this.items,
      error: this.error,
      enabled: this.enabled,
      obscureText: newObscureText,
    );
  }

  AdvChooserController({
    String text,
    Map<String, String> items,
    String error,
    bool enabled,
    bool obscureText,
  }) : super(
            text == null && items == null && error == null && enabled == null && obscureText == null
                ? AdvChooserValue.empty
                : new AdvChooserValue(
                    text: text,
                    items: items,
                    error: error,
                    enabled: enabled ?? true,
                    obscureText: obscureText ?? false,
                  ));

  AdvChooserController.fromValue(AdvChooserValue value) : super(value ?? AdvChooserValue.empty);

  void clear() {
    value = AdvChooserValue.empty;
  }
}

@immutable
class AdvChooserValue {
  const AdvChooserValue({
    this.text = '',
    this.items,
    this.error,
    this.enabled = true,
    this.obscureText = false,
  });

  final String text;
  final Map<String, String> items;
  final String error;
  final bool enabled;
  final bool obscureText;

  static const AdvChooserValue empty = const AdvChooserValue();

  AdvChooserValue copyWith({
    String text,
    Map<String, String> items,
    String error,
    bool enabled,
    bool obscureText,
  }) {
    return new AdvChooserValue(
      text: text,
      items: items,
      error: error,
      enabled: enabled,
      obscureText: obscureText,
    );
  }

  AdvChooserValue.fromValue(AdvChooserValue copy)
      : this.text = copy.text,
        this.items = copy.items,
        this.error = copy.error,
        this.enabled = copy.enabled,
        this.obscureText = copy.obscureText;

  @override
  String toString() =>
      '$runtimeType(text: \u2524$text\u251C, items: $items, error: \u2524$error\u251C, enabled: $enabled, obscureText: $obscureText)';

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (other is! AdvChooserValue) return false;
    final AdvChooserValue typedOther = other;
    return typedOther.text == text &&
        typedOther.items == items &&
        typedOther.error == error &&
        typedOther.enabled == enabled &&
        typedOther.obscureText == obscureText;
  }

  @override
  int get hashCode =>
      hashValues(text.hashCode, items.hashCode, error.hashCode, enabled.hashCode, obscureText.hashCode);
}
