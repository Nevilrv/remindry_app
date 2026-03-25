import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_strings.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:untitled1/core/utils/widgets/app_button.dart';
import 'package:untitled1/core/utils/widgets/common_app_bar_remindry.dart';
import 'package:untitled1/core/utils/widgets/common_dialog.dart';

class ReminderDetailsPage extends StatelessWidget {
  const ReminderDetailsPage({super.key});

  void _showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => const CommonDialog(
        illustration: AppAssets.allSet,
        title: "You're All Set!",
        description: "Awesome! You Done Your Reminder",
      ),
    ).then((_) {
      if (context.mounted) {
        context.pop(); // Go back to Home
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          CommonAppBarRemindry(title: "Reminder", showBackButton: true),
          Expanded(
            child: Column(
              children: [
                Spacer(),
                // Large Icon
                Container(
                  width: 124.w,
                  height: 124.w,
                  decoration: BoxDecoration(
                    color: AppColors.orangeLight,
                    borderRadius: BorderRadius.circular(32.r),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppAssets.tablet,
                      width: 41.w,
                      height: 41.w,
                      colorFilter: const ColorFilter.mode(
                        AppColors.orange,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                26.hBox,
                // Title
                Text(
                  "Take Antibiotics",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                5.hBox,
                // Subtitle
                Text(
                  "8:00 AM • After Breakfast",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer(),
                // AI Insights Box
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(21.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40.sp,
                              height: 40.sp,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColors.pinkGradient,
                                    AppColors.red,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  AppAssets.aiTip,
                                  width: 20.w,
                                  height: 20.w,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            8.wBox,
                            Text(
                              "AI Insights",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                        5.hBox,
                        Text(
                          "Take With Plenty Of Water. Do Not Skip Doses. Complete Full Course Even If You Feel Better.",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                31.hBox,
              ],
            ),
          ),
          // Actions
          SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppButton(
                  onTap: () => _showCompletionDialog(context),
                  title: "Mark Done",
                  icon: Icon(
                    Icons.done_all,
                    color: AppColors.white,
                    size: 20.sp,
                  ),
                ),
                11.hBox,
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Text(
                    "Skip for now",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                    ),
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
