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
import '../../../../../routes/app_routes.dart';

class HealthCarePage extends StatelessWidget {
  const HealthCarePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray6,
      body: Column(
        children: [
          // ─── AppBar ─────────────────────────────────────────────────────
          CommonAppBarRemindry(
            title: AppStrings.healthCare,
            subtitle: AppStrings.joinRemindry,
          ),

          // ─── Body ────────────────────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                children: [
                  35.hBox,
                  // Heart Progress
                  Center(
                    child: SvgPicture.asset(
                      AppAssets.heartlayer,
                      width: 110.sp,
                      height: 110.sp,
                    ),
                  ),
                  20.hBox,
                  Text(
                    AppStrings.adherenceScore,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                  35.hBox,

                  // Upcoming Checkups
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppStrings.upcomingCheckups,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  12.hBox,
                  _CheckupCard(
                    title: AppStrings.drSmithCheckup,
                    subtitle: AppStrings.timeCheckup,
                  ),
                  12.hBox,
                  _CheckupCard(
                    title: AppStrings.drSmithCheckup,
                    subtitle: AppStrings.timeCheckup,
                  ),
                  32.hBox,
                ],
              ),
            ),
          ),

          // ─── Bottom Button ─────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
            child: AppButton(
              onTap: () => context.pushNamed(AppRoutes.addVisit),
              title: AppStrings.addDoctorVisit,
              icon: Icon(Icons.add, color: AppColors.white, size: 20.sp),
            ),
          ),
          10.hBox,
        ],
      ),
    );
  }
}

class _CheckupCard extends StatelessWidget {
  final String title;
  final String subtitle;
  const _CheckupCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: AppColors.lightBlueBox,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: SvgPicture.asset(
              AppAssets.medical,
              height: 20.sp,
              width: 20.sp,
              colorFilter: ColorFilter.mode(AppColors.purple, BlendMode.srcIn),
            ),
          ),
          16.wBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
                4.hBox,
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12.sp, color: AppColors.gray1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
