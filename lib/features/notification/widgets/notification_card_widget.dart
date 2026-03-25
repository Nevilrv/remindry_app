import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constant/app_ text_style.dart';
import '../../../core/constant/app_theme.dart';

class NotificationCard extends StatelessWidget {
  final String category;
  final String titleText; // the part after the |
  final String subtitle;
  final String message;
  final String icon;
  final Color categoryColor;

  const NotificationCard({
    super.key,
    required this.category,
    required this.titleText,
    required this.subtitle,
    required this.message,
    required this.icon,
    required this.categoryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0.sp),
      decoration: BoxDecoration(
        color: AppColors.lightGray11,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColors.lightGray12, width: 2.w),
        boxShadow: [
          // BoxShadow(
          //   color: Colors.black.withOpacity(0.05),
          //   offset: const Offset(0, 4),
          //   blurRadius: 8,
          // ),
        ],
      ),
      padding: EdgeInsets.all(14.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circle Icon with Double Border
          Container(
            width: 40.h,
            height: 40.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.oxffD4D4D4, width: 2.5.r),
            ),
            padding: EdgeInsets.all(2.r),
            child: Container(
              // padding: EdgeInsets.all(9.r),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE9E9E9), width: 1.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(icon, height: 12.sp, width: 12.sp),
              ),
            ),
          ),
          SizedBox(width: 16.w),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Row
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: category,
                        style: AppTextStyle.f12W400Black.copyWith(
                          color: categoryColor,
                          fontSize: 12.sp,
                        ),
                      ),
                      TextSpan(
                        text: " | ",
                        style: TextStyle(color: Colors.black, fontSize: 16.sp),
                      ),
                      TextSpan(
                        text: titleText,
                        style: AppTextStyle.f16boldBlack.copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),

                // Subtitle
                Text(
                  subtitle,
                  style: AppTextStyle.f12W400Black.copyWith(
                    fontSize: 10.sp,
                    color: AppColors.oxff797A7E,
                  ),
                ),
                SizedBox(height: 8.h),

                // Message Box
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.h),
                  decoration: BoxDecoration(
                    color: AppColors.oxFFFBFBFB,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    message,
                    style: TextStyle(fontSize: 10.sp, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
