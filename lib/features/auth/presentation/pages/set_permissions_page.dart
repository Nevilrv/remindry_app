import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_strings.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:untitled1/core/utils/widgets/app_button.dart';
import 'package:untitled1/features/auth/presentation/providers/permissions_provider.dart';
import 'package:untitled1/routes/app_routes.dart';

import '../../../../core/utils/widgets/common_dialog.dart';

class SetPermissionsPage extends ConsumerWidget {
  const SetPermissionsPage({super.key});

  void _showAllSetPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => const CommonDialog(
        illustration: AppAssets.allSet,
        title: "You're All Set!",
        description: "Awesome! OTP Verified - You're\nLogged In!",
      ),
    ).then((_) {
      if (context.mounted) {
        context.goNamed(AppRoutes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(permissionsProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              40.hBox,

              // Title
              Text(
                AppStrings.setPermissions,
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackLight,
                ),
              ),
              8.hBox,

              // Subtitle
              Text(
                AppStrings.permissionsSubtitle,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.gray1,
                  fontWeight: FontWeight.w400,
                ),
              ),
              32.hBox,

              // Permission tiles
              Column(
                children: [
                  _PermissionTile(
                    title: AppStrings.ocrScan,
                    description: AppStrings.ocrDesc,
                    value: provider.ocrScan,
                    onChanged: provider.toggleOcr,
                  ),
                  16.hBox,
                  _PermissionTile(
                    title: AppStrings.reminders,
                    description: AppStrings.remindersDesc,
                    value: provider.reminders,
                    onChanged: provider.toggleReminders,
                  ),
                  16.hBox,
                  _PermissionTile(
                    title: AppStrings.location,
                    description: AppStrings.locationDesc,
                    value: provider.location,
                    onChanged: provider.toggleLocation,
                  ),
                ],
              ),

              const Spacer(),

              // Get Started button
              Center(
                child: AppButton(
                  onTap: () => _showAllSetPopup(context),
                  title: AppStrings.getStarted,
                ),
              ),
              16.hBox,

              // Skip for now
              Center(
                child: GestureDetector(
                  onTap: () => context.pop(),
                  child: Text(
                    AppStrings.skipForNow,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              24.hBox,
            ],
          ),
        ),
      ),
    );
  }
}

class _PermissionTile extends StatelessWidget {
  const _PermissionTile({
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.lightGray1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackLight,
                  ),
                ),
                6.hBox,
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.secondary,
                    // height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.white,
            trackOutlineColor: WidgetStateProperty.resolveWith((states) {
              return AppColors.lightGray2;
            }),
            activeTrackColor: AppColors.secondary,
            inactiveThumbColor: AppColors.white,
            inactiveTrackColor: AppColors.lightGray2,
          ),
        ],
      ),
    );
  }
}
