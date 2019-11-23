class StringHelper {
  static String stringRepeat(String text, int count) {
    return List.filled(count, text).join();
  }

  static String leadingZeroInt(int value, int count) {
    String stringInt = value.toString();

    return stringInt.length > count
        ? stringInt
        : "${stringRepeat("0", count - stringInt.length)}$stringInt";
  }
}