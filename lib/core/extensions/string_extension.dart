import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeNotifier? _themeProvider = locator<ThemeNotifier>();

extension ImagePathExtension on String {
  String get toSVG => 'assets/images/$this.svg';
  String get toPng => 'assets/images/$this.png';
}

extension IconButtonExtension on IconButton {
  IconButton get customIcon => IconButton(
        onPressed: onPressed,
        icon: icon,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      );
}

extension TextStyleExtension on TextStyle {
  TextStyle get ultraSmallStyle => GoogleFonts.montserrat(
      textStyle: TextStyle(
          color: _themeProvider!.currentTheme != ThemeData.light()
              ? AppColors.black
              : AppColors.white,
          decoration: decoration ?? TextDecoration.none,
          fontSize: 10,
          height: 1.6,
          letterSpacing: 1.3,
          fontWeight: fontWeight ?? FontWeight.w600));
  TextStyle get extraSmallStyle2 => GoogleFonts.montserrat(
      textStyle: TextStyle(
          color: color ?? AppColors.black,
          decoration: decoration ?? TextDecoration.none,
          fontSize: 8,
          height: 1.2,
          letterSpacing: .3,
          fontWeight: fontWeight ?? FontWeight.w400));
  TextStyle get extraSmallStyle => GoogleFonts.montserrat(
      textStyle: TextStyle(
          color: color ?? AppColors.black,
          decoration: decoration ?? TextDecoration.none,
          fontSize: 10,
          height: 1.6,
          letterSpacing: 1.3,
          fontWeight: fontWeight ?? FontWeight.w400));
  TextStyle get smallStyle => GoogleFonts.montserrat(
      textStyle: TextStyle(
          color: color ?? AppColors.black,
          decoration: decoration ?? TextDecoration.none,
          fontSize: 13,
          height: 1.2,
          letterSpacing: 0.36,
          fontWeight: fontWeight ?? FontWeight.w400));
  TextStyle get smallStyle2 => GoogleFonts.montserrat(
      textStyle: TextStyle(
          color: color ?? AppColors.black,
          decoration: decoration ?? TextDecoration.none,
          fontSize: 16,
          height: 1.6,
          letterSpacing: 2,
          fontWeight: fontWeight ?? FontWeight.w400));

  TextStyle get normalStyle => GoogleFonts.montserrat(
      textStyle: TextStyle(
          color: color ?? AppColors.black,
          decoration: decoration ?? TextDecoration.none,
          fontSize: 17,
          height: 1.4,
          letterSpacing: 0.36,
          fontWeight: fontWeight ?? FontWeight.w400));

  TextStyle get mediumStyle => GoogleFonts.montserrat(
      textStyle: TextStyle(
          color: color ?? AppColors.black,
          decoration: decoration ?? TextDecoration.none,
          fontSize: 20,
          height: 1.4,
          letterSpacing: 0.36,
          fontWeight: fontWeight ?? FontWeight.w400));
  TextStyle get largeStyle => GoogleFonts.montserrat(
      textStyle: TextStyle(
          color: color ?? AppColors.black,
          decoration: decoration ?? TextDecoration.none,
          fontSize: 23,
          height: 1.4,
          letterSpacing: 0.36,
          fontWeight: fontWeight ?? FontWeight.w400));

  TextStyle get extraStyle => GoogleFonts.montserrat(
      textStyle: TextStyle(
          color: color ?? AppColors.black,
          decoration: decoration ?? TextDecoration.none,
          fontSize: 32,
          height: 1.4,
          letterSpacing: 0.36,
          fontWeight: fontWeight ?? FontWeight.w400));
}
