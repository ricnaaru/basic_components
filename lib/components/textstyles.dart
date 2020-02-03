import 'package:basic_components/basic_components.dart';
import 'package:flutter/material.dart';

final TextStyle _default = TextStyle(fontFamily: "ProximaNovaA");

final TextStyle p8 = _default.copyWith(fontSize: 8.0);
final TextStyle p10 = _default.copyWith(fontSize: 10.0);
final TextStyle p12 = _default.copyWith(fontSize: 12.0);
final TextStyle p14 = _default.copyWith(fontSize: 14.0);
final TextStyle p16 = _default.copyWith(fontSize: 16.0);
final TextStyle p18 = _default.copyWith(fontSize: 18.0);
final TextStyle p20 = _default.copyWith(fontSize: 20.0);
final TextStyle p22 = _default.copyWith(fontSize: 22.0);
final TextStyle p24 = _default.copyWith(fontSize: 24.0);
final TextStyle p26 = _default.copyWith(fontSize: 26.0);
final TextStyle p28 = _default.copyWith(fontSize: 28.0);
final TextStyle p30 = _default.copyWith(fontSize: 30.0);

extension TextStyleExtension on TextStyle {
  //weight
  TextStyle get thin => this.copyWith(fontWeight: FontWeight.w100);

  TextStyle get extraLight => this.copyWith(fontWeight: FontWeight.w200);

  TextStyle get light => this.copyWith(fontWeight: FontWeight.w300);

  TextStyle get normal => this.copyWith(fontWeight: FontWeight.w400);

  TextStyle get medium => this.copyWith(fontWeight: FontWeight.w500);

  TextStyle get semiBold => this.copyWith(fontWeight: FontWeight.w600);

  TextStyle get bold => this.copyWith(fontWeight: FontWeight.bold);

  TextStyle get extraBold => this.copyWith(fontWeight: FontWeight.w800);

  TextStyle get thick => this.copyWith(fontWeight: FontWeight.w900);

  //color
  TextStyle get white => this.copyWith(color: Colors.white);

  TextStyle get black => this.copyWith(color: Colors.black);

  TextStyle get red => this.copyWith(color: palette.red);

  TextStyle get blue => this.copyWith(color: palette.blue);

  TextStyle get green => this.copyWith(color: palette.green);

  TextStyle get primary => this.copyWith(color: palette.primary);

  TextStyle get accent => this.copyWith(color: palette.accent);

  TextStyle get grey => this.copyWith(color: palette.grey);
}
