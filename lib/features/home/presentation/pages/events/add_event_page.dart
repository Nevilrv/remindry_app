import 'package:go_router/go_router.dart';
import '../../../../../routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_strings.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:untitled1/core/utils/widgets/app_button.dart';
import 'package:untitled1/core/utils/widgets/common_app_bar_remindry.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  DateTime? _selectedDate;
  String _selectedCategory = AppStrings.birthday;
  final List<String> _categories = [
    AppStrings.birthday,
    AppStrings.wedding,
    AppStrings.conference,
    AppStrings.party,
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
              primary: AppColors.primary,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.blackLight,
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: AppColors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "02/10/2026";
    return '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray6,
      body: Column(
        children: [
          CommonAppBarRemindry(
            title: AppStrings.addEvent,
            subtitle: AppStrings.joinRemindry,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionLabel(label: AppStrings.eventTitleRequired),
                  8.hBox,
                  _InputField(
                    controller: _titleController,
                    hint: AppStrings.eventTitleHint,
                  ),
                  18.hBox,

                  _SectionLabel(label: AppStrings.dateTime),
                  8.hBox,
                  _SelectorField(
                    value: _formatDate(_selectedDate),
                    icon: AppAssets.calender,
                    onTap: _pickDate,
                  ),
                  18.hBox,

                  _SectionLabel(label: AppStrings.eventTypeCategory),
                  8.hBox,
                  _DropdownField(
                    value: _selectedCategory,
                    items: _categories,
                    onChanged: (val) =>
                        setState(() => _selectedCategory = val!),
                  ),
                  18.hBox,

                  _SectionLabel(label: AppStrings.locationOptional),
                  8.hBox,
                  _InputField(
                    controller: _locationController,
                    hint: AppStrings.notesHint,
                  ),
                  18.hBox,

                  _SectionLabel(label: AppStrings.notes),
                  8.hBox,
                  _InputField(
                    controller: _notesController,
                    hint: AppStrings.notesHint,
                  ),
                  18.hBox,

                  // AI TIP
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: SvgPicture.asset(
                            AppAssets.aiTip,
                            height: 20.sp,
                            width: 20.sp,
                          ),
                        ),
                        8.wBox,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: "AI TIP\n",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: AppStrings.setGiftReminder,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              12.hBox,
                              Container(
                                height: 0.5,
                                color: AppColors.primaryLight2,
                              ),
                              12.hBox,
                              Row(
                                children: [
                                  _TipButton(
                                    icon: Icons.check_circle_outline,
                                    label: AppStrings.accept,
                                    onTap: () {},
                                  ),
                                  18.wBox,
                                  _TipButton(
                                    icon: Icons.remove_circle_outline,
                                    label: AppStrings.reject,
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  26.hBox,

                  Center(
                    child: AppButton(
                      onTap: () => context.pop(),
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

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});
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

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const _InputField({required this.controller, required this.hint});
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

class _SelectorField extends StatelessWidget {
  final String value;
  final String icon;
  final VoidCallback onTap;
  const _SelectorField({
    required this.value,
    required this.icon,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.lightGray, width: 1),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.blackLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SvgPicture.asset(
              icon,
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
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  const _DropdownField({
    required this.value,
    required this.items,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.lightGray, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.blackLight,
            size: 24.sp,
          ),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _TipButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _TipButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 20.sp, color: AppColors.blackLight),
          6.wBox,
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.blackLight,
            ),
          ),
        ],
      ),
    );
  }
}
