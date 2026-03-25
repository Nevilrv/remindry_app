import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_strings.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:untitled1/core/utils/widgets/app_button.dart';
import 'package:untitled1/core/utils/widgets/app_gradient_button.dart';
import 'package:untitled1/core/utils/widgets/common_app_bar_remindry.dart';

class AddVisitPage extends StatefulWidget {
  const AddVisitPage({super.key});

  @override
  State<AddVisitPage> createState() => _AddVisitPageState();
}

class _AddVisitPageState extends State<AddVisitPage> {
  final TextEditingController _doctorNameController = TextEditingController();
  final TextEditingController _specialityController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  DateTime? _selectedDate;
  String _selectedType = AppStrings.doctorVisit;
  final List<String> _types = [
    AppStrings.doctorVisit,
    'Checkup',
    'X-Ray',
    'Lab Test',
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) => Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primary,
            onPrimary: AppColors.white,
            surface: AppColors.white,
            onSurface: AppColors.blackLight,
          ),
          dialogTheme: const DialogThemeData(backgroundColor: AppColors.white),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray6,
      body: Column(
        children: [
          CommonAppBarRemindry(
            title: AppStrings.addVisit,
            subtitle: AppStrings.joinRemindry,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionLabel(label: AppStrings.type),
                  8.hBox,
                  _DropdownField(
                    value: _selectedType,
                    items: _types,
                    onChanged: (val) => setState(() => _selectedType = val!),
                  ),
                  17.hBox,

                  _SectionLabel(label: AppStrings.doctorName),
                  8.hBox,
                  _InputField(
                    controller: _doctorNameController,
                    hint: AppStrings.drEmilyCarterHint,
                    prefixIcon: Icon(
                      Icons.person_outline_rounded,
                      color: AppColors.iconGray,
                      size: 20.sp,
                    ),
                  ),
                  17.hBox,

                  _SectionLabel(label: AppStrings.speciality),
                  8.hBox,
                  _InputField(
                    controller: _specialityController,
                    hint: AppStrings.cardiologyHint,
                  ),
                  17.hBox,

                  _SectionLabel(label: AppStrings.dateTime),
                  8.hBox,
                  _SelectorField(
                    value: _selectedDate == null
                        ? "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}, 9:00 AM"
                        : '${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year}, 9:00 AM',
                    icon: AppAssets.calender,
                    onTap: _pickDate,
                  ),
                  17.hBox,

                  _SectionLabel(label: AppStrings.locationOptional),
                  8.hBox,
                  _InputField(
                    controller: _locationController,
                    hint: AppStrings.eventTitleHint,
                  ),
                  17.hBox,

                  _SectionLabel(label: "Reason / Notes"),
                  8.hBox,
                  _InputField(
                    controller: _notesController,
                    hint: AppStrings.cardiologyHint,
                  ),
                  40.hBox,

                  Center(
                    child: AppGradientButton(
                      onTap: () => context.pop(),
                      title: AppStrings.saveVisit,
                      icon: Icon(
                        Icons.done_all_rounded,
                        color: AppColors.white,
                        size: 18.sp,
                      ),
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
  final Widget? prefixIcon;
  const _InputField({
    required this.controller,
    required this.hint,
    this.prefixIcon,
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
        cursorColor: AppColors.black,
        style: TextStyle(
          fontSize: 14.sp,
          color: AppColors.blackLight,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
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
