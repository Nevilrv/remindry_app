import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_strings.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:untitled1/core/utils/widgets/app_gradient_button.dart';
import 'package:untitled1/core/utils/widgets/common_app_bar_remindry.dart';

class AddWarrantyPage extends StatefulWidget {
  const AddWarrantyPage({super.key});

  @override
  State<AddWarrantyPage> createState() => _AddWarrantyPageState();
}

class _AddWarrantyPageState extends State<AddWarrantyPage> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _invoiceController = TextEditingController();
  final TextEditingController _storeController = TextEditingController();

  DateTime? _purchaseDate;
  DateTime? _warrantyDuration;
  String _selectedCategory = "Electronics";
  final List<String> _categories = [
    "Electronics",
    "Appliances",
    "Furniture",
    "Others"
  ];

  @override
  void initState() {
    super.initState();
    _purchaseDate = DateTime.now();
    _warrantyDuration = DateTime.now().add(const Duration(days: 365));
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return "mm/dd/yyyy, 0:00 AM";
    final month = dateTime.month.toString().padLeft(2, '0');
    final day = dateTime.day.toString().padLeft(2, '0');
    final year = dateTime.year;
    
    int hour = dateTime.hour;
    final String amPm = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    if (hour == 0) hour = 12;
    final String minute = dateTime.minute.toString().padLeft(2, '0');
    
    return "$month/$day/$year, $hour:$minute $amPm";
  }

  Future<void> _pickDate(bool isPurchase) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
          (isPurchase ? _purchaseDate : _warrantyDuration) ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (pickedDate != null) {
      if (!mounted) return;
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          (isPurchase ? _purchaseDate : _warrantyDuration) ?? DateTime.now(),
        ),
      );

      if (pickedTime != null) {
        setState(() {
          final newDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          if (isPurchase) {
            _purchaseDate = newDateTime;
          } else {
            _warrantyDuration = newDateTime;
          }
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
            title: "Add Warranty",
            subtitle: AppStrings.joinRemindry,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionLabel(label: AppStrings.productName),
                  8.hBox,
                  _InputField(
                      controller: _productNameController,
                      hint: "e.g. Sony Headphones"),
                  17.hBox,

                  _SectionLabel(label: AppStrings.brand),
                  8.hBox,
                  _InputField(controller: _brandController, hint: "e.g. Sony"),
                  17.hBox,

                  _SectionLabel(label: "Category"),
                  8.hBox,
                  _DropdownField(
                    value: _selectedCategory,
                    items: _categories,
                    onChanged: (val) =>
                        setState(() => _selectedCategory = val!),
                  ),
                  17.hBox,

                  _SectionLabel(label: AppStrings.purchaseDate),
                  8.hBox,
                  _SelectorField(
                    value: _formatDateTime(_purchaseDate),
                    icon: AppAssets.calender,
                    onTap: () => _pickDate(true),
                  ),
                  17.hBox,

                  _SectionLabel(label: AppStrings.warrantyDuration),
                  8.hBox,
                  _SelectorField(
                    value: _formatDateTime(_warrantyDuration),
                    icon: AppAssets.calender,
                    onTap: () => _pickDate(false),
                  ),
                  17.hBox,

                  _SectionLabel(label: AppStrings.invoiceNumberOptional),
                  8.hBox,
                  _InputField(
                      controller: _invoiceController,
                      hint: "Enter invoice number"),
                  17.hBox,

                  _SectionLabel(label: AppStrings.storeLocation),
                  8.hBox,
                  _InputField(
                      controller: _storeController,
                      hint: "Enter store location"),
                  40.hBox,

                  Center(
                    child: AppGradientButton(
                      onTap: () => context.pop(),
                      title: AppStrings.saveWarranty,
                      icon: Icon(Icons.done_all_rounded,
                          color: AppColors.white, size: 18.sp),
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
    return Text(label,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.secondary,
        ));
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
            fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
              fontSize: 14.sp,
              color: AppColors.iconGray,
              fontWeight: FontWeight.w500),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        ),
      ),
    );
  }
}

class _SelectorField extends StatelessWidget {
  final String value;
  final String icon;
  final VoidCallback onTap;
  const _SelectorField(
      {required this.value, required this.icon, required this.onTap});
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
                child: Text(value,
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.blackLight,
                        fontWeight: FontWeight.w500))),
            SvgPicture.asset(icon,
                width: 20.sp,
                height: 20.sp,
                colorFilter:
                    const ColorFilter.mode(AppColors.black, BlendMode.srcIn)),
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
  const _DropdownField(
      {required this.value, required this.items, required this.onChanged});
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
          icon: Icon(Icons.keyboard_arrow_down_rounded,
              color: AppColors.blackLight, size: 24.sp),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
