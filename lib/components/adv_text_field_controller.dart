part of adv_text_field;

class AdvTextFieldController extends ValueNotifier<AdvTextFieldValue> {
  String get text => value.text;

  set text(String newText) {
    value = value.copyWith(
      text: newText,
      error: this.error,
      enabled: this.enabled,
      obscureText: this.obscureText,
      prefixIcon: this.prefixIcon,
      suffixIcon: this.suffixIcon,
      selection: this.selection,
    );
  }

  String get error => value.error;

  set error(String newError) {
    value = value.copyWith(
      text: this.text,
      error: newError,
      enabled: this.enabled,
      obscureText: this.obscureText,
      prefixIcon: this.prefixIcon,
      suffixIcon: this.suffixIcon,
      selection: this.selection,
    );
  }

  bool get enabled => value.enabled;

  set enabled(bool newEnabled) {
    value = value.copyWith(
      text: this.text,
      error: this.error,
      enabled: newEnabled,
      obscureText: this.obscureText,
      prefixIcon: this.prefixIcon,
      suffixIcon: this.suffixIcon,
      selection: this.selection,
    );
  }

  bool get obscureText => value.obscureText;

  set obscureText(bool newObscureText) {
    value = value.copyWith(
      text: this.text,
      error: this.error,
      enabled: this.enabled,
      obscureText: newObscureText,
      prefixIcon: this.prefixIcon,
      suffixIcon: this.suffixIcon,
      selection: this.selection,
    );
  }

  Widget get prefixIcon => value.prefixIcon;

  set prefixIcon(Widget newPrefixIcon) {
    value = value.copyWith(
      text: this.text,
      error: this.error,
      enabled: this.enabled,
      obscureText: this.obscureText,
      prefixIcon: newPrefixIcon,
      suffixIcon: this.suffixIcon,
      selection: this.selection,);
  }

  Widget get suffixIcon => value.suffixIcon;

  set suffixIcon(Widget newSuffixIcon) {
    value = value.copyWith(
      text: this.text,
      error: this.error,
      enabled: this.enabled,
      obscureText: this.obscureText,
      prefixIcon: this.prefixIcon,
      suffixIcon: newSuffixIcon,
      selection: this.selection,);
  }

  TextSelection get selection => value.selection;

  set selection(TextSelection newSelection) {
    if (newSelection.start > (text?.length ?? 0) ||
        newSelection.end > (text?.length ?? 0))
      throw FlutterError('invalid text selection: $newSelection');
    value = value.copyWith(
      text: this.text,
      error: this.error,
      enabled: this.enabled,
      obscureText: this.obscureText,
      prefixIcon: this.prefixIcon,
      suffixIcon: this.suffixIcon,
      selection: newSelection,);
  }

  AdvTextFieldController({
    String text,
    String error,
    bool enabled,
    bool obscureText,
    Widget prefixIcon,
    Widget suffixIcon,
    TextSelection selection,
  }) : super(text == null && error == null && enabled == null && obscureText == null && prefixIcon == null && suffixIcon == null && selection == null
      ? AdvTextFieldValue.empty
      : new AdvTextFieldValue(
    text: text,
    error: error,
    enabled: enabled ?? true,
    obscureText: obscureText ?? false,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    selection: selection =
    const TextSelection.collapsed(offset: -1),
  ));

  AdvTextFieldController.fromValue(AdvTextFieldValue value)
      : super(value ?? AdvTextFieldValue.empty);

  void clear() {
    value = AdvTextFieldValue.empty;
  }
}

@immutable
class AdvTextFieldValue {
  const AdvTextFieldValue({
    this.text = '',
    this.error,
    this.enabled = true,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.selection = const TextSelection.collapsed(offset: -1),
  });

  final String text;
  final String error;
  final bool enabled;
  final bool obscureText;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final TextSelection selection;

  static const AdvTextFieldValue empty = const AdvTextFieldValue();

  AdvTextFieldValue copyWith({
    String text,
    String error,
    bool enabled,
    bool obscureText,
    Widget prefixIcon,
    Widget suffixIcon,
    TextSelection selection,
  }) {
    return new AdvTextFieldValue(
      text: text,
      error: error,
      enabled: enabled,
      obscureText: obscureText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      selection: selection,
    );
  }

  AdvTextFieldValue.fromValue(AdvTextFieldValue copy)
      : this.text = copy.text,
        this.error = copy.error,
        this.enabled = copy.enabled,
        this.obscureText = copy.obscureText,
        this.prefixIcon = copy.prefixIcon,
        this.suffixIcon = copy.suffixIcon,
        this.selection = copy.selection;

  @override
  String toString() =>
      '$runtimeType(text: \u2524$text\u251C, '
          'error: \u2524$error\u251C, '
          'enabled: $enabled, '
          'obscureText: $obscureText, '
          'prefixIcon: $prefixIcon, '
          'suffixIcon: $suffixIcon, '
          'selection: $selection)';

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (other is! AdvTextFieldValue) return false;
    final AdvTextFieldValue typedOther = other;
    return typedOther.text == text &&
        typedOther.error == error &&
        typedOther.enabled == enabled &&
        typedOther.obscureText == obscureText &&
        typedOther.prefixIcon == prefixIcon &&
        typedOther.suffixIcon == suffixIcon &&
        typedOther.selection == selection;
  }

  @override
  int get hashCode => hashValues(
      text.hashCode,
      error.hashCode,
      enabled.hashCode,
      obscureText.hashCode,
      prefixIcon.hashCode,
      suffixIcon.hashCode,
      selection.hashCode);
}
