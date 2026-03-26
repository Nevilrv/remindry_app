import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/core/constant/app_theme.dart';

import 'package:flutter/services.dart';

class CommonAppBarRemindry extends StatelessWidget
    implements PreferredSizeWidget {
  const CommonAppBarRemindry({
    super.key,
    required this.title,
    this.subtitle,
    this.showBackButton = true,
    this.onBack,
    this.actions,
  });

  final String title;
  final String? subtitle;
  final bool showBackButton;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  @override
  Size get preferredSize => Size.fromHeight(72.h);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: showBackButton ? 24.w : 0,
          right: 16.w,
          bottom: 12.h,
        ),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showBackButton)
              GestureDetector(
                onTap: onBack ?? () => context.pop(),
                child: Container(
                  width: 52.h,
                  height: 52.h,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.lightGray1),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18.sp,
                      color: AppColors.blackLight,
                    ),
                  ),
                ),
              )
            else
              const SizedBox(),
            if (showBackButton) SizedBox(width: 18.w) else const SizedBox(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: TextStyle(fontSize: 11.sp, color: AppColors.black),
                    ),
                ],
              ),
            ),
            if (actions != null) ...actions!,
          ],
        ),
      ),
    );
  }
}
