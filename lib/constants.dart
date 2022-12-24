import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors {
  static Color get primaryColor => const Color(0xFF4A4999);

  static const Color accentColor = Color(0xFF707DFF);
  static const Color gray = Color(0xFF9EA1B2);
  static const Color lines = Color(0xFFD6D7E4);
  static const Color mainText = Color(0xFF40445C);
  static const Color secondaryText = Color(0xFF7E8298);
}

class AppStyles {
  static TextStyle get heading => TextStyle(
        color: const Color(0xFF40445C),
        fontWeight: FontWeight.w700,
        fontSize: 28.sp,
      );

  static TextStyle get heading20 => TextStyle(
        color: const Color(0xFF40445C),
        fontWeight: FontWeight.w600,
        fontSize: 20.sp,
      );

  static TextStyle get heading17 => TextStyle(
        color: const Color(0xFF40445C),
        fontWeight: FontWeight.w600,
        fontSize: 17.sp,
      );

  static TextStyle get heading13 => TextStyle(
        color: const Color(0xFF40445C),
        fontWeight: FontWeight.w600,
        fontSize: 13.sp,
      );

  static TextStyle get subtitleDark => TextStyle(
        color: const Color(0xFF40445C),
        fontWeight: FontWeight.w400,
        fontSize: 17.sp,
      );

  static TextStyle get subtitle34 => TextStyle(
        color: const Color(0xFF40445C),
        fontWeight: FontWeight.w400,
        fontSize: 34.sp,
      );

  static TextStyle get subtitle20 => TextStyle(
        color: const Color(0xFF7E8298),
        fontWeight: FontWeight.w400,
        fontSize: 20.sp,
      );

  static TextStyle get subtitle17 => TextStyle(
        color: const Color(0xFF7E8298),
        fontWeight: FontWeight.w400,
        fontSize: 17.sp,
      );

  static TextStyle get subtitle12 => TextStyle(
        color: const Color(0xFF7E8298),
        fontWeight: FontWeight.w400,
        fontSize: 12.sp,
      );

  static TextStyle get bodyText17 => TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 17.sp,
      );

  static TextStyle get bodyText13 => TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 13.sp,
      );

  static TextStyle get hintText => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
      );
}
