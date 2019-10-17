part of increment;

class IncrementController extends ValueNotifier<TextFieldValue> {
  num get amount => value.amount;

  set amount(num newAmount) {
    value = value.copyWith(
      amount: newAmount,
      minAmount: this.minAmount,
      maxAmount: this.maxAmount,
      error: this.error,
      enabled: this.enabled,
    );
  }

  num get minAmount => value.minAmount;

  set minAmount(num newMinAmount) {
    value = value.copyWith(
      amount: this.amount,
      minAmount: newMinAmount,
      maxAmount: this.maxAmount,
      error: this.error,
      enabled: this.enabled,
    );
  }

  num get maxAmount => value.maxAmount;

  set maxAmount(num newMaxAmount) {
    value = value.copyWith(
      amount: this.amount,
      minAmount: this.minAmount,
      maxAmount: newMaxAmount,
      error: this.error,
      enabled: this.enabled,
    );
  }

  String get error => value.error;

  set error(String newError) {
    value = value.copyWith(
      amount: this.amount,
      minAmount: this.minAmount,
      maxAmount: this.maxAmount,
      error: newError,
      enabled: this.enabled,
    );
  }

  bool get enabled => value.enabled;

  set enabled(bool newenabled) {
    value = value.copyWith(
      amount: this.amount,
      minAmount: this.minAmount,
      maxAmount: this.maxAmount,
      error: this.error,
      enabled: newenabled,
    );
  }

  IncrementController({
    num amount,
    num minAmount,
    num maxAmount,
    String error,
    bool enabled,
  }) : super(amount == null && error == null && enabled == null
            ? TextFieldValue.empty
            : new TextFieldValue(
    amount: amount,
    minAmount: minAmount,
    maxAmount: maxAmount,
                error: error,
                enabled: enabled ?? true,
              ));

  IncrementController.fromValue(TextFieldValue value)
      : super(value ?? TextFieldValue.empty);

  void clear() {
    value = TextFieldValue.empty;
  }
}

@immutable
class TextFieldValue {
  const TextFieldValue({
    this.amount,
    this.minAmount,
    this.maxAmount,
    this.error,
    this.enabled = true,
  });

  final num amount;
  final num minAmount;
  final num maxAmount;
  final String error;
  final bool enabled;

  static const TextFieldValue empty = const TextFieldValue();

  TextFieldValue copyWith({
    num amount,
    num minAmount,
    num maxAmount,
    String error,
    bool enabled,
  }) {
    return new TextFieldValue(
      amount: amount,
      minAmount: minAmount,
      maxAmount: maxAmount,
      error: error,
      enabled: enabled,
    );
  }

  TextFieldValue.fromValue(TextFieldValue copy)
      : this.amount = copy.amount,
        this.minAmount = copy.minAmount,
        this.maxAmount = copy.maxAmount,
        this.error = copy.error,
        this.enabled = copy.enabled;

  @override
  String toString() =>
      '$runtimeType(amount: \u2524$amount\u251C, minAmount: \u2524$minAmount\u251C, maxAmount: \u2524$maxAmount\u251C, \u2524$error\u251C, enabled: $enabled)';

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (other is! TextFieldValue) return false;
    final TextFieldValue typedOther = other;
    return typedOther.amount == amount &&
        typedOther.minAmount == minAmount &&
        typedOther.maxAmount == maxAmount &&
        typedOther.error == error &&
        typedOther.enabled == enabled;
  }

  @override
  int get hashCode => hashValues(
      amount.hashCode,
      minAmount.hashCode,
      maxAmount.hashCode,
      error.hashCode,
      enabled.hashCode);
}
