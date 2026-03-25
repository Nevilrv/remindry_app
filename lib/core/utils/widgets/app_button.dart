import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/extentions/extentions.dart';

class AppButton extends StatelessWidget {
  final Function() onTap;
  final String title;
  final Widget? icon;
  final Gradient? gradient;
  const AppButton({
    super.key,
    required this.onTap,
    required this.title,
    this.icon,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: 18.py,
        width: 245.w,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.r),
          gradient:
              gradient ??
              LinearGradient(
                colors: [AppColors.buttonGray1, AppColors.buttonGray2],
              ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[icon!, 5.wBox],
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
