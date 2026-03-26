import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/core/constant/app_%20text_style.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/extentions/extentions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppAssets.bg3, fit: BoxFit.cover, width: double.infinity),

          // // Background Gradient
          // Positioned.fill(
          //   child: Container(
          //     decoration: const BoxDecoration(
          //       image: DecorationImage(image: AssetImage(AppAssets.bg3)),
          //       // gradient: LinearGradient(
          //       //   colors: [Color(0xFFFDF0F5), Color(0xFFF6E8FF), Colors.white],
          //       //   begin: Alignment.topCenter,
          //       //   end: Alignment.bottomCenter,
          //       // ),
          //     ),
          //   ),
          // ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
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
                  _buildPersonalInfoCard(),
                  SizedBox(height: 20.h),

                  // Upgrade to Premium Card
                  _buildPremiumCard(),
                  SizedBox(height: 20.h),

                  // Account Details Card
                  _buildAccountDetailsCard(),
                  SizedBox(height: 20.h),

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

        SizedBox(
          width: 55.h,
          child: Align(alignment: Alignment.centerRight, child: SvgPicture.asset(AppAssets.setting)),
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

  Widget _buildPersonalInfoCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(22.r),
        // boxShadow: [BoxShadow(color: AppColors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        children: [
          _buildInfoItem(AppAssets.person, "Full Name", "John Doe"),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Divider(height: 1, thickness: 1, color: AppColors.lightGray1),
          ),
          _buildInfoItem(AppAssets.call, "Phone Number", "+1 (555) 000-0000"),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String asset, String title, String value) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            gradient: const LinearGradient(
              colors: [AppColors.pinkGradient, AppColors.redGradient],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SvgPicture.asset(
            asset,
            width: 20.sp,
            colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 12.sp, color: AppColors.secondary),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: AppColors.blackLight),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [AppColors.pinkGradient, AppColors.redGradient],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.redGradient.withOpacity(0.35),
                blurRadius: 12,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: SvgPicture.asset(
            AppAssets.edit,
            width: 14.r,
            colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
          ),
        ),
      ],
    );
  }

  Widget _buildPremiumCard() {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1B143F),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [BoxShadow(color: const Color(0xFF1B143F).withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(color: AppColors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(12.r)),
                child: const Icon(Icons.workspace_premium, color: AppColors.pinkGradient, size: 24),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Upgrade to Premium",
                      style: TextStyle(color: AppColors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 2.h),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Unlock every feature\n— from ",
                            style: TextStyle(color: AppColors.white.withOpacity(0.6), fontSize: 11.sp),
                          ),
                          TextSpan(
                            text: "\$4.99/mo",
                            style: TextStyle(color: AppColors.pinkGradient, fontSize: 11.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [AppColors.pinkGradient, AppColors.redGradient]),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 4))],
                ),
                child: Row(
                  children: [
                    Icon(Icons.bolt, color: AppColors.white, size: 14.sp),
                    SizedBox(width: 4.w),
                    Text(
                      "Go Premium",
                      style: TextStyle(color: AppColors.white, fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              _buildFeatureChip("Unlimited"),
              SizedBox(width: 8.w),
              _buildFeatureChip("No Ads"),
              SizedBox(width: 8.w),
              _buildFeatureChip("WhatsApp"),
              const Spacer(),
              Icon(Icons.more_horiz, color: AppColors.white.withOpacity(0.4), size: 16.sp),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(color: AppColors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(20.r)),
      child: Text(
        label,
        style: TextStyle(color: AppColors.white.withOpacity(0.8), fontSize: 10.sp),
      ),
    );
  }

  Widget _buildAccountDetailsCard() {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(24.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Account",
            style: TextStyle(fontSize: 12.sp, color: AppColors.secondary),
          ),
          SizedBox(height: 16.h),
          _buildDetailRow("Member since", "March 2024"),
          SizedBox(height: 12.h),
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
          style: TextStyle(color: AppColors.secondary.withOpacity(0.7), fontSize: 14.sp),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.blackLight),
        ),
      ],
    );
  }

  Widget _buildHealthScoreCard() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(24.r)),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(color: AppColors.primaryLight1, borderRadius: BorderRadius.circular(16.r)),
            child: SvgPicture.asset(
              AppAssets.heartlayer,
              width: 24.r,
              colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Health Score",
                  style: TextStyle(fontSize: 12.sp, color: AppColors.secondary),
                ),
                Text(
                  "85%",
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.blackLight),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(color: AppColors.extraLightGray, borderRadius: BorderRadius.circular(20.r)),
            child: Text(
              "+5% this week",
              style: TextStyle(fontSize: 12.sp, color: AppColors.secondary),
            ),
          ),
        ],
      ),
    );
  }
}
