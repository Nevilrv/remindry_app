import 'package:country_picker/country_picker.dart';
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

import '../../../routes/app_routes.dart';

class EditPhoneNumberScreen extends ConsumerWidget {
  const EditPhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: AppColors.lightGray15,
      appBar: CommonAppBarRemindry(title: "Edit Phone Number", onBack: () => context.pop()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            30.hBox,
            _buildProfileIcon(),
            10.hBox,
            Text(
              "Update your contact number",
              style: TextStyle(fontSize: 13.sp, color: AppColors.gray1, fontWeight: FontWeight.w400),
            ),
            22.hBox,

            _buildLabel("PHONE NUMBER"),
            8.hBox,
            _buildPhoneField(context, provider),
            14.hBox,

            _buildVerificationCard(context: context),
            Spacer(),
            Expanded(
              child: Center(
                child: AppButton(
                  onTap: () {
                    // Navigate to verify code or logic
                  },
                  title: "Verify First",
                  icon: Icon(Icons.done_all_rounded, color: AppColors.white, size: 20.sp),
                ),
              ),
            ),
            21.hBox,
          ],
        ),
      ),
    );
  }

  Widget _buildProfileIcon() {
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
        boxShadow: [BoxShadow(color: AppColors.redGradient.withOpacity(0.3), blurRadius: 30, offset: const Offset(0, 10))],
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset(AppAssets.call_1, width: 32.r, colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn)),
    );
  }

  Widget _buildLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: AppColors.gray1, letterSpacing: 0.5),
      ),
    );
  }

  Widget _buildPhoneField(BuildContext context, ProfileProvider provider) {
    final country = provider.selectedCountry;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.lightGray4, width: 1.5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: true,
                    onSelect: (Country country) {
                      provider.setCountry(country);
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 21.h),
                  child: Row(
                    children: [
                      Text(country.flagEmoji, style: TextStyle(fontSize: 18.sp)),
                      SizedBox(width: 4.w),
                      Text(
                        "+${country.phoneCode}",
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.black1),
                      ),
                      // SizedBox(width: 4.w),
                      Icon(Icons.keyboard_arrow_down_rounded, size: 18.sp, color: AppColors.gray1),
                    ],
                  ),
                ),
              ),
              Container(width: 1.5, height: 65.h, color: AppColors.lightGray4),
              Expanded(
                child: TextField(
                  controller: provider.phoneController,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.black2),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Enter number",
                    hintStyle: TextStyle(color: AppColors.gray1.withOpacity(0.4), fontSize: 16.sp, fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  ),
                ),
              ),
              if (provider.phoneController.text.isNotEmpty)
                GestureDetector(
                  onTap: () => provider.clearPhone(),
                  child: Container(
                    margin: EdgeInsets.only(right: 16.w),
                    padding: EdgeInsets.all(6.r),
                    decoration: BoxDecoration(color: AppColors.lightGray10, shape: BoxShape.circle),
                    child: SvgPicture.asset(AppAssets.close),
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Divider(height: 1, color: AppColors.extraLightGray),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "+${country.phoneCode} (${provider.phoneController.text.substring(0, provider.phoneController.text.length > 3 ? 3 : provider.phoneController.text.length)}) 000-0000",
                  style: TextStyle(fontSize: 12.sp, color: AppColors.iconGray, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Icon(Icons.check_rounded, color: AppColors.green, size: 14.sp),
                    Text(
                      "Valid",
                      style: TextStyle(fontSize: 11.5.sp, color: AppColors.green, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationCard({required BuildContext context}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 14.w),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.8), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            child: SvgPicture.asset(AppAssets.lock, width: 18.r, colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn)),
          ),
          12.wBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Verification required",
                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColors.black1),
                ),
                // 4.hBox,
                Text(
                  "We'll send a 6-digit code to verify this number.",
                  style: TextStyle(fontSize: 11.sp, color: AppColors.gray1, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              context.pushNamed(AppRoutes.verifyCode, extra: true);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: AppColors.redGradient.withOpacity(0.3), blurRadius: 30, offset: const Offset(0, 10))],

                gradient: const LinearGradient(
                  colors: [AppColors.pinkGradient, AppColors.redGradient],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                "Send",
                style: TextStyle(color: AppColors.white, fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
