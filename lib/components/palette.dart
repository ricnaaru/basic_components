import 'package:flutter/material.dart';

class Palette {
  Map<int, Color> _accentColorList = <int, Color>{
    0: Color(0x997646ff),
    50: Color(0xffE8E0FF),
    100: Color(0xffD1C1FF),
    200: Color(0xffBBA3FF),
    300: Color(0xffA484FF),
    400: Color(0xff8D65FF),
    500: Color(0xff7646ff),
    600: Color(0xff683ED9),
    700: Color(0xff5A36BD),
    800: Color(0xff4D2EA1),
    900: Color(0xff3F2685)
  };

  Map<int, Color> _primaryColorList = <int, Color>{
    50: Color(0xffE3F0FF),
    100: Color(0xffC6E1FE),
    200: Color(0xffAAD3FE),
    300: Color(0xff8DC4FD),
    400: Color(0xff71B5FD),
    500: Color(0xff54a6fc),
    600: Color(0xff4A93DF),
    700: Color(0xff4180C2),
    800: Color(0xff376DA6),
    900: Color(0xff2E5A89)
  };

  MaterialColor get accentMaterial => MaterialColor(
        _accentColorList[500].value,
        _accentColorList,
      );

  MaterialColor get primaryMaterial => MaterialColor(
        _primaryColorList[500].value,
        _primaryColorList,
      );

  Color get primary => primaryMaterial.shade500;

  Color get primary50 => primaryMaterial.shade50;

  Color get primary100 => primaryMaterial.shade100;

  Color get primary200 => primaryMaterial.shade200;

  Color get primary300 => primaryMaterial.shade300;

  Color get primary400 => primaryMaterial.shade400;

  Color get primary500 => primaryMaterial.shade500;

  Color get primary600 => primaryMaterial.shade600;

  Color get primary700 => primaryMaterial.shade700;

  Color get primary800 => primaryMaterial.shade800;

  Color get primary900 => primaryMaterial.shade900;

  Color get accent => accentMaterial.shade500;

  Color get accent50 => accentMaterial.shade50;

  Color get accent100 => accentMaterial.shade100;

  Color get accent200 => accentMaterial.shade200;

  Color get accent300 => accentMaterial.shade300;

  Color get accent400 => accentMaterial.shade400;

  Color get accent500 => accentMaterial.shade500;

  Color get accent600 => accentMaterial.shade600;

  Color get accent700 => accentMaterial.shade700;

  Color get accent800 => accentMaterial.shade800;

  Color get accent900 => accentMaterial.shade900;

  Color get red => Color(0xffd81920);

  Color get green => Color(0xff24D366);

  Color get blue => Color(0xFF00B0FF);

  Color get grey => Color(0xff8f8f8f);
}
