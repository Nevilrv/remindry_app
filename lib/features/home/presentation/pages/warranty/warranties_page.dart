import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_strings.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:untitled1/core/utils/widgets/app_button.dart';
import 'package:untitled1/core/utils/widgets/common_app_bar_remindry.dart';

import '../../../../../routes/app_routes.dart';
import '../../providers/warranty_provider.dart';

class WarrantiesPage extends ConsumerStatefulWidget {
  const WarrantiesPage({super.key});

  @override
  ConsumerState<WarrantiesPage> createState() => _WarrantiesPageState();
}

class _WarrantiesPageState extends ConsumerState<WarrantiesPage> {
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(warrantyProvider).fetchWarranties(status: 'active'));
  }

  void _onTabChanged(int index) {
    if (_selectedTab == index) return;
    setState(() => _selectedTab = index);
    ref.read(warrantyProvider).fetchWarranties(status: index == 0 ? 'active' : 'expire');
  }

  @override
  Widget build(BuildContext context) {
    final warrantyWatch = ref.watch(warrantyProvider);
    final warranties = warrantyWatch.warrantiesResponse?.data?.warranties ?? [];

    return Scaffold(
      backgroundColor: AppColors.lightGray6,
      body: Column(
        children: [
          CommonAppBarRemindry(title: AppStrings.warranties, subtitle: AppStrings.joinRemindry),
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
                        onTap: () => _onTabChanged(0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: _selectedTab == 0
                                ? const LinearGradient(
                                    colors: [AppColors.pinkGradient, AppColors.redGradient],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(23.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "${AppStrings.activeWarranties} (${warranties.length})",
                            style: TextStyle(
                              color: _selectedTab == 0 ? AppColors.white : AppColors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _onTabChanged(1),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: _selectedTab == 1
                                ? const LinearGradient(
                                    colors: [AppColors.pinkGradient, AppColors.redGradient],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(23.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "${AppStrings.expiredWarranties}",
                            style: TextStyle(color: _selectedTab == 1 ? AppColors.white : AppColors.secondary, fontWeight: FontWeight.w500),
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
          Expanded(
            child: warrantyWatch.isLoading
                ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                : warranties.isEmpty
                ? Center(
                    child: Text(AppStrings.nothingHere, style: TextStyle(color: AppColors.badgeGrayText)),
                  )
                : Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(22.r),
                        border: Border.all(color: const Color(0xffE4E4E7), width: 1),
                      ),
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: warranties.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: const Divider(color: AppColors.extraLightGray, height: 0),
                        ),
                        itemBuilder: (context, index) {
                          final warranty = warranties[index];
                          final expiryDate = warranty.warrantyDuration != null
                              ? DateFormat('MMM dd, yyyy').format(warranty.warrantyDuration!.toLocal())
                              : '';

                          return _WarrantyCard(
                            title: warranty.productName ?? '',
                            subtitle: "Expires $expiryDate",
                            icon: _getCategoryIcon(warranty.category),
                            iconBg: _getCategoryBg(warranty.category),
                            iconColor: _getCategoryColor(warranty.category),
                            status: "ACTIVE",
                            statusColor: Colors.green,
                          );
                        },
                      ),
                    ),
                  ),
          ),
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

  String _getCategoryIcon(String? category) {
    switch (category?.toLowerCase()) {
      case "electronics":
        return AppAssets.headphone;
      case "appliances":
        return AppAssets.medical;
      case "furniture":
        return AppAssets.medical;
      default:
        return AppAssets.medical;
    }
  }

  Color _getCategoryBg(String? category) {
    switch (category?.toLowerCase()) {
      case "electronics":
        return const Color(0xffF3E8FF);
      case "appliances":
        return const Color(0xffDCFCE7);
      case "furniture":
        return const Color(0xffFEF3C7);
      default:
        return AppColors.lightGray.withOpacity(0.1);
    }
  }

  Color _getCategoryColor(String? category) {
    switch (category?.toLowerCase()) {
      case "electronics":
        return const Color(0xffA855F7);
      case "appliances":
        return const Color(0xff22C55E);
      case "furniture":
        return const Color(0xffD97706);
      default:
        return AppColors.secondary;
    }
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
          decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12.r)),
          child: Center(
            child: SvgPicture.asset(icon, colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn), height: 18.sp, width: 18.sp),
          ),
        ),
        8.wBox,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.black),
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
          decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(30.r)),
          child: Center(
            child: Text(
              status,
              style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
