import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/core/constant/app_%20text_style.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:untitled1/routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppAssets.bg3, fit: BoxFit.cover, width: double.infinity),

          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  16.hBox,

                  // Custom Header
                  _buildHeader(context),
                  28.hBox, // Avatar
                  _buildProfileAvatar(),
                  14.hBox,
                  Text(
                    "John Doe",
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.black1),
                  ),
                  // SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Good Afternoon",
                        style: TextStyle(fontSize: 13.sp, color: AppColors.gray1, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(width: 4.w),
                      Text("👋", style: TextStyle(fontSize: 14.sp)),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  // Info Cards
                  _buildPersonalInfoCard(context),
                  SizedBox(height: 17.h),

                  // Upgrade to Premium Card
                  _buildPremiumCard(context),
                  SizedBox(height: 17.h),

                  // Account Details Card
                  _buildAccountDetailsCard(),
                  SizedBox(height: 17.h),

                  // Health Score Card
                  _buildHealthScoreCard(),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            width: 52.h,
            height: 52.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.lightGray1),
            ),
            child: Center(
              child: Icon(Icons.arrow_back_ios_new_rounded, size: 18.sp, color: AppColors.blackLight),
            ),
          ),
        ),
        Spacer(),
        Text(
          "Profile",
          style: AppTextStyle.f16boldBlack.copyWith(fontSize: 17.sp, color: AppColors.black1),
        ),
        Spacer(),

        GestureDetector(
          onTap: () => context.push(AppRoutes.settings),
          child: SizedBox(
            width: 55.h,
            child: Align(alignment: Alignment.centerRight, child: SvgPicture.asset(AppAssets.setting)),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileAvatar() {
    return Container(
      width: 100.r,
      height: 100.r,
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
      child: Text(
        "JD",
        style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w800, color: AppColors.white),
      ),
    );
  }

  Widget _buildPersonalInfoCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: AppColors.lightGray4),
        // boxShadow: [BoxShadow(color: AppColors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        children: [
          _buildInfoItem(AppAssets.person, "Full Name", "John Doe", onEdit: () => context.pushNamed(AppRoutes.editFullName)),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Divider(height: 1, color: AppColors.lightGray3),
          ),
          _buildInfoItem(
            AppAssets.call_1,
            "Phone Number",
            "+1 (555) 000-0000",
            onEdit: () => context.pushNamed(AppRoutes.editPhoneNumber),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String asset, String title, String value, {VoidCallback? onEdit}) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            gradient: const LinearGradient(
              colors: [AppColors.pinkGradient, AppColors.redGradient],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SvgPicture.asset(asset, width: 20.sp, colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn)),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 10.sp, color: AppColors.gray1, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.black2),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onEdit,
          child: Container(
            padding: EdgeInsets.all(11.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppColors.pinkGradient, AppColors.redGradient],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              // boxShadow: [BoxShadow(color: AppColors.redGradient, blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: SvgPicture.asset(AppAssets.edit_1, width: 17.r),
          ),
        ),
      ],
    );
  }

  Widget _buildPremiumCard(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.goPremium),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.5.h, horizontal: 17.5.w),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.pinkGradient.withValues(alpha: 0.35), width: 3),
          gradient: const LinearGradient(
            colors: [Color(0xFF1B0D31), Color(0xFF2D1B4E), Color(0xFF1B0D31)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 10))],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(11.w),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.pinkGradient, AppColors.redGradient],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [BoxShadow(color: AppColors.redGradient.withValues(alpha: 0.4), blurRadius: 20, offset: const Offset(0, 10))],
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppAssets.king,
                      width: 18.r,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Upgrade to\nPremium",
                        style: TextStyle(color: AppColors.white, fontSize: 14.sp, fontWeight: FontWeight.w800),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Unlock every feature\n— from ",
                              style: TextStyle(color: AppColors.white.withValues(alpha: 0.45), fontSize: 11.sp, fontWeight: FontWeight.w400),
                            ),
                            TextSpan(
                              text: "\$4.99/mo",
                              style: TextStyle(
                                color: AppColors.pinkGradient.withValues(alpha: 0.9),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 11.h),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [AppColors.pinkGradient, AppColors.redGradient]),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [BoxShadow(color: AppColors.redGradient.withValues(alpha: 0.4), blurRadius: 20, offset: const Offset(0, 10))],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(AppAssets.goPremium),
                      SizedBox(width: 5.w),
                      Text(
                        "Go Premium",
                        style: TextStyle(color: AppColors.white, fontSize: 13.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFeatureChip(AppAssets.king, "Unlimited"),
                  SizedBox(width: 7.w),
                  _buildFeatureChip(AppAssets.ads, "No Ads"),
                  SizedBox(width: 7.w),
                  _buildFeatureChip(AppAssets.chat, "WhatsApp"),
                  SizedBox(width: 7.w),
                  _buildFeatureChip(AppAssets.backup, "Backup"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureChip(String asset, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.1), width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(asset, width: 12.r, colorFilter: const ColorFilter.mode(AppColors.pinkGradient, BlendMode.srcIn)),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(color: AppColors.white.withValues(alpha: 0.7), fontSize: 11.sp, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountDetailsCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 17.h),

      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.lightGray4, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Account",
            style: TextStyle(fontSize: 12.sp, color: AppColors.gray1, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 17.h),
          _buildDetailRow("Member since", "March 2024"),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 9.h),
            child: Divider(color: AppColors.extraLightGray, height: 2),
          ),

          // SizedBox(height: 12.h),
          _buildDetailRow("Plan", "Premium"),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 13.sp, color: AppColors.gray1, fontWeight: FontWeight.w400),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: AppColors.black2),
        ),
      ],
    );
  }

  Widget _buildHealthScoreCard() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.lightGray4, width: 2),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(11.w),
            // width: 54.r,
            // height: 54.r,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.pinkGradient, AppColors.redGradient],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppAssets.heart,
                width: 18.r,
                // colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Health Score",
                  style: TextStyle(fontSize: 11.sp, color: AppColors.gray1, fontWeight: FontWeight.w400),
                ),
                Text(
                  "85%",
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.black1),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 9.h),
            decoration: BoxDecoration(color: AppColors.lightGray3, borderRadius: BorderRadius.circular(36.r)),
            child: Text(
              "+5% this week",
              style: TextStyle(fontSize: 10.sp, color: AppColors.black1, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
