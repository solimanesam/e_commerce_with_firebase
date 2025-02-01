import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.primaryColor,
    textTheme: GoogleFonts.soraTextTheme(ThemeData.light().textTheme),
    popupMenuTheme: PopupMenuThemeData(color: AppColors.secondryColor),
    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
            iconColor: WidgetStatePropertyAll(AppColors.secondryColor),
            iconSize: WidgetStatePropertyAll(30))));
