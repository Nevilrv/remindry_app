import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_strings.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:untitled1/core/utils/widgets/app_gradient_button.dart';
import 'package:untitled1/routes/app_routes.dart';

class AiStartPage extends StatelessWidget {
  const AiStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Background Wavy Gradient
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(AppAssets.remindrybg, fit: BoxFit.cover),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          width: 52.h,
                          height: 52.h,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: AppColors.lightGray1),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 18.sp,
                              color: AppColors.blackLight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Icon Center
                SvgPicture.asset(AppAssets.aiTip, height: 50.h, width: 50.w),
                5.hBox,
                Text(
                  AppStrings.askRemindry,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                5.hBox,
                Text(
                  AppStrings.whatCanIHelpWith,
                  style: TextStyle(fontSize: 13.sp, color: AppColors.black),
                ),
                30.hBox,
                // Feature Cards
                const _FeatureCard(text: AppStrings.aiFeature1),
                const _FeatureCard(text: AppStrings.aiFeature2),
                const _FeatureCard(text: AppStrings.aiFeature3),
                30.hBox,
                // Start Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: AppGradientButton(
                    onTap: () => context.push(AppRoutes.aiMessage),
                    title: AppStrings.startNewChat,
                    icon: Icon(
                      Icons.done_all,
                      color: AppColors.white,
                      size: 20.sp,
                    ),
                  ),
                ),
                10.hBox,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String text;
  const _FeatureCard({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 48.w, vertical: 6.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 14.sp, color: AppColors.black),
      ),
    );
  }
}
