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

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int _selectedCategory = 0;
  int _selectedWhoPaid = 0; // 0=I paid, 1=They paid, 2=Split equally
  DateTime _selectedDate = DateTime.now();

  final List<Map<String, dynamic>> _categories = [
    {'asset': AppAssets.food, 'label': AppStrings.food},
    {'asset': AppAssets.transport, 'label': AppStrings.transport},
    {'asset': AppAssets.fun, 'label': AppStrings.fun},
    {'asset': AppAssets.shooping, 'label': AppStrings.shopping},
    {'asset': AppAssets.health, 'label': AppStrings.health},
    {'asset': AppAssets.bills, 'label': AppStrings.bills},
    {'asset': AppAssets.travel, 'label': AppStrings.travel},
    {'asset': AppAssets.other, 'label': AppStrings.other},
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
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

    if (pickedDate != null) {
      if (!context.mounted) return;
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDate),
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

      if (pickedTime != null) {
        setState(() {
          _selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray6,
      body: Column(
        children: [
          CommonAppBarRemindry(
            title: AppStrings.addExpense,
            subtitle: AppStrings.joinRemindry,
          ),
          Expanded(
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionLabel(label: AppStrings.amountLabel),
                    8.hBox,
                    _InputField(
                      controller: _amountController,
                      hint: AppStrings.amountHint,
                      keyboardType: TextInputType.number,
                    ),
                    17.hBox,
                    _SectionLabel(label: AppStrings.description),
                    8.hBox,
                    _InputField(
                      controller: _descriptionController,
                      hint: AppStrings.descriptionHint,
                    ),
                    17.hBox,
                    _SectionLabel(label: AppStrings.dateTime),
                    8.hBox,
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 14.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.lightGray,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat(
                                'dd/MM/yyyy • hh:mm a',
                              ).format(_selectedDate),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.blackLight,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SvgPicture.asset(
                              AppAssets.calender,
                              width: 20.sp,
                              height: 20.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                    18.hBox,
                    _SectionLabel(label: AppStrings.category),
                    12.hBox,
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 10.h,
                        crossAxisSpacing: 10.w,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final cat = _categories[index];
                        final isSelected = _selectedCategory == index;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedCategory = index),
                          child: _CategoryItem(
                            asset: cat['asset'],
                            label: cat['label'],
                            isSelected: isSelected,
                          ),
                        );
                      },
                    ),
                    22.hBox,
                    _SectionLabel(label: AppStrings.whoPaid),
                    12.hBox,
                    _WhoPaidItem(
                      title: AppStrings.iPaid,
                      subtitle: AppStrings.someoneOwesMe,
                      isSelected: _selectedWhoPaid == 0,
                      icon: Icons.south_west,
                      iconColor: AppColors.primary,
                      onTap: () => setState(() => _selectedWhoPaid = 0),
                    ),
                    8.hBox,
                    _WhoPaidItem(
                      title: AppStrings.theyPaid,
                      subtitle: AppStrings.iOweThem,
                      isSelected: _selectedWhoPaid == 1,
                      icon: Icons.north_east,
                      iconColor: Colors.black,
                      onTap: () => setState(() => _selectedWhoPaid = 1),
                    ),
                    8.hBox,
                    _WhoPaidItem(
                      title: AppStrings.splitEqually,
                      subtitle: AppStrings.everyonePaysShare,
                      isSelected: _selectedWhoPaid == 2,
                      icon: Icons.drag_handle,
                      iconColor: Colors.black,
                      onTap: () => setState(() => _selectedWhoPaid = 2),
                    ),
                    24.hBox,
                    _SectionLabel(label: AppStrings.splitWith),
                    12.hBox,
                    Row(
                      children: [
                        _Avatar(label: "JD", color: AppColors.primary),
                        8.wBox,
                        _Avatar(label: "RK", color: AppColors.primary),
                        8.wBox,
                        _Avatar(label: "CD", color: AppColors.primary),
                        16.wBox,
                        Container(
                          width: 44.sp,
                          height: 44.sp,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.lightGray1,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 20.sp,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    40.hBox,
                    Center(
                      child: AppButton(
                        onTap: () => context.pop(),
                        title: AppStrings.saveExpense,
                      ),
                    ),
                    24.hBox,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.badgeGrayText,
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;

  const _InputField({
    required this.controller,
    required this.hint,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.lightGray, width: 1),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
          fontSize: 14.sp,
          color: AppColors.blackLight,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: AppColors.iconGray,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
        ),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String asset;
  final String label;
  final bool isSelected;

  const _CategoryItem({
    required this.asset,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryLight3 : AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.lightGray1,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 41.h,
            width: 41.h,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.lightGray10,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: SvgPicture.asset(
                asset,
                width: 20.sp,
                height: 20.sp,
                colorFilter: ColorFilter.mode(
                  isSelected ? Colors.white : AppColors.badgeGrayText,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          7.hBox,
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              color: isSelected ? AppColors.primary : AppColors.badgeGrayText,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _WhoPaidItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _WhoPaidItem({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLight3 : AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.lightGray,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20.sp,
              height: 20.sp,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.lightGray,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10.sp,
                        height: 10.sp,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
            12.wBox,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.badgeGrayText,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.lightGray14,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String label;
  final Color color;
  const _Avatar({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.sp,
      height: 44.sp,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
