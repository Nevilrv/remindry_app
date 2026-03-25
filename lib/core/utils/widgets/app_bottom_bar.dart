import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/features/home/presentation/providers/home_provider.dart';

import '../../../routes/app_routes.dart';

class AppBottomBar extends ConsumerWidget {
  const AppBottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(homeProvider);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: 5.h),
        width: 260.w,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(34.r),
          gradient: const RadialGradient(
            colors: [Color(0xFFF4F4F4), Color(0xFFDDDEE0)],
            stops: [0.61, 1.0],
            center: Alignment.center,
            radius: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(34.r),
                  color: Colors.black,
                ),
                padding: EdgeInsets.symmetric(horizontal: 17.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavItem(
                      selectedIcon: AppAssets.homeSelected,
                      unselectedIcon: AppAssets.homeUnSelect,
                      label: "Home",
                      isSelected: provider.selectedTab == 0,
                      onTap: () => provider.setTab(0),
                    ),
                    12.wBox,
                    _NavItem(
                      selectedIcon: AppAssets.vaultSelected,
                      unselectedIcon: AppAssets.vaultUnSelect,
                      label: "Vault",
                      isSelected: provider.selectedTab == 1,
                      onTap: () => provider.setTab(1),
                    ),
                    12.wBox,
                    _NavItem(
                      selectedIcon: AppAssets.settingSelected,
                      unselectedIcon: AppAssets.settingUnSelect,
                      label: "Settings",
                      isSelected: provider.selectedTab == 2,
                      onTap: () => provider.setTab(2),
                    ),
                  ],
                ),
              ),
            ),
            8.wBox,
            _AiNavItem(onTap: () => context.push(AppRoutes.aiStart)),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String selectedIcon;
  final String unselectedIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(vertical: 15.h),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(
              isSelected ? selectedIcon : unselectedIcon,
              width: 20.sp,
              height: 20.sp,
            ),
            if (isSelected) ...[
              8.wBox,
              Text(
                label,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

extension on num {
  Widget get wBox => SizedBox(width: toDouble());
  Widget get hBox => SizedBox(height: toDouble());
}

class _AiNavItem extends StatelessWidget {
  const _AiNavItem({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,

        child: Image.asset(AppAssets.aiIcon, width: 40.sp, height: 40.sp),
      ),
    );
  }
}
