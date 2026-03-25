import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_strings.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:untitled1/core/utils/widgets/app_button.dart';
import 'package:untitled1/core/utils/widgets/common_app_bar_remindry.dart';

class AddReminderPage extends StatefulWidget {
  const AddReminderPage({super.key});

  @override
  State<AddReminderPage> createState() => _AddReminderPageState();
}

class _AddReminderPageState extends State<AddReminderPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  DateTime? _selectedDate;
  int _selectedCategory = 0; // 0=Health, 1=Events, 2=Warranty, 3=Money
  String _selectedRepeat = 'Daily';

  final List<Map<String, dynamic>> _categories = [
    {
      'asset': AppAssets.health,
      'label': 'Health',
      'bgColor': AppColors.primary,
      'iconColor': Colors.white,
    },
    {
      'asset': AppAssets.event,
      'label': 'Events',
      'bgColor': AppColors.extraLightGray,
      'iconColor': Colors.black,
    },
    {
      'asset': AppAssets.warranty,
      'label': 'Warranty',
      'bgColor': AppColors.extraLightGray,
      'iconColor': Colors.black,
    },
    {
      'asset': AppAssets.money,
      'label': 'Money',
      'bgColor': AppColors.extraLightGray,
      'iconColor': Colors.black,
    },
  ];

  final List<String> _repeatOptions = [
    'Daily',
    'Weekly',
    'Monthly',
    'Yearly',
    'Never',
  ];

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xffFF4059),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xff2C2C2C),
            ),
            dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      final now = DateTime.now();
      return '${now.month.toString().padLeft(2, '0')}/${now.day.toString().padLeft(2, '0')}/${now.year}';
    }
    return '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray6,
      body: Column(
        children: [
          // ─── AppBar ─────────────────────────────────────────────────────
          CommonAppBarRemindry(
            title: AppStrings.addReminder,
            subtitle: AppStrings.joinRemindry,
          ),

          // ─── Body ────────────────────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Field
                  _SectionLabel(label: AppStrings.enterReminderTitle),
                  8.hBox,
                  _InputField(
                    controller: _titleController,
                    hint: AppStrings.reminderTitleHint,
                    maxLines: 1,
                  ),
                  20.hBox,

                  // Notes Field
                  _SectionLabel(label: AppStrings.notesDescription),
                  8.hBox,
                  _InputField(
                    controller: _notesController,
                    hint: AppStrings.notesHint,
                    maxLines: 3,
                  ),
                  20.hBox,

                  // Date & Time
                  _SectionLabel(label: AppStrings.dateTime),
                  8.hBox,
                  GestureDetector(
                    onTap: _pickDate,
                    child: Container(
                      height: 52.h,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.lightGray,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.lightGray7,
                            offset: Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _formatDate(_selectedDate),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.blackLight,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                            AppAssets.calender,
                            width: 20.sp,
                            height: 20.sp,
                            colorFilter: const ColorFilter.mode(
                              AppColors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  20.hBox,

                  // Category
                  _SectionLabel(label: AppStrings.category),
                  12.hBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(_categories.length, (index) {
                      final cat = _categories[index];
                      final isSelected = _selectedCategory == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = index;
                            // Update colors on selection
                            for (int i = 0; i < _categories.length; i++) {
                              if (i == index) {
                                _categories[i]['bgColor'] = AppColors.primary;
                                _categories[i]['iconColor'] = Colors.white;
                              } else {
                                _categories[i]['bgColor'] = Colors.white;
                                _categories[i]['iconColor'] = Colors.black;
                              }
                            }
                          });
                        },
                        child: _CategoryItem(
                          asset: cat['asset'] as String,
                          label: cat['label'] as String,
                          bgColor: cat['bgColor'] as Color,
                          iconColor: cat['iconColor'] as Color,
                          isSelected: isSelected,
                        ),
                      );
                    }),
                  ),
                  20.hBox,

                  // Repeat
                  _SectionLabel(label: AppStrings.repeat),
                  8.hBox,
                  Container(
                    height: 52.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.lightGray, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.lightGray7,
                          offset: Offset(0, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedRepeat,
                        isExpanded: true,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.blackLight,
                          size: 30.sp,
                        ),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        items: _repeatOptions.map((option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _selectedRepeat = value);
                          }
                        },
                      ),
                    ),
                  ),
                  20.hBox,

                  // AI Tip
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.aiTip,
                          height: 15.sp,
                          width: 15.sp,
                        ),
                        5.wBox,
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: AppStrings.aiTip,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: AppStrings.aiTipDescription,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  32.hBox,

                  // Save Button
                  Center(
                    child: AppButton(
                      onTap: () {
                        // TODO: Save reminder logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Reminder saved!'),
                            backgroundColor: const Color(0xffFF4059),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                        );
                      },
                      title: AppStrings.saveReminder,
                    ),
                  ),
                  24.hBox,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Section Label ──────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.secondary,
      ),
    );
  }
}

// ─── Input Field ─────────────────────────────────────────────────────────────

class _InputField extends StatelessWidget {
  const _InputField({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String hint;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.lightGray, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGray7,
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        cursorColor: AppColors.black,
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
            fontWeight: FontWeight.w500,
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

// ─── Category Item ───────────────────────────────────────────────────────────

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    required this.asset,
    required this.label,
    required this.bgColor,
    required this.iconColor,
    required this.isSelected,
  });

  final String asset;
  final String label;
  final Color bgColor;
  final Color iconColor;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),

        boxShadow: [
          BoxShadow(
            color: AppColors.lightGray7,
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.lightGray7,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 50.sp,
            height: 50.sp,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Center(
              child: SvgPicture.asset(
                asset,
                width: 22.sp,
                height: 22.sp,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
            ),
          ),
          8.hBox,
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              color: isSelected
                  ? AppColors.primary
                  : AppColors.blackLight,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
