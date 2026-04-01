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
import 'package:untitled1/routes/app_routes.dart';

class GoPremiumScreen extends StatefulWidget {
  const GoPremiumScreen({super.key});

  @override
  State<GoPremiumScreen> createState() => _GoPremiumScreenState();
}

class _GoPremiumScreenState extends State<GoPremiumScreen> {
  bool isYearly = true;

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.r),
        ),
        child: Container(
          padding: EdgeInsets.all(24.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppAssets.welcomePremium,
                height: 169.h,
                width: 169.w,
                fit: BoxFit.fill,
              ),
              13.hBox,
              Text(
                AppStrings.welcomeToPremium,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              5.hBox,
              Text(
                AppStrings.youReNowAPremiumMember,
                style: TextStyle(fontSize: 11.sp, color: AppColors.black),
              ),
              18.hBox,
              _buildSuccessFeature(AppStrings.advancedAiInsights),
              7.hBox,
              _buildSuccessFeature(AppStrings.smartHabitTracking),
              7.hBox,
              _buildSuccessFeature(AppStrings.priorityReminders),
              18.hBox,
              AppButton(
                onTap: () => context.go(AppRoutes.home),
                title: AppStrings.goToDashboard,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessFeature(String text) {
    return Row(
      children: [
        Icon(Icons.check, color: AppColors.primaryDark, size: 15.sp),
        12.wBox,
        Text(
          text,
          style: TextStyle(
            fontSize: 11.sp,
            color: AppColors.primaryDark,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray15,
      body: Column(
        children: [
          const CommonAppBarRemindry(
            title: AppStrings.monetization,
            subtitle: AppStrings.chooseScanningMethod,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.pinkGradient.withAlpha(12),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: AppColors.pinkGradient.withAlpha(22),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          AppAssets.king,
                          width: 12.sp,
                          colorFilter: const ColorFilter.mode(
                            AppColors.pinkGradient,
                            BlendMode.srcIn,
                          ),
                        ),
                        4.wBox,
                        Text(
                          AppStrings.monetization,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            color: AppColors.pinkGradient,
                          ),
                        ),
                      ],
                    ),
                  ),
                  15.hBox,
                  Text(
                    AppStrings.chooseYourPlan,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),

                  Text(
                    AppStrings.unlockFullPower,
                    style: TextStyle(fontSize: 12.sp, color: AppColors.gray1),
                  ),
                  14.hBox,
                  // Toggle
                  Container(
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: AppColors.white.withAlpha(80)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => isYearly = false),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: !isYearly ? AppColors.white : null,
                                  gradient: isYearly
                                      ? null
                                      : const LinearGradient(
                                          colors: [
                                            AppColors.pinkGradient,
                                            AppColors.redGradient,
                                          ],
                                        ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Text(
                                  AppStrings.monthly,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: !isYearly
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: !isYearly
                                        ? AppColors.white
                                        : AppColors.iconGray,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => isYearly = true),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  gradient: isYearly
                                      ? const LinearGradient(
                                          colors: [
                                            AppColors.pinkGradient,
                                            AppColors.redGradient,
                                          ],
                                        )
                                      : null,
                                  borderRadius: BorderRadius.circular(10.r),
                                  boxShadow: isYearly
                                      ? [
                                          BoxShadow(
                                            color: AppColors.primary
                                                .withOpacity(0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppStrings.yearly,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: isYearly
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: isYearly
                                            ? AppColors.white
                                            : AppColors.iconGray,
                                      ),
                                    ),
                                    4.wBox,
                                    if (isYearly)
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6.w,
                                          vertical: 1.5.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withAlpha(45),
                                          borderRadius: BorderRadius.circular(
                                            20.r,
                                          ),
                                        ),
                                        child: Text(
                                          AppStrings.yearlyDiscount,
                                          style: TextStyle(
                                            fontSize: 9.5.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  30.hBox,
                  // Free Card
                  _buildPlanCard(
                    title: AppStrings.free,
                    subtitle: AppStrings.getStartedPlan,
                    price: "\$0",
                    period: AppStrings.forever,
                    isPremium: false,
                    features: [
                      {
                        "text": AppStrings.pushNotifications,
                        "suffix": AppStrings.only,
                        "included": true,
                        "icon": AppAssets.pushNotification,
                        "iconBg": AppColors.pinkGradient.withAlpha(12),
                      },
                      {
                        "text": AppStrings.limitedReminders,
                        "suffix": AppStrings.upTo5,
                        "included": true,
                        "icon": AppAssets.flash,
                        "iconBg": AppColors.pinkGradient.withAlpha(12),
                      },
                      {
                        "text": AppStrings.manualEntry,
                        "included": true,
                        "icon": AppAssets.star,
                        "iconBg": AppColors.pinkGradient.withAlpha(12),
                      },
                      {
                        "text": AppStrings.includesAds,
                        "included": false,
                        "icon": AppAssets.ads1,
                        "iconBg": const Color(0xFFF1F5F9),
                      },
                      {
                        "text": AppStrings.aiExtraction,
                        "included": false,
                        "icon": AppAssets.aiExtraction,
                        "iconBg": const Color(0xFFF1F5F9),
                      },
                    ],
                  ),
                  20.hBox,
                  // Premium Card
                  _buildPlanCard(
                    title: AppStrings.premiumPlan,
                    subtitle: AppStrings.allFeatures,
                    price: AppStrings.premiumPriceValue,
                    period: AppStrings.premiumPeriod,
                    isPremium: true,
                    features: [
                      {
                        "text": AppStrings.unlimitedReminders,
                        "included": true,
                        "icon": AppAssets.pushNotification,
                        "iconBg": Colors.white.withAlpha(20),
                      },
                      {
                        "text": AppStrings.ocrAiExtraction,
                        "included": true,
                        "icon": AppAssets.ocr,
                        "iconBg": Colors.white.withAlpha(20),
                      },
                      {
                        "text": AppStrings.aiInsightsDashboard,
                        "included": true,
                        "icon": AppAssets.aiInsights,
                        "iconBg": Colors.white.withAlpha(20),
                      },
                      {
                        "text": AppStrings.whatsappAlerts,
                        "included": true,
                        "icon": AppAssets.wp,
                        "iconBg": Colors.white.withAlpha(20),
                      },
                      {
                        "text": AppStrings.cloudBackup,
                        "included": true,
                        "icon": AppAssets.cloud,
                        "iconBg": Colors.white.withAlpha(20),
                      },
                      {
                        "text": AppStrings.noAdsPlan,
                        "included": true,
                        "icon": AppAssets.ads1,
                        "iconBg": Colors.white.withAlpha(20),
                      },
                    ],
                  ),
                  40.hBox,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String subtitle,
    required String price,
    required String period,
    required bool isPremium,
    required List<Map<String, dynamic>> features,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: isPremium ? _showSuccessDialog : null,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            decoration: BoxDecoration(
              color: isPremium ? null : AppColors.white,
              gradient: isPremium
                  ? const LinearGradient(
                      colors: [
                        AppColors.purple1,
                        AppColors.purple2,
                        AppColors.red1,
                      ],
                      stops: [0.0, 0.55, 1.0],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              borderRadius: BorderRadius.circular(24.r),
              border: isPremium
                  ? Border.all(
                      color: AppColors.pinkGradient.withValues(alpha: 0.35),
                      width: 2,
                    )
                  : Border.all(
                      color: AppColors.pinkGradient.withOpacity(0.4),
                      width: 2.r,
                    ),
              boxShadow: [
                BoxShadow(
                  color: (isPremium
                      ? AppColors.black.withOpacity(0.03)
                      : AppColors.pinkGradient.withOpacity(0.05)),
                  blurRadius: isPremium ? 24 : 3,
                  offset: isPremium ? const Offset(0, 8) : const Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                15.5.hBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 44.sp,
                          height: 44.sp,
                          decoration: BoxDecoration(
                            gradient: isPremium
                                ? const LinearGradient(
                                    colors: [
                                      AppColors.pinkGradient,
                                      AppColors.redGradient,
                                    ],
                                  )
                                : null,
                            color: isPremium ? null : AppColors.lightGray,
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: !isPremium
                                ? null
                                : [
                                    BoxShadow(
                                      color: AppColors.redGradient.withAlpha(
                                        50,
                                      ),
                                      offset: Offset(0, 4),
                                      blurRadius: 12,
                                    ),
                                  ],
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              !isPremium ? AppAssets.flash : AppAssets.king,
                              width: 20.sp,
                              colorFilter: ColorFilter.mode(
                                !isPremium
                                    ? AppColors.iconGray
                                    : AppColors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        12.wBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: isPremium
                                    ? AppColors.white
                                    : AppColors.black,
                              ),
                            ),
                            Text(
                              subtitle,
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: isPremium
                                    ? AppColors.white.withOpacity(0.6)
                                    : AppColors.iconGray,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          price,
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w900,
                            color: isPremium
                                ? AppColors.white
                                : AppColors.black,
                          ),
                        ),
                        Text(
                          period,
                          style: TextStyle(
                            fontSize: 10.5.sp,
                            color: isPremium
                                ? AppColors.white.withOpacity(0.6)
                                : AppColors.iconGray,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                12.hBox,
                Divider(
                  color: isPremium
                      ? Colors.white.withAlpha(20)
                      : Colors.black.withAlpha(12),
                ),
                12.hBox,
                ...features.map(
                  (f) => Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Row(
                      children: [
                        Container(
                          width: 36.sp,
                          height: 36.sp,
                          decoration: BoxDecoration(
                            color: (isPremium
                                ? AppColors.white.withAlpha(20)
                                : f['included']
                                ? AppColors.pinkGradient.withAlpha(20)
                                : AppColors.black.withAlpha(10)),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: f['icon'] is String
                                ? SvgPicture.asset(
                                    f['icon'] as String,
                                    width: 18.sp,
                                    colorFilter: ColorFilter.mode(
                                      isPremium
                                          ? AppColors.white
                                          : (f['included']
                                                ? AppColors.pinkGradient
                                                : AppColors.lightGray18),
                                      BlendMode.srcIn,
                                    ),
                                  )
                                : Icon(
                                    f['icon'] as IconData,
                                    size: 18.sp,
                                    color: isPremium
                                        ? AppColors.white
                                        : (f['included']
                                              ? AppColors.pinkGradient
                                              : AppColors.lightGray18),
                                  ),
                          ),
                        ),
                        14.wBox,
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: f['text'],
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: isPremium
                                        ? AppColors.white
                                        : (f['included']
                                              ? AppColors.black
                                              : AppColors.lightGray18),
                                    fontWeight: f['included']
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                ),
                                if (f['suffix'] != null)
                                  TextSpan(
                                    text: " ${f['suffix']}",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: isPremium
                                          ? AppColors.white.withOpacity(0.6)
                                          : AppColors.iconGray,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 20.h,
                          width: 20.h,
                          decoration: BoxDecoration(
                            color: f['included']
                                ? (isPremium
                                      ? Colors.white.withAlpha(40)
                                      : AppColors.pinkGradient.withAlpha(50))
                                : (isPremium
                                      ? AppColors.white.withAlpha(20)
                                      : AppColors.black.withAlpha(10)),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              f['included'] ? Icons.done : Icons.clear,
                              color: f['included']
                                  ? AppColors.white
                                  : (isPremium
                                        ? AppColors.white.withOpacity(0.2)
                                        : AppColors.badgeGray),
                              size: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                5.hBox,
              ],
            ),
          ),
        ),
        if (isPremium)
          Positioned(
            top: -12.h,
            right: 16.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.pinkGradient, AppColors.redGradient],
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.redGradient.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    AppAssets.king,
                    width: 10.sp,
                    colorFilter: const ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  4.wBox,
                  Text(
                    AppStrings.popular,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
