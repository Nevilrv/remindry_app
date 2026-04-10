import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/core/constant/api_const.dart';
import 'package:untitled1/services/api_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_strings.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:untitled1/features/home/presentation/providers/reminder_provider.dart';
import 'package:untitled1/core/utils/widgets/app_button.dart';
import 'package:untitled1/core/utils/widgets/common_app_bar_remindry.dart';
import 'package:intl/intl.dart';

class AddReminderPage extends ConsumerStatefulWidget {
  const AddReminderPage({super.key});

  @override
  ConsumerState<AddReminderPage> createState() => _AddReminderPageState();
}

class _AddReminderPageState extends ConsumerState<AddReminderPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  DateTime? _selectedDate;
  int _selectedCategory = 0; // 0=Health, 1=Events, 2=Warranty, 3=Money
  String _selectedRepeat = 'Daily';

  final List<Map<String, dynamic>> _categories = [
    {'asset': AppAssets.health, 'label': 'Health', 'bgColor': AppColors.primary, 'iconColor': Colors.white},
    {'asset': AppAssets.event, 'label': 'Events', 'bgColor': AppColors.extraLightGray, 'iconColor': Colors.black},
    {'asset': AppAssets.warranty, 'label': 'Warranty', 'bgColor': AppColors.extraLightGray, 'iconColor': Colors.black},
    {'asset': AppAssets.money, 'label': 'Money', 'bgColor': AppColors.extraLightGray, 'iconColor': Colors.black},
  ];

  final List<String> _repeatOptions = ['Daily', 'Weekly', 'Monthly', 'Yearly', 'Never'];

  Future<void> _pickDate() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
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

    if (pickedDate != null) {
      if (!mounted) return;
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDate ?? DateTime.now()),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.primary,
                onPrimary: AppColors.white,
                secondary: AppColors.primary,
                onSecondary: AppColors.white,
                surface: AppColors.white,
                onSurface: AppColors.blackLight,
                tertiary: AppColors.primary,
              ),
              timePickerTheme: TimePickerThemeData(
                backgroundColor: AppColors.white,
                dayPeriodColor: WidgetStateColor.resolveWith((states) => states.contains(WidgetState.selected) ? AppColors.primary.withOpacity(0.2) : Colors.transparent),
                dayPeriodTextColor: WidgetStateColor.resolveWith((states) => states.contains(WidgetState.selected) ? AppColors.primary : AppColors.blackLight),
                dayPeriodBorderSide: const BorderSide(color: AppColors.lightGray),
                hourMinuteColor: WidgetStateColor.resolveWith((states) => states.contains(WidgetState.selected) ? AppColors.primary.withOpacity(0.2) : AppColors.lightGray6),
                hourMinuteTextColor: WidgetStateColor.resolveWith((states) => states.contains(WidgetState.selected) ? AppColors.primary : AppColors.blackLight),
              ),
              dialogTheme: const DialogThemeData(backgroundColor: AppColors.white),
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

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) {
      return 'Pick date';
    }
    return DateFormat('dd/MM/yyyy • hh:mm a').format(dateTime);
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
          CommonAppBarRemindry(title: AppStrings.addReminder, subtitle: AppStrings.joinRemindry),

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
                  _InputField(controller: _titleController, hint: AppStrings.reminderTitleHint, maxLines: 1),
                  20.hBox,

                  // Notes Field
                  _SectionLabel(label: AppStrings.notesDescription),
                  8.hBox,
                  _InputField(controller: _notesController, hint: AppStrings.notesHint, maxLines: 3),
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
                        border: Border.all(color: AppColors.lightGray, width: 1),
                        boxShadow: [BoxShadow(color: AppColors.lightGray7, offset: Offset(0, 1), blurRadius: 2)],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _formatDateTime(_selectedDate),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: _selectedDate == null ? AppColors.iconGray : AppColors.blackLight,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                            AppAssets.calender,
                            width: 20.sp,
                            height: 20.sp,
                            colorFilter: const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
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
                      boxShadow: [BoxShadow(color: AppColors.lightGray7, offset: Offset(0, 1), blurRadius: 2)],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedRepeat,
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.blackLight, size: 30.sp),
                        style: TextStyle(fontSize: 14.sp, color: AppColors.black, fontWeight: FontWeight.w500),
                        items: _repeatOptions.map((option) {
                          return DropdownMenuItem<String>(value: option, child: Text(option));
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
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(16.r)),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppAssets.aiTip, height: 15.sp, width: 15.sp),
                        5.wBox,
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: AppStrings.aiTip,
                              style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.w600),
                              children: [
                                TextSpan(
                                  text: AppStrings.aiTipDescription,
                                  style: TextStyle(fontSize: 12.sp, color: AppColors.black, fontWeight: FontWeight.w400),
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
                      onTap: () async {
                        if (_titleController.text.trim().isEmpty || _notesController.text.trim().isEmpty || _selectedDate == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('All fields are required'),
                              backgroundColor: AppColors.red,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                            ),
                          );
                          return;
                        }

                        final scheduledDateTime = _selectedDate!;

                        final payload = {
                          "title": _titleController.text.trim(),
                          "description": _notesController.text.trim(),
                          "date_time": scheduledDateTime.toUtc().toIso8601String(),
                          "category": _categories[_selectedCategory]['label'],
                          "repeat": _selectedRepeat.toLowerCase(),
                        };

                        try {
                          final response = await ApiService().post(ApiConsts.addQuickReminder, data: payload);
                          if (response.isSuccess) {
                            if (context.mounted) {
                              ref.read(reminderProvider.notifier).fetchReminders();
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reminder saved!')));
                              context.pop();
                            }
                          } else {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message ?? 'Failed to save reminder')));
                            }
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                          }
                        }
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
      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500, color: AppColors.secondary),
    );
  }
}

// ─── Input Field ─────────────────────────────────────────────────────────────

class _InputField extends StatelessWidget {
  const _InputField({required this.controller, required this.hint, this.maxLines = 1});

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
        boxShadow: [BoxShadow(color: AppColors.lightGray7, offset: Offset(0, 1), blurRadius: 2)],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        cursorColor: AppColors.black,
        style: TextStyle(fontSize: 14.sp, color: AppColors.blackLight, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 14.sp, color: AppColors.iconGray, fontWeight: FontWeight.w500),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        ),
      ),
    );
  }
}

// ─── Category Item ───────────────────────────────────────────────────────────

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({required this.asset, required this.label, required this.bgColor, required this.iconColor, required this.isSelected});

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
        color: isSelected ? AppColors.primaryLight3 : Colors.white,
        borderRadius: BorderRadius.circular(16.r),

        boxShadow: [BoxShadow(color: AppColors.lightGray7, offset: Offset(0, 1), blurRadius: 2)],
        border: Border.all(color: isSelected ? AppColors.primary : AppColors.lightGray7, width: isSelected ? 1.5 : 1),
      ),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 50.sp,
            height: 50.sp,
            decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(14.r)),
            child: Center(
              child: SvgPicture.asset(asset, width: 22.sp, height: 22.sp, colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn)),
            ),
          ),
          8.hBox,
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              color: isSelected ? AppColors.primary : AppColors.blackLight,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
