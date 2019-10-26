part of text_field;

class AdvTextFieldController extends ValueNotifier<TextFieldValue> {
  String get text => value.text;

  set text(String newText) {
    value = value.copyWith(
      text: newText,
      error: this.error,
      enabled: this.enabled,
      obscureText: this.obscureText,
    );
  }

  String get error => value.error;

  set error(String newError) {
    value = value.copyWith(
      text: this.text,
      error: newError,
      enabled: this.enabled,
      obscureText: this.obscureText,
    );
  }

  bool get enabled => value.enabled;

  set enabled(bool newenabled) {
    value = value.copyWith(
      text: this.text,
      error: this.error,
      enabled: newenabled,
      obscureText: this.obscureText,
    );
  }

  bool get obscureText => value.obscureText;

  set obscureText(bool newObscureText) {
    value = value.copyWith(
      text: this.text,
      error: this.error,
      enabled: this.enabled,
      obscureText: newObscureText,
    );
  }

  AdvTextFieldController({
    String text,
    String error,
    bool enabled,
    bool obscureText,
  }) : super(text == null && error == null && enabled == null && obscureText == null
      ? TextFieldValue.empty
      : new TextFieldValue(
    text: text,
    error: error,
    enabled: enabled ?? true,
    obscureText: obscureText ?? false,
  ));

  AdvTextFieldController.fromValue(TextFieldValue value)
      : super(value ?? TextFieldValue.empty);

  void clear() {
    value = TextFieldValue.empty;
  }
}

@immutable
class TextFieldValue {
  const TextFieldValue({
    this.text = '',
    this.error,
    this.enabled = true,
    this.obscureText = false,
  });

  final String text;
  final String error;
  final bool enabled;
  final bool obscureText;

  static const TextFieldValue empty = const TextFieldValue();

  TextFieldValue copyWith({
    String text,
    String error,
    bool enabled,
    bool obscureText,
  }) {
    return new TextFieldValue(
      text: text,
      error: error,
      enabled: enabled,
      obscureText: obscureText,
    );
  }

  TextFieldValue.fromValue(TextFieldValue copy)
      : this.text = copy.text,
        this.error = copy.error,
        this.enabled = copy.enabled,
        this.obscureText = copy.obscureText;

  @override
  String toString() =>
      '$runtimeType(text: \u2524$text\u251C, \u2524$error\u251C, enabled: $enabled, obscureText: $obscureText)';

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (other is! TextFieldValue) return false;
    final TextFieldValue typedOther = other;
    return typedOther.text == text &&
        typedOther.error == error &&
        typedOther.enabled == enabled &&
        typedOther.obscureText == obscureText;
  }

  @override
  int get hashCode => hashValues(
      text.hashCode,
      error.hashCode,
      enabled.hashCode,
      obscureText.hashCode);
}
