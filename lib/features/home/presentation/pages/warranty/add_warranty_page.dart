import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/core/constant/api_const.dart';
import 'package:untitled1/services/api_services.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_strings.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:untitled1/core/utils/widgets/app_gradient_button.dart';
import 'package:untitled1/core/utils/widgets/common_app_bar_remindry.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/warranty_provider.dart';

class AddWarrantyPage extends ConsumerStatefulWidget {
  const AddWarrantyPage({super.key});

  @override
  ConsumerState<AddWarrantyPage> createState() => _AddWarrantyPageState();
}

class _AddWarrantyPageState extends ConsumerState<AddWarrantyPage> {
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
  }


  Future<void> _pickDate(bool isPurchase) async {
    FocusManager.instance.primaryFocus?.unfocus();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: (isPurchase ? _purchaseDate : _warrantyDuration) ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
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

    if (pickedDate != null) {
      if (!mounted) return;
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          (isPurchase ? _purchaseDate : _warrantyDuration) ?? DateTime.now(),
        ),
        builder: (context, child) => Theme(
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
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<void> _saveWarranty() async {
    if (_productNameController.text.trim().isEmpty ||
        _brandController.text.trim().isEmpty ||
        _storeController.text.trim().isEmpty ||
        _purchaseDate == null ||
        _warrantyDuration == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required")),
      );
      return;
    }

    if (!_warrantyDuration!.isAfter(_purchaseDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Warranty expiry date must be after purchase date")),
      );
      return;
    }

    final payload = {
      "product_name": _productNameController.text.trim(),
      "brand": _brandController.text.trim(),
      "category": _selectedCategory,
      "purchase_date_time": _purchaseDate!.toUtc().toIso8601String(),
      "garranty_duration": _warrantyDuration!.toUtc().toIso8601String(),
      "warranty_duration": _warrantyDuration!.toUtc().toIso8601String(),
      "invoice_number": _invoiceController.text.trim(),
      "store_location": _storeController.text.trim(),
    };

    try {
      final response = await ApiService().post(ApiConsts.addWarranty, data: payload);

      if (response.isSuccess) {
        // Refresh warranty list
        ref.read(warrantyProvider).fetchWarranties();

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Warranty saved successfully")));
          context.pop();
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message ?? "Failed to save warranty")));
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
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
                    value: _purchaseDate == null ? "Pick purchase date & time" : DateFormat('MM/dd/yyyy, hh:mm a').format(_purchaseDate!),
                    isHint: _purchaseDate == null,
                    icon: AppAssets.calender,
                    onTap: () => _pickDate(true),
                  ),
                  17.hBox,

                  _SectionLabel(label: AppStrings.warrantyDuration),
                  8.hBox,
                  _SelectorField(
                    value: _warrantyDuration == null ? "Pick warranty expiry date & time" : DateFormat('MM/dd/yyyy, hh:mm a').format(_warrantyDuration!),
                    isHint: _warrantyDuration == null,
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
                      onTap: _saveWarranty,
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
  final bool isHint;
  const _SelectorField(
      {required this.value, required this.icon, required this.onTap, this.isHint = false});
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
                        color: isHint ? AppColors.iconGray : AppColors.blackLight,
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
