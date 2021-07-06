import 'package:flutter/material.dart';
import 'package:zemoga/src/common/utils/global_variables.dart';

class ZemogaColors{

  static const Color principalColor = const Color(0xff14c44c);
  static const Color darkPrincipalColor = const Color(0xff14c44c);

  static const Color textTitleColor = const Color(0xFF4E4E4E);
  static const Color darkTextTitleColor = const Color(0xfff7f7f7);

  static const Color blueDark = const Color(0xFF16597B);
  static const Color grayModal = const Color(0xFF48626C);
  static const Color grayMedium = const Color(0xFF606E74);
  static const Color mediumGrayColor = const Color(0xFF727272);
  static const Color pinkishGrayColor = const Color(0xFFc5c5c5);
  static const Color whiteBackground = const Color(0xFFE5E5E5);
  static const Color grayBackground = const Color(0xFFE0E0E0);
  static const Color blackDark = const Color(0xFF092431);

  static const BoxShadow defaultShadow = const BoxShadow(offset: Offset(1, 3), blurRadius: 6, color: Color(0x20000000));

  static Color getPrincipalColor()=> GlobalVariables.lightTheme ? principalColor : darkPrincipalColor;

  static Color getTitleColor () => GlobalVariables.lightTheme ? textTitleColor : darkTextTitleColor;

  static Color getSecondaryColor () => GlobalVariables.lightTheme ? mediumGrayColor : pinkishGrayColor;

  static Color getThirdColor () => GlobalVariables.lightTheme ? grayBackground : mediumGrayColor;

  static Color getSecondaryIconsColor () => GlobalVariables.lightTheme ? grayModal : Colors.white;

}