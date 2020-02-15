library time_picker;

import 'package:basic_components/components/adv_button.dart';
import 'package:basic_components/components/adv_column.dart';
import 'package:basic_components/components/adv_list_tile.dart';
import 'package:basic_components/components/adv_row.dart';
import 'package:basic_components/components/component_theme.dart';
import 'package:basic_components/components/component_theme_data.dart';
import 'package:flutter/material.dart';

part 'time_picker_widget.dart';
part 'scrollable_time_picker.dart';

class Constant {
  static List<int> hours12 = List.generate(12, (i) => i + 1);

  static List<String> meridiems = ["AM", "PM"];

  static List<int> minutes = List.generate(60, (i) => i);

  static List<int> hours24 = List.generate(24, (i) => i);
}

enum TimePickType { hour, hourMinute, hourMinuteSecond }

enum DisplayType { dialog, bottomSheet }

class TimePicker {
  static Future<DateTime> pickTime(BuildContext context,
      {DateTime time,
      double fontSize = 24,
      TimePickType timePickType = TimePickType.hourMinuteSecond,
      bool isTwelveHourFormat = false,
      String buttonName = "Submit",
      String title,
      DisplayType displayType = DisplayType.bottomSheet}) async {
    DisplayType displays = displayType ?? DisplayType.bottomSheet;
    DateTime result;
    if (displays == DisplayType.dialog) {
      result = await showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: TimePickerWidget(
                time: time,
                timePickType: timePickType,
                buttonName: buttonName,
                title: title,
                isTwelveHourFormat: isTwelveHourFormat,
              ),
            );
          });
    } else if (displays == DisplayType.bottomSheet) {
      result = await showModalBottomSheet(
          context: context,
          builder: (context) {
            return TimePickerWidget(
              time: time,
              timePickType: timePickType,
              title: title,
              buttonName: buttonName,
              isTwelveHourFormat: isTwelveHourFormat,
            );
          });
    }

    return result;
  }
}
