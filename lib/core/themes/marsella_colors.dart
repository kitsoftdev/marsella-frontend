import 'package:flutter/material.dart';

class MarsellaColors extends Color {
  // Constructor que llama al constructor de la clase Color
  MarsellaColors(int value) : super(value);

  static Color get marsellaGreen =>
      Color(int.parse("#48ACF0".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get marsellaGreenBackground =>
      Color(int.parse("#C8E6FA".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get marsellaDarkGreen =>
      Color(int.parse("#133C55".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get marsellaBlack =>
      Color(int.parse("#202020".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get marsellaBlack50 =>
      Color(int.parse("#808080".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get marsellaMediumGreen =>
      Color(int.parse("#1F68A9".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get marsellaBlack20 =>
      Color(int.parse("#CCCCCC".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get marsellaWhite =>
      Color(int.parse("#FFFFFF".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get marsellaBlack5 =>
      Color(int.parse("#F3F3F3".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get marsellaRed =>
      Color(int.parse("#E91447".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get marsellaBlack80 =>
      Color(int.parse("#4D4D4D".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get marsellaGreenLight =>
      Color(int.parse("#91CDF6".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get marsellaBlack90 =>
      Color(int.parse("#363636".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get marsellaUltraBlack =>
      Color(int.parse("#000000".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get marsellaBlack1 =>
      Color(int.parse("#FDFDFD".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get marsellaBlack3 =>
      Color(int.parse("#F8F8F8".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get marsellaBlack10 =>
      Color(int.parse("#E9E9E9".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get marsellaRedForDark =>
      Color(int.parse("#FFA7A7".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get marsellaGreenHover =>
      Color(int.parse("#BBFF84".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get marsellaDarkHover =>
      Color(int.parse("#5E9B2F".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get marsellaRedLight =>
      Color(int.parse("#FFC5C5".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get marsellaBlueBackground =>
      Color(int.parse("#ECF6FF".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get marsellaYellowBackground =>
      Color(int.parse("#FFFFEC".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get marsellaPurpleBackground =>
      Color(int.parse("#F2F0FF".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get marsellaBlackBackground =>
      Color(int.parse("#202020".substring(1, 7), radix: 16) + 0xFF000000);
}
