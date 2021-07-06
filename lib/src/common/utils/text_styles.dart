import 'package:flutter/material.dart';

class ZemogaTextStyles{


  static TextStyle _baseFont = const TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'Roboto',
      fontStyle: FontStyle.normal,
      fontSize: 16,
      height: 1.3);

  static TextStyle robotoRegular = _baseFont;

  static TextStyle robotoMedium = _baseFont.copyWith(fontWeight: FontWeight.w500);

  static TextStyle robotoBold = _baseFont.copyWith(fontWeight: FontWeight.w700);

  static TextStyle robotoLight = _baseFont.copyWith(fontWeight: FontWeight.w300);

  static TextStyle robotoThin = _baseFont.copyWith(fontWeight: FontWeight.w100);

}