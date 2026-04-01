import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/extentions/extentions.dart';

import '../../../../../core/constant/app_strings.dart';
import '../../../../../core/utils/widgets/common_app_bar_remindry.dart';
import '../../../../../routes/app_routes.dart';

class VaultView extends StatefulWidget {
  const VaultView({super.key});

  @override
  State<VaultView> createState() => _VaultViewState();
}

class _VaultViewState extends State<VaultView> {
  final ImagePicker _picker = ImagePicker();
  int _selectedCategoryIndex = 0;
  final List<String> _categories = [
    AppStrings.allFiles,
    AppStrings.medical,
    AppStrings.warranties,
    AppStrings.bills,
  ];

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Selected: ${image.name}'),
            backgroundColor: AppColors.primary,
          ),
        );
      }
    }
  }

  void _showUploadBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(24.r),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            24.hBox,
            _UploadOption(
              icon: AppAssets.camera,
              iconColor: AppColors.white,
              iconBg: AppColors.primary,
              containerBg: AppColors.primaryLight1,
              title: AppStrings.takePhotoScan,
              subtitle: AppStrings.autoDetectDocuments,
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            16.hBox,
            _UploadOption(
              icon: AppAssets.gallery,
              iconColor: AppColors.black,
              iconBg: AppColors.lightGray11,
              containerBg: AppColors.white,
              borderColor: AppColors.lightGray4,
              title: AppStrings.uploadFromGallery,
              subtitle: AppStrings.selectExistingPhoto,
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),

            24.hBox,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAppBarRemindry(
              title: AppStrings.documentVault,
              subtitle: AppStrings.joinRemindry,
              showBackButton: false,
            ),

            16.hBox,
            // Chips and Add Button
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50.h,
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    decoration: BoxDecoration(
                      color: AppColors.lightGray11,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Row(
                      children: List.generate(
                        _categories.length,
                        (index) => _CategoryChip(
                          label: _categories[index],
                          isSelected: _selectedCategoryIndex == index,
                          onTap: () =>
                              setState(() => _selectedCategoryIndex = index),
                        ),
                      ),
                    ),
                  ),
                ),
                12.wBox,
                GestureDetector(
                  onTap: () => _showUploadBottomSheet(),
                  child: SvgPicture.asset(
                    AppAssets.add,
                    height: 46.h,
                    width: 46.h,
                  ),
                ),
              ],
            ),
            30.hBox,
            // Document List
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: AppColors.lightGray4, width: 1.5),
              ),
              child: Column(
                children: [
                  _DocumentTile(
                    icon: AppAssets.gallery,
                    iconBg: AppColors.primaryLight1,
                    title: AppStrings.xrayScanJpg,
                    subtitle: AppStrings.jan15Size,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: const Divider(
                      height: 1,
                      color: AppColors.extraLightGray,
                    ),
                  ),
                  _DocumentTile(
                    icon: AppAssets.reportdoc,
                    iconBg: AppColors.lightBlue,
                    title: AppStrings.bloodTestReportPdf,
                    subtitle: AppStrings.addedYesterdaySize,
                    showAiBadge: true,
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

class _UploadOption extends StatelessWidget {
  final String icon;
  final Color iconColor;
  final Color iconBg;
  final Color containerBg;
  final Color? borderColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _UploadOption({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.containerBg,
    this.borderColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: containerBg,
          borderRadius: BorderRadius.circular(15.r),
          border: borderColor != null ? Border.all(color: borderColor!) : null,
        ),
        child: Row(
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  width: 24.sp,
                  height: 24.sp,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                ),
              ),
            ),
            16.wBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                4.hBox,
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 13.sp, color: AppColors.secondary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            gradient: isSelected
                ? const LinearGradient(
                    colors: [AppColors.pinkGradient, AppColors.redGradient],
                    begin: AlignmentGeometry.topCenter,
                    end: AlignmentGeometry.bottomCenter,
                  )
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
              color: isSelected ? AppColors.white : AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class _DocumentTile extends StatelessWidget {
  const _DocumentTile({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    this.showAiBadge = false,
  });

  final String icon;
  final Color iconBg;
  final String title;
  final String subtitle;
  final bool showAiBadge;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: SvgPicture.asset(
                icon,
                width: 24.sp,
                height: 24.sp,
                colorFilter: icon.contains("gallery")
                    ? const ColorFilter.mode(Color(0xffEF4444), BlendMode.srcIn)
                    : const ColorFilter.mode(
                        Color(0xff4F46E5),
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
                  title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackLight,
                  ),
                ),
                4.hBox,
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12.sp, color: AppColors.secondary),
                ),
              ],
            ),
          ),
          if (showAiBadge)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 5.5.h),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Text(
                "AI",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 8.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
