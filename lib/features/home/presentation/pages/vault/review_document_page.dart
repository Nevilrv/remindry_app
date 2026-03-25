import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_strings.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:untitled1/core/utils/widgets/common_app_bar_remindry.dart';
import 'package:untitled1/core/utils/widgets/app_button.dart';

class ReviewDocumentPage extends StatelessWidget {
  const ReviewDocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: const CommonAppBarRemindry(
        title: AppStrings.review,
        subtitle: AppStrings
            .chooseScanningMethod, // As per screenshot subtitle remains same
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ReviewField(
              label: AppStrings.documentType,
              value: AppStrings.medicalBill,
            ),
            20.hBox,
            _ReviewField(
              label: AppStrings.amount,
              value: AppStrings.amountValue,
            ),
            20.hBox,
            _ReviewField(
              label: AppStrings.date,
              value: AppStrings.dateValue,
              suffix: Icon(
                Icons.calendar_month_outlined,
                size: 20.sp,
                color: AppColors.black,
              ),
            ),
            32.hBox,
            // AI Insights Box
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: const Color(0xffFCE7F3),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: const BoxDecoration(
                          color: Color(0xffF472B6),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          AppAssets.aiTip,
                          height: 18.sp,
                          width: 18.sp,
                          colorFilter: const ColorFilter.mode(
                            AppColors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      10.wBox,
                      Text(
                        AppStrings.aiInsights,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                  16.hBox,
                  Text(
                    AppStrings.aiInsightsDesc,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.black.withOpacity(0.8),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            // Buttons
            Center(
              child: AppButton(
                onTap: () => context.pop(),
                title: AppStrings.saveRemind,
                icon: Icon(Icons.done_all, color: AppColors.white, size: 20.sp),
              ),
            ),
            20.hBox,
            Center(
              child: TextButton(
                onPressed: () => context.pop(),

                child: Text(
                  AppStrings.skipForNow,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewField extends StatelessWidget {
  final String label;
  final String value;
  final Widget? suffix;

  const _ReviewField({required this.label, required this.value, this.suffix});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14.sp, color: AppColors.secondary),
        ),
        8.hBox,
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
              ),
              if (suffix != null) suffix!,
            ],
          ),
        ),
      ],
    );
  }
}
