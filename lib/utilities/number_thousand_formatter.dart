import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumberThousandFormatter extends WhitelistingTextInputFormatter {
  final int digitLimit;

  NumberThousandFormatter({int digitLimit})
      : this.digitLimit = digitLimit ?? 16,
        super(RegExp(r'(\d+)'));

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (oldValue.text == newValue.text) {
      return newValue;
    }

    var x = super.formatEditUpdate(oldValue, newValue);

    if (x.text.length > this.digitLimit) {
      x = super.formatEditUpdate(oldValue, oldValue);

      if (x.text.isEmpty) {
        x = super.formatEditUpdate(oldValue, newValue);

        x = x.copyWith(text: x.text.substring(0, this.digitLimit));
      }
    }

    return _format(oldValue, x);
  }

  TextEditingValue _format(TextEditingValue oldValue, TextEditingValue newValue) {
    NumberFormat nf = NumberFormat("#,##0");

    String rawText = newValue.text;
    String cleanText = rawText.replaceAll(",", "");
    String formattedText = cleanText.isEmpty ? "" : nf.format(int.tryParse(cleanText));

    int base = newValue.selection.baseOffset;
    int extent = newValue.selection.extentOffset;
    int length = cleanText.length;
    int totalSeparator = ((length - 1) / 3).floor();
    int x = ((length - base) / 3).floor();

    base += totalSeparator - x;
    extent += totalSeparator - x;

    base = base.clamp(0, 2^53);
    extent = extent.clamp(0, 2^53);

    return TextEditingValue(
      text: formattedText,
      selection: newValue.selection.copyWith(baseOffset: base, extentOffset: extent),
      composing: Platform.isIOS
          ? (formattedText ?? "").isEmpty ? TextRange.empty : TextRange(start: 0, end: 0)
          : TextRange.empty,
    );
  }

//  TextSelection updateCursorPosition(String text) {
//    return TextSelection.fromPosition(TextPosition(offset: text.length));
//  }
}
