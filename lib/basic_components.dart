import 'package:flutter/material.dart';

class BasicComponents {
  static _GroupRadio groupRadio = _GroupRadio();
  static _GroupCheck groupCheck = _GroupCheck();
  static _DatePicker datePicker = _DatePicker();
  static _Button button = _Button();
  static _Loading loading = _Loading();
  static _Chooser chooser = _Chooser();
}

class _Chooser {
  Color iconColor = Colors.black;
}

class _GroupCheck {
  Color checkColor = Colors.blue;
}

class _GroupRadio {
  Color checkColor = Colors.blue;
}

class _DatePicker {
  String dateFormat = "dd-MM-yyyy";

  Color daysLabelColor = Color(0xff208e5d);
  Color todayTextColor = Color(0xffffffff);
  Color todayColor = Color(0xffff6378);
  Color selectedColor = Color(0xff9bf0ff);
  Color selectedTextColor = Color(0xffffffff);
  Color iconColor = Colors.blueAccent;
  IconData iconPrevious = Icons.keyboard_arrow_left;
  IconData iconNext = Icons.keyboard_arrow_right;

  Color weekendColor = Color(0xffff235e);
  Color weekdayColor = Color(0xff44363a);
  Color toolbarColor = Color(0xfff4329a);
  Color headerColor = Color(0xfff4329a);

  Color prevDaysColor = Color(0xffa6a6a6);
  Color nextDaysDaysColor = Color(0xffa6a6a6);
  Color markedDaysDaysColor = Colors.blue;
  Color backgroundColor = Color(0xffffffff);
  Color borderColor = Color(0xffa6a6a6);
  Color hintColor = Color(0xffa6a6a6);
  Color labelColor = Color(0xff777777);
  Color errorColor = Color(0xffd81920);

  List<String> weekdaysArray = ['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'];
  List<String> monthsArray = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  String markedDatesTitle = "Marked date";
}

class _Button {
  Color textColor = Color(0xffffffff);
  Color backgroundColor = Color(0xfff4329a);
}

class _Loading {
  String assetName = "";
  Color barrierColor = const Color(0x10000000);
  double width = 100.0;
  double height = 100.0;
}