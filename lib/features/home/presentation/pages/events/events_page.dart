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

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray6,
      body: Column(
        children: [
          // ─── AppBar ─────────────────────────────────────────────────────
          CommonAppBarRemindry(
            title: AppStrings.events,
            subtitle: AppStrings.joinRemindry,
          ),

          // ─── Body ────────────────────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionHeader(title: AppStrings.recommendedByAi),
                  16.hBox,
                  _EventCard(
                    day: "24",
                    month: "FEB",
                    title: "Sister's Wedding",
                    subtitle: "New York Hall • 7:00 PM",
                    aiTip: AppStrings.dontForgetGift,
                  ),
                  21.hBox,
                  _SectionHeader(title: AppStrings.otherEvents),
                  12.hBox,
                  _EventCard(
                    day: "24",
                    month: "FEB",
                    title: "Design Conference",
                    subtitle: "Downtown • 9:00 AM",
                  ),
                  8.hBox,
                  _EventCard(
                    day: "24",
                    month: "FEB",
                    title: "Nick Wedding",
                    subtitle: "Downtown • 10:00 AM",
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
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (context) => const _AddEventBottomSheet(),
                );
              },
              title: AppStrings.addEvent,
              icon: Icon(Icons.add, color: Colors.white, size: 20.sp),
            ),
          ),
          10.hBox,
        ],
      ),
    );
  }
}

class _AddEventBottomSheet extends StatelessWidget {
  const _AddEventBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: AppColors.lightGray6,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.addEvent,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          4.hBox,
          Text(
            AppStrings.joinRemindry,
            style: TextStyle(fontSize: 11.sp, color: AppColors.black),
          ),
          23.hBox,
          // Add With Smart AI
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.primaryLight1,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Row(
              children: [
                Center(
                  child: SvgPicture.asset(
                    AppAssets.aiTip,
                    height: 40.sp,
                    width: 40.sp,
                  ),
                ),
                16.wBox,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.addWithSmartAi,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      2.hBox,
                      Text(
                        AppStrings.autoDetectDocuments,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                SvgPicture.asset(
                  AppAssets.lock,
                  height: 24.sp,
                  width: 24.sp,
                  colorFilter: const ColorFilter.mode(
                    AppColors.black,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
          16.hBox,
          // Upload Manually
          GestureDetector(
            onTap: () {
              context.pop(); // Close bottom sheet
              context.pushNamed(AppRoutes.addEvent);
            },
            child: Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.lightGray9, width: 1),
              ),
              child: Row(
                children: [
                  Container(
                    width: 45.sp,
                    height: 45.sp,
                    decoration: BoxDecoration(
                      color: AppColors.lightGray10,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.edit,
                        height: 24.sp,
                        width: 24.sp,
                        colorFilter: const ColorFilter.mode(
                          AppColors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  16.wBox,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.uploadManually,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        4.hBox,
                        Text(
                          AppStrings.selectExistingPhoto,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          20.hBox,
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.blackLight,
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final String day;
  final String month;
  final String title;
  final String subtitle;
  final String? aiTip;

  const _EventCard({
    required this.day,
    required this.month,
    required this.title,
    required this.subtitle,
    this.aiTip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Date
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: Column(
                  children: [
                    Text(
                      day,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      month,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.badgeGrayText,
                      ),
                    ),
                  ],
                ),
              ),
              16.wBox,
              // Vertical Divider
              Container(height: 40.h, width: 1, color: AppColors.lightGray8),
              16.wBox,
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackLight,
                      ),
                    ),
                    4.hBox,
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.badgeGrayText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (aiTip != null) ...[
            12.hBox,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.aiTip,
                    height: 14.sp,
                    width: 14.sp,
                  ),
                  6.wBox,
                  RichText(
                    text: TextSpan(
                      text: "AI TIP: ",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                      children: [
                        TextSpan(
                          text: aiTip,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
