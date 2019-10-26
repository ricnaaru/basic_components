part of chooser;

class ChooserController extends ValueNotifier<ChooserValue> {
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

  ChooserController({
    String text,
    Map<String, String> items,
    String error,
    bool enabled,
    bool obscureText,
  }) : super(
            text == null && items == null && error == null && enabled == null && obscureText == null
                ? ChooserValue.empty
                : new ChooserValue(
                    text: text,
                    items: items,
                    error: error,
                    enabled: enabled ?? true,
                    obscureText: obscureText ?? false,
                  ));

  ChooserController.fromValue(ChooserValue value) : super(value ?? ChooserValue.empty);

  void clear() {
    value = ChooserValue.empty;
  }
}

@immutable
class ChooserValue {
  const ChooserValue({
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

  static const ChooserValue empty = const ChooserValue();

  ChooserValue copyWith({
    String text,
    Map<String, String> items,
    String error,
    bool enabled,
    bool obscureText,
  }) {
    return new ChooserValue(
      text: text,
      items: items,
      error: error,
      enabled: enabled,
      obscureText: obscureText,
    );
  }

  ChooserValue.fromValue(ChooserValue copy)
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
    if (other is! ChooserValue) return false;
    final ChooserValue typedOther = other;
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
