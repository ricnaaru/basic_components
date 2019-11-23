part of adv_increment;

class AdvIncrementController extends ValueNotifier<AdvIncrementValue> {
  num get amount => value.amount;

  set amount(num newAmount) {
    value = value.copyWith(
      amount: newAmount,
      minAmount: this.minAmount,
      maxAmount: this.maxAmount,
      error: this.error,
      enabled: this.enabled,
      selection: this.selection,
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
      selection: this.selection,
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
      selection: this.selection,
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
      selection: this.selection,
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
      selection: this.selection,
    );
  }

  TextSelection get selection => value.selection;

  set selection(TextSelection newSelection) {
    if (newSelection.start > ((amount ?? 0).toString().length ?? 0) ||
        newSelection.end > ((amount ?? 0).toString().length ?? 0))
      throw FlutterError('invalid text selection: $newSelection');
    value = value.copyWith(
      amount: this.amount,
      minAmount: this.minAmount,
      maxAmount: this.maxAmount,
      error: this.error,
      enabled: this.enabled,
      selection: newSelection,);
  }

  AdvIncrementController({
    num amount,
    num minAmount,
    num maxAmount,
    String error,
    bool enabled,
    TextSelection selection,
  }) : super(amount == null && minAmount == null && maxAmount == null && error == null && enabled == null && selection == null
      ? AdvIncrementValue.empty
      : new AdvIncrementValue(
    amount: amount,
    minAmount: minAmount,
    maxAmount: maxAmount,
    error: error,
    enabled: enabled ?? true,
    selection: selection =
    const TextSelection.collapsed(offset: -1),
  ));

  AdvIncrementController.fromValue(AdvIncrementValue value)
      : super(value ?? AdvIncrementValue.empty);

  void clear() {
    value = AdvIncrementValue.empty;
  }
}

@immutable
class AdvIncrementValue {
  const AdvIncrementValue({
    this.amount,
    this.minAmount,
    this.maxAmount,
    this.error,
    this.enabled = true,
    this.selection = const TextSelection.collapsed(offset: -1),
  });

  final num amount;
  final num minAmount;
  final num maxAmount;
  final String error;
  final bool enabled;
  final TextSelection selection;

  static const AdvIncrementValue empty = const AdvIncrementValue();

  AdvIncrementValue copyWith({
    num amount,
    num minAmount,
    num maxAmount,
    String error,
    bool enabled,
    TextSelection selection,
  }) {
    return new AdvIncrementValue(
      amount: amount,
      minAmount: minAmount,
      maxAmount: maxAmount,
      error: error,
      enabled: enabled,
      selection: selection,
    );
  }

  AdvIncrementValue.fromValue(AdvIncrementValue copy)
      : this.amount = copy.amount,
        this.minAmount = copy.minAmount,
        this.maxAmount = copy.maxAmount,
        this.error = copy.error,
        this.enabled = copy.enabled,
        this.selection = copy.selection;

  @override
  String toString() =>
      '$runtimeType(amount: \u2524$amount\u251C, '
          'minAmount: \u2524$minAmount\u251C, '
          'maxAmount: \u2524$maxAmount\u251C, '
          '\u2524$error\u251C, '
          'enabled: $enabled, '
          'selection: $selection)';

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (other is! AdvIncrementValue) return false;
    final AdvIncrementValue typedOther = other;
    return typedOther.amount == amount &&
        typedOther.minAmount == minAmount &&
        typedOther.maxAmount == maxAmount &&
        typedOther.error == error &&
        typedOther.enabled == enabled &&
        typedOther.selection == selection;
  }

  @override
  int get hashCode => hashValues(
      amount.hashCode,
      minAmount.hashCode,
      maxAmount.hashCode,
      error.hashCode,
      enabled.hashCode,
      selection.hashCode);
}
