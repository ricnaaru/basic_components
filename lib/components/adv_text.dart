import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class AdvText extends StatelessWidget {
  final String data;
  final Key key;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Locale locale;
  final bool withDot;
  final bool wrapWholeWord;
  final bool softWrap;
  final double textScaleFactor;
  final int maxLines;
  final String semanticsLabel;
  final TextWidthBasis textWidthBasis;

  AdvText(
      this.data, {
        this.key,
        this.style,
        this.strutStyle,
        this.textAlign,
        this.textDirection,
        this.locale,
        bool withDot,
        bool wrapWholeWord,
        this.softWrap,
        this.textScaleFactor,
        this.maxLines,
        this.semanticsLabel,
        this.textWidthBasis,
      })  : this.withDot = withDot ?? true,
        this.wrapWholeWord = wrapWholeWord ?? false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        String text = _compute(constraints.maxWidth);

        return Text(
          text,
          key: this.key,
          style: this.style,
          strutStyle: this.strutStyle,
          textAlign: this.textAlign,
          textDirection: this.textDirection,
          locale: this.locale,
          softWrap: this.softWrap,
          textScaleFactor: this.textScaleFactor,
          maxLines: this.maxLines,
          semanticsLabel: this.semanticsLabel,
          textWidthBasis: this.textWidthBasis,
        );
      },
    );
  }

  String _compute(double maxWidth) {
    int _maxLines = maxLines ?? 999999;
    int i = 0;
    int found = this.data.indexOf("\n");
    int lineCounter = 0;
    String result = "";

    if (found == -1) found = this.data.length;

    while (found > -1 && found <= this.data.length) {
      String temp = this.data.substring(i, found);

      String ellipsized = _getEllipsizedText(temp, this.style, maxWidth,
          withDot: lineCounter == _maxLines - 1 && withDot,
          wholeWord: wrapWholeWord);

      while (ellipsized != temp && !ellipsized.endsWith("\u2026")) {
        result += ellipsized + "\n";
        lineCounter++;

        if (lineCounter >= _maxLines) break;

        temp = temp.replaceAll(ellipsized, "");

        if (temp.startsWith(" ")) temp = temp.substring(1, temp.length);

        ellipsized = _getEllipsizedText(temp, this.style, maxWidth,
            withDot: lineCounter == _maxLines - 1 && withDot,
            wholeWord: wrapWholeWord);
      }

      result += ellipsized + "\n";
      lineCounter++;

      found += 1;
      i = found;

      if (found > this.data.length || lineCounter >= _maxLines) break;

      found = this.data.indexOf("\n", found);

      if (found == -1) found = this.data.length;
    }

    if (result.endsWith("\n")) result = result.substring(0, result.length - 1);

    return result;
  }

  String _getEllipsizedText(String text, TextStyle textStyle, double maxWidth,
      {bool withDot, bool wholeWord}) {
    if (maxWidth == null) return text;

    var tp = new TextPainter(
        text: TextSpan(text: text, style: textStyle),
        textDirection: ui.TextDirection.ltr);
    tp.layout();

    double wholeWidth = tp.width;

    if (wholeWidth <= maxWidth) return text;

    int startPositionPercentage =
    (maxWidth / wholeWidth * 100).ceil().clamp(0, 100);
    int startPosition = (startPositionPercentage * text.length / 100)
        .ceil()
        .clamp(0, text.length);

    tp.text = TextSpan(
        text: "${text.substring(0, startPosition)}${withDot ? "\u2026" : ""}",
        style: textStyle);

    tp.layout();

    int i = 0;

    if (tp.width > maxWidth) {
      for (i = startPosition; i > 0; i--) {
        tp.text = TextSpan(
            text: "${text.substring(0, i)}${withDot ? "\u2026" : ""}",
            style: textStyle);

        tp.layout();

        if (tp.width <= maxWidth) break;
      }
    } else if (tp.width < maxWidth) {
      for (i = startPosition; i < text.length; i++) {
        tp.text = TextSpan(
            text: "${text.substring(0, i)}${withDot ? "\u2026" : ""}",
            style: textStyle);

        tp.layout();

        if (tp.width <= maxWidth) break;
      }
    } else {
      i = startPosition;
    }

    if (wholeWord) {
      String croppedText = text.substring(0, i);

      int lastIndex = croppedText.lastIndexOf(" ");
      i = lastIndex == -1 ? i : lastIndex;
    }

    return "${text.substring(0, i)}${i == text.length ? "" : "${withDot ? "\u2026" : ""}"}";
  }
}
