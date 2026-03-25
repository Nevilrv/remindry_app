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

class WarrantiesPage extends StatefulWidget {
  const WarrantiesPage({super.key});

  @override
  State<WarrantiesPage> createState() => _WarrantiesPageState();
}

class _WarrantiesPageState extends State<WarrantiesPage> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray6,
      body: Column(
        children: [
          CommonAppBarRemindry(
            title: AppStrings.warranties,
            subtitle: AppStrings.joinRemindry,
          ),
          20.hBox,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Container(
              height: 50.h,
              decoration: BoxDecoration(
                color: AppColors.lightGray11,
                borderRadius: BorderRadius.circular(23.r),
                border: Border.all(color: AppColors.lightGray12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTab = 0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: _selectedTab == 0
                                ? const LinearGradient(
                                    colors: [
                                      AppColors.pinkGradient,
                                      AppColors.redGradient,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(23.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            AppStrings.activeWarranties,
                            style: TextStyle(
                              color: _selectedTab == 0
                                  ? AppColors.white
                                  : AppColors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTab = 1),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: _selectedTab == 1
                                ? const LinearGradient(
                                    colors: [
                                      AppColors.pinkGradient,
                                      AppColors.redGradient,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(23.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            AppStrings.expiredWarranties,
                            style: TextStyle(
                              color: _selectedTab == 1
                                  ? AppColors.white
                                  : AppColors.secondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          26.hBox,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: const Color(0xffF1F5F9)),
            ),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                _WarrantyCard(
                  title: "Sony Headphones",
                  subtitle: "Expires Mar 10, 2026",
                  icon: AppAssets.headphone,
                  iconBg: const Color(0xffF3E8FF),
                  iconColor: const Color(0xffA855F7),
                  status: "SOON",
                  statusColor: AppColors.red,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Divider(color: AppColors.extraLightGray, height: 0),
                ),
                _WarrantyCard(
                  title: "iPhone 15 Pro",
                  subtitle: "Expires Sep 24, 2026",
                  icon: AppAssets.iphone,
                  iconBg: const Color(0xffDCFCE7),
                  iconColor: const Color(0xff22C55E),
                  status: "ACTIVE",
                  statusColor: Colors.green,
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
            child: AppButton(
              onTap: () => context.pushNamed(AppRoutes.addWarranty),
              title: AppStrings.addWarrantyDetails,
              icon: Icon(Icons.add, color: AppColors.white, size: 20.sp),
            ),
          ),
          10.hBox,
        ],
      ),
    );
  }
}

class _WarrantyCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final Color iconBg;
  final Color iconColor;
  final String status;
  final Color statusColor;

  const _WarrantyCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 39.h,
          width: 39.h,
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              height: 18.sp,
              width: 18.sp,
            ),
          ),
        ),
        8.wBox,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
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
        Container(
          width: 50.w,
          height: 21.h,
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Center(
            child: Text(
              status,
              style: TextStyle(
                fontSize: 8.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
