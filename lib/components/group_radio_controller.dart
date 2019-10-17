part of group_radio;

class AdvGroupRadioController extends ValueNotifier<AdvGroupRadioEditingValue> {
  String get text => value.text;

  set text(String newCheckedValue) {
    value = value.copyWith(text: newCheckedValue, items: this.items);
  }

  Map<String, Widget> get items => value.items;

  set items(Map<String, Widget> newItemList) {
    value = value.copyWith(text: this.text, items: newItemList);
  }

  AdvGroupRadioController({String text, Map<String, Widget> items})
      : super(text == null && items == null
            ? AdvGroupRadioEditingValue.empty
            : new AdvGroupRadioEditingValue(text: text, items: items));

  AdvGroupRadioController.fromValue(AdvGroupRadioEditingValue value)
      : super(value ?? AdvGroupRadioEditingValue.empty);

  void clear() {
    value = AdvGroupRadioEditingValue.empty;
  }
}

@immutable
class AdvGroupRadioEditingValue {
  const AdvGroupRadioEditingValue({this.text = '', this.items});

  final String text;
  final Map<String, Widget> items;

  static const AdvGroupRadioEditingValue empty = const AdvGroupRadioEditingValue();

  AdvGroupRadioEditingValue copyWith({String text, Map<String, Widget> items}) {
    return new AdvGroupRadioEditingValue(text: text, items: items);
  }

  AdvGroupRadioEditingValue.fromValue(AdvGroupRadioEditingValue copy)
      : this.text = copy.text,
        this.items = copy.items;

  @override
  String toString() =>
      '$runtimeType(text: \u2524$text\u251C, valueList: \u2524$items\u251C)';

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (other is! AdvGroupRadioEditingValue) return false;
    final AdvGroupRadioEditingValue typedOther = other;
    return typedOther.text == text && typedOther.items == items;
  }

  @override
  int get hashCode => hashValues(text.hashCode, items.hashCode);
}
