import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/core/constant/app_strings.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:untitled1/core/utils/widgets/app_button.dart';
import 'package:untitled1/core/utils/widgets/app_logo.dart';
import 'package:untitled1/features/auth/presentation/providers/create_account_provider.dart';

import '../../../../core/constant/app_assets.dart';

class CreateAccountPage extends ConsumerWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(createAccountProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// Background bg1
          // Transform.rotate(
          //   angle: 3.14159265359,
          //   child: Lottie.asset(AppAssets.splashJson, height: double.infinity, width: double.infinity, fit: BoxFit.cover),
          // ),
          Padding(
            padding: 20.px,
            child: SizedBox(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        const AppLogo(),
                        12.hBox,
                        Text(
                          AppStrings.createAccount.trim(),
                          style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w700),
                        ),
                        8.hBox,
                        Text(
                          AppStrings.joinRemindry,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                        ),
                        31.hBox,

                        /// Full Name Field
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppStrings.firstName,
                            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppColors.secondary),
                          ),
                        ),
                        5.hBox,
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: AppColors.lightGray1, width: 1),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(AppAssets.person, width: 20.sp, height: 20.sp, color: AppColors.iconGray),
                              Flexible(
                                child: TextField(
                                  controller: provider.nameController,
                                  cursorColor: AppColors.black,
                                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    isDense: false,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                                    hintText: "First Name", // Example from mockup
                                    hintStyle: TextStyle(color: AppColors.secondary, fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        12.hBox,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppStrings.lastName,
                            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppColors.secondary),
                          ),
                        ),
                        5.hBox,
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: AppColors.lightGray1, width: 1),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(AppAssets.person, width: 20.sp, height: 20.sp, color: AppColors.iconGray),
                              Flexible(
                                child: TextField(
                                  controller: provider.lastNameController,
                                  cursorColor: AppColors.black,
                                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    isDense: false,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                                    hintText: "Last Name", // Example from mockup
                                    hintStyle: TextStyle(color: AppColors.secondary, fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        12.hBox,

                        /// Gender Field
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppStrings.gender,
                            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppColors.secondary),
                          ),
                        ),
                        5.hBox,
                        Row(
                          children: [
                            Expanded(child: _buildGenderCard(ref, provider, "Male", provider.selectedGender == "Male")),
                            12.wBox,
                            Expanded(child: _buildGenderCard(ref, provider, "Female", provider.selectedGender == "Female")),
                          ],
                        ),
                        12.hBox,

                        /// Phone Number Field
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppStrings.phoneNumber,
                            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppColors.secondary),
                          ),
                        ),
                        5.hBox,
                        Container(
                          padding: EdgeInsets.only(left: 16.w, top: 3.h, bottom: 3.h, right: 8.w),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: AppColors.lightGray1, width: 1),
                          ),
                          child: Row(
                            children: [
                              ///Country Code
                              GestureDetector(
                                onTap: () {
                                  showCountryPicker(
                                    context: context,
                                    showPhoneCode: true,
                                    onSelect: (Country country) {
                                      provider.setCountry(country);
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(provider.selectedCountry.flagEmoji, style: TextStyle(fontSize: 18.sp)),
                                    4.wBox,
                                    Text(
                                      "+${provider.selectedCountry.phoneCode}",
                                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                                    ),
                                    const Icon(Icons.keyboard_arrow_down, size: 16),
                                  ],
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 1,
                                margin: EdgeInsets.symmetric(horizontal: 12.w),
                                color: AppColors.extraLightGray,
                              ),

                              ///TextFiled
                              Flexible(
                                child: TextField(
                                  inputFormatters: [
                                    // Allow only digits
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  controller: provider.phoneController,
                                  keyboardType: TextInputType.phone,
                                  cursorColor: AppColors.black,
                                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Mobile Number",
                                    hintStyle: TextStyle(color: AppColors.secondary, fontSize: 14),
                                  ),
                                ),
                              ),
                              provider.showClearButton
                                  ? IconButton(
                                      onPressed: provider.clearPhone,
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      icon: Container(
                                        width: 24.sp,
                                        height: 24.sp,
                                        decoration: const BoxDecoration(color: AppColors.extraLightGray, shape: BoxShape.circle),
                                        child: Icon(Icons.close, size: 13.sp, color: AppColors.iconGray),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    75.hBox,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppButton(
                          onTap: () {
                            if (provider.nameController.text.trim().isEmpty ||
                                provider.lastNameController.text.trim().isEmpty ||
                                provider.phoneController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(const SnackBar(content: Text('All field is required'), backgroundColor: AppColors.primary));
                            } else {
                              provider.createAccount(
                                lastName: provider.lastNameController.text.trim(),
                                firstName: provider.nameController.text.trim(),
                                countryCode: "+${provider.selectedCountry.phoneCode}",
                                phoneNumber: provider.phoneController.text.trim(),
                                gender: provider.selectedGender,
                                context: context,
                              );
                            }
                          },
                          title: AppStrings.continueTxt,
                        ),
                        40.hBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.alreadyHaveAccount,
                              style: TextStyle(fontSize: 12.sp, color: AppColors.secondary),
                            ),
                            GestureDetector(
                              onTap: () => context.pop(),
                              child: Text(
                                AppStrings.logIn,
                                style: TextStyle(fontSize: 12.sp, color: AppColors.primary, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        20.hBox,
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderCard(WidgetRef ref, CreateAccountProvider provider, String gender, bool isSelected) {
    return GestureDetector(
      onTap: () => provider.setGender(gender),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 11.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.lightGray1, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              gender,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: isSelected ? AppColors.primary : AppColors.black3),
            ),
            if (isSelected) Icon(Icons.check_circle, color: AppColors.primaryDark, size: 20.sp),
          ],
        ),
      ),
    );
  }
}
