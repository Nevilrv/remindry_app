import 'package:flutter/material.dart';
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

class ReviewDocumentPage extends StatefulWidget {
  const ReviewDocumentPage({super.key});

  @override
  State<ReviewDocumentPage> createState() => _ReviewDocumentPageState();
}

class _ReviewDocumentPageState extends State<ReviewDocumentPage> {
  late final TextEditingController _typeController;
  late final TextEditingController _amountController;
  late final TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _typeController = TextEditingController(text: AppStrings.medicalBill);
    _amountController = TextEditingController(text: AppStrings.amountValue);
    _dateController = TextEditingController(text: AppStrings.dateValue);
  }

  @override
  void dispose() {
    _typeController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2025, 2, 7),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('MMM d, yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray6,
      body: Column(
        children: [
          const CommonAppBarRemindry(
            title: AppStrings.review,
            subtitle: AppStrings.chooseScanningMethod,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ReviewField(
                    label: AppStrings.documentType,
                    controller: _typeController,
                    hint: AppStrings.medicalBill,
                  ),
                  17.hBox,
                  _ReviewField(
                    label: AppStrings.amount,
                    controller: _amountController,
                    hint: AppStrings.amountValue,
                  ),
                  17.hBox,
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: _ReviewField(
                      label: AppStrings.date,
                      controller: _dateController,
                      hint: AppStrings.dateValue,
                      readOnly: true,
                      suffix: Icon(
                        Icons.calendar_month_outlined,
                        size: 20.sp,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  28.hBox,
                  // AI Insights Box
                  Container(
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
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
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColors.pinkGradient,
                                    AppColors.red,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
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
                        10.hBox,
                        Text(
                          AppStrings.aiInsightsDesc,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.black.withOpacity(0.8),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  // Buttons
                  Center(
                    child: AppButton(
                      onTap: () => context.pop(),
                      title: AppStrings.saveRemind,
                      icon: Icon(
                        Icons.done_all,
                        color: AppColors.white,
                        size: 20.sp,
                      ),
                    ),
                  ),

                  Center(
                    child: TextButton(
                      onPressed: () => context.pop(),
                      style: ButtonStyle(
                        padding: WidgetStateProperty.resolveWith((states) {
                          return EdgeInsets.zero;
                        }),
                      ),
                      child: Text(
                        AppStrings.skipForNow,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  10.hBox,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final Widget? suffix;
  final bool readOnly;

  const _ReviewField({
    required this.label,
    required this.controller,
    required this.hint,
    this.suffix,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.secondary,
          ),
        ),
        8.hBox,
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.lightGray, width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  readOnly: readOnly,
                  cursorColor: AppColors.black,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.iconGray,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                  ),
                ),
              ),
              if (suffix != null)
                Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: suffix!,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
