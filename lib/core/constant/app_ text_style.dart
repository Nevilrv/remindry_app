import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/app_theme.dart';

class AppTextStyle {
  static final TextStyle f16boldBlack = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.black,

    fontSize: 16.sp,
  );
  static final TextStyle f12W400Black = TextStyle(
    fontWeight: FontWeight.w400,
    color: AppColors.black,

    fontSize: 12.sp,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle caption = TextStyle(fontSize: 12, color: Colors.grey);
}
