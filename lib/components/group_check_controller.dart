part of group_check;

@immutable
class AdvGroupCheckItem {
  const AdvGroupCheckItem({this.value, this.display, this.isChecked});

  final String value;
  final Widget display;
  final bool isChecked;

  static const AdvGroupCheckItem empty = const AdvGroupCheckItem();

  AdvGroupCheckItem copyWith({String value, Widget display, bool isChecked}) {
    return new AdvGroupCheckItem(
      value: value ?? this.value,
      display: display ?? this.display,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  AdvGroupCheckItem.fromValue(AdvGroupCheckItem copy)
      : this.value = copy.value,
        this.display = copy.display,
        this.isChecked = copy.isChecked;

  @override
  String toString() =>
      '$runtimeType(value: \u2524$value\u251C, display: \u2524$display\u251C, isChecked: \u2524$isChecked\u251C)';

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (other is! AdvGroupCheckItem) return false;
    final AdvGroupCheckItem typedOther = other;
    return typedOther.value == value &&
        typedOther.display == display &&
        typedOther.isChecked == isChecked;
  }

  @override
  int get hashCode => hashValues(value.hashCode, display.hashCode, isChecked.hashCode);
}

class AdvGroupCheckController extends ValueNotifier<AdvGroupCheckEditingValue> {
  List<AdvGroupCheckItem> get items => value.items;

  set items(List<AdvGroupCheckItem> newItemList) {
    value = value.copyWith(items: newItemList);
  }

  set check(int index) {
    AdvGroupCheckItem currentItem = value.items[index];
    value = value.copyWith(
        items: value.items
          ..replaceRange(index, index + 1, [
            currentItem.copyWith(
              isChecked: !currentItem.isChecked,
            )
          ]));
    this.notifyListeners();
  }

  AdvGroupCheckController({List<AdvGroupCheckItem> items})
      : super(items == null
            ? AdvGroupCheckEditingValue.empty
            : new AdvGroupCheckEditingValue(items: items));

  AdvGroupCheckController.fromValue(AdvGroupCheckEditingValue value)
      : super(value ?? AdvGroupCheckEditingValue.empty);

  void clear() {
    value = AdvGroupCheckEditingValue.empty;
  }
}

@immutable
class AdvGroupCheckEditingValue {
  const AdvGroupCheckEditingValue({this.items});

  final List<AdvGroupCheckItem> items;

  static const AdvGroupCheckEditingValue empty = const AdvGroupCheckEditingValue();

  AdvGroupCheckEditingValue copyWith({List<AdvGroupCheckItem> items}) {
    return new AdvGroupCheckEditingValue(items: items);
  }

  AdvGroupCheckEditingValue.fromValue(AdvGroupCheckEditingValue copy) : this.items = copy.items;

  @override
  String toString() => '$runtimeType(valueList: \u2524$items\u251C)';

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (other is! AdvGroupCheckEditingValue) return false;
    final AdvGroupCheckEditingValue typedOther = other;
    return typedOther.items == items;
  }

  @override
  int get hashCode => items.hashCode;
}
