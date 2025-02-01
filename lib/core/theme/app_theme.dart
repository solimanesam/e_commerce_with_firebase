import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.blackDesignColor,
  textTheme: GoogleFonts.soraTextTheme(ThemeData.light().textTheme),
);
