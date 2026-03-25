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

class ScanDocumentPage extends StatelessWidget {
  const ScanDocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray6,
      appBar: const CommonAppBarRemindry(
        title: AppStrings.scanDocument,
        subtitle: AppStrings.chooseScanningMethod,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: Column(
          children: [
            _ScanOption(
              icon: AppAssets.camera,
              iconBg: AppColors.primary,
              iconColor: Colors.white,
              containerBg: AppColors.primaryLight1,
              title: AppStrings.takePhotoScan,
              subtitle: AppStrings.autoDetectDocuments,
              onTap: () => context.push(AppRoutes.reviewDocument),
              subTitleColor: AppColors.primary,
            ),
            16.hBox,
            _ScanOption(
              icon: AppAssets.gallery,
              iconBg: AppColors.lightGray10,
              iconColor: AppColors.black,
              containerBg: AppColors.white,
              borderColor: AppColors.lightGray9,
              title: AppStrings.uploadFromGallery,
              subtitle: AppStrings.selectExistingPhoto,
              onTap: () => context.push(AppRoutes.reviewDocument),
              subTitleColor: Colors.black,
            ),
            const Spacer(),
            Text(
              AppStrings.documentsProcessedLocally,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10.sp,
                color: AppColors.black,
                height: 1.5,
              ),
            ),
            16.hBox,
          ],
        ),
      ),
    );
  }
}

class _ScanOption extends StatelessWidget {
  final String icon;
  final Color iconBg;
  final Color iconColor;
  final Color containerBg;
  final Color? borderColor;
  final Color? subTitleColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ScanOption({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.containerBg,
    this.borderColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.subTitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: containerBg,
          borderRadius: BorderRadius.circular(20.r),
          border: borderColor != null ? Border.all(color: borderColor!) : null,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: SvgPicture.asset(
                icon,
                width: 18.sp,
                height: 18.sp,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
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
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  4.hBox,
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 10.sp, color: subTitleColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
