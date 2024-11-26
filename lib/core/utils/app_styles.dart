import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'colors_manager.dart';

class LightAppStyle {
  static TextStyle appBar = GoogleFonts.poppins(
      fontSize: 22.sp, fontWeight: FontWeight.w700, color: ColorsManager.white);
  static TextStyle settingsTabLabel = GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w700, color: ColorsManager.black);
  static TextStyle selectedItemLabel = GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w400, color: ColorsManager.blue);
  static TextStyle bottomSheetTitle = GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: ColorsManager.blackAccent);
  static TextStyle hint = GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w400, color: ColorsManager.hint);
  static TextStyle date = GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.w400, color: ColorsManager.black);
  static TextStyle todoTitle = GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.w400, color: ColorsManager.blue);
  static TextStyle todoDesc = GoogleFonts.roboto(
      fontSize: 14, fontWeight: FontWeight.w400, color: ColorsManager.black);
  static TextStyle calenderSelectedDate = GoogleFonts.roboto(
      fontSize: 15, fontWeight: FontWeight.w700, color: ColorsManager.blue);
  static TextStyle calenderUnSelectedDate = GoogleFonts.roboto(
      fontSize: 15, fontWeight: FontWeight.w700, color: ColorsManager.black);
  static TextStyle hintRegister = GoogleFonts.roboto(
      fontSize: 13,
      fontWeight: FontWeight.w300,
      color: ColorsManager.fieldBlack);
  static TextStyle title = GoogleFonts.roboto(
      fontSize: 18, fontWeight: FontWeight.w500, color: ColorsManager.white);
  static TextStyle buttonText = GoogleFonts.roboto(
      fontSize: 20, fontWeight: FontWeight.w600, color: Colors.blue.shade900);
}
