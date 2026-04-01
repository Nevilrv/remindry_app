import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:untitled1/core/utils/widgets/app_button.dart';
import 'package:untitled1/core/utils/widgets/common_app_bar_remindry.dart';
import 'package:untitled1/features/profile/provider/profile_provider.dart';

class EditFullNameScreen extends ConsumerWidget {
  const EditFullNameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: AppColors.lightGray15,
      appBar: CommonAppBarRemindry(
        title: "Edit Full Name",
        onBack: () => context.pop(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            30.hBox,
            _buildProfileAvatar(),
            11.hBox,
            Text(
              "Preview — how others see you",
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.gray1,
                fontWeight: FontWeight.w400,
              ),
            ),
            24.hBox,
            _buildLabel("FULL NAME"),
            8.hBox,
            _buildFullNameField(provider),
            10.hBox,

            Row(
              children: [
                Expanded(
                  child: _buildSmallField(
                    "First name",
                    provider.firstNameController,
                  ),
                ),
                10.wBox,
                Expanded(
                  child: _buildSmallField(
                    "Last name",
                    provider.lastNameController,
                  ),
                ),
              ],
            ),
            12.hBox,

            _buildGenderDropdown(provider),
            60.hBox,

            _buildQuickTipCard(),
            60.hBox,

            Center(
              child: AppButton(
                onTap: () => context.pop(),
                title: "Save Name",
                icon: Icon(
                  Icons.done_all_rounded,
                  color: AppColors.white,
                  size: 20.sp,
                ),
              ),
            ),
            30.hBox,
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Container(
      width: 72.r,
      height: 72.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [AppColors.pinkGradient, AppColors.redGradient],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.redGradient.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        "JD",
        style: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.w800,
          color: AppColors.white,
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.gray1,
        ),
      ),
    );
  }

  Widget _buildFullNameField(ProfileProvider provider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.lightGray4, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.pinkGradient, AppColors.redGradient],

                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: SvgPicture.asset(
                  AppAssets.person,
                  width: 18.r,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              12.wBox,
              Expanded(
                child: TextField(
                  controller: provider.fullNameController,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black2.withValues(alpha: 0.5),
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => provider.clearFullName(),
                child: Container(
                  padding: EdgeInsets.all(6.r),
                  decoration: BoxDecoration(
                    color: AppColors.lightGray10,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(AppAssets.close),
                ),
              ),
            ],
          ),
          12.hBox,
          Divider(height: 1, color: AppColors.extraLightGray),
          // 14.hBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.check_rounded,
                    color: AppColors.green,
                    size: 16.sp,
                  ),
                  6.wBox,
                  Text(
                    "Looks good!",
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      color: AppColors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Text(
                "${provider.fullNameController.text.length}/50",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.iconGray,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          11.hBox,
        ],
      ),
    );
  }

  Widget _buildSmallField(String label, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 11.h),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.65),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.85),
          width: 1,
        ),

        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              color: AppColors.iconGray,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextField(
            controller: controller,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black1,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderDropdown(ProfileProvider provider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 11.h),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.85),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gender",
            style: TextStyle(
              fontSize: 10.sp,
              color: AppColors.iconGray,
              fontWeight: FontWeight.w500,
            ),
          ),
          4.hBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                provider.selectedGender,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black1,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.black2,
                size: 24.r,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickTipCard() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),

        border: Border.all(
          color: Colors.white.withValues(alpha: 0.75),
          width: 1,
        ),
        color: AppColors.white.withValues(alpha: 0.55),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            AppAssets.lampContainer,
            width: 28.h,
            height: 28.h,
            fit: BoxFit.fill,
          ),
          10.wBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Quick tip",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black1,
                  ),
                ),
                Text(
                  "Use your real name so Smart AI health providers can recognise you.",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.gray1,
                    fontWeight: FontWeight.w400,
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
