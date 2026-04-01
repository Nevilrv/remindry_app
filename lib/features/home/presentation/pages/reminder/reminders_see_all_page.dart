import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_strings.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:untitled1/core/utils/widgets/common_app_bar_remindry.dart';
import 'package:untitled1/routes/app_routes.dart';

class RemindersSeeAllPage extends StatelessWidget {
  const RemindersSeeAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray6,
      body: Column(
        children: [
          const CommonAppBarRemindry(
            title: AppStrings.todaysReminders,
            subtitle: AppStrings.joinRemindry,
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              itemCount: 10,
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, color: AppColors.lightGray1),
              itemBuilder: (context, index) {
                if (index % 2 == 0) {
                  return _buildReminderTile(
                    context,
                    assetPath: AppAssets.tablet,
                    iconBgColor: AppColors.lightOrange,
                    iconColor: AppColors.orange,
                    title: AppStrings.takeAntibiotics,
                    subtitle: AppStrings.afterBreakfast,
                    badge: AppStrings.now,
                    badgeBgColor: AppColors.orange,
                    badgeTextColor: AppColors.white,
                  );
                } else {
                  return _buildReminderTile(
                    context,
                    assetPath: AppAssets.medical,
                    iconBgColor: AppColors.lightBlueBox,
                    iconColor: AppColors.primary,
                    title: AppStrings.drSmithCheckup,
                    subtitle: AppStrings.timeCheckup,
                    badge: "TODAY",
                    badgeBgColor: AppColors.badgeGray,
                    badgeTextColor: AppColors.badgeGrayText,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReminderTile(
    BuildContext context, {
    required String assetPath,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String badge,
    required Color badgeBgColor,
    required Color badgeTextColor,
  }) {
    return GestureDetector(
      onTap: () => context.pushNamed(
        AppRoutes.reminderDetails,
        extra: {
          'icon': assetPath,
          'iconBgColor': iconBgColor,
          'iconColor': iconColor,
          'title': title,
          'subtitle': subtitle,
        },
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Row(
          children: [
            Container(
              width: 48.sp,
              height: 48.sp,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Center(
                child: SvgPicture.asset(
                  assetPath,
                  width: 20.sp,
                  height: 20.sp,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                ),
              ),
            ),
            12.wBox,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackLight,
                    ),
                  ),
                  4.hBox,
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: badgeBgColor,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                badge,
                style: TextStyle(
                  color: badgeTextColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
