import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  static Gradient appBackgroundColor = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [AppColors.softGreen, AppColors.lightGreen]);

  static Color lightGreen = const Color(0xFF0AACA1);

  static Color softGreen = const Color(0xFF0C5F5A);

  static Color green = const Color(0xFF2BB621);

  static Color white = const Color(0xFFFFFFFF);

  static Color black = const Color(0xFF000000);

  static Color red = const Color(0xFFFF2222);
}
