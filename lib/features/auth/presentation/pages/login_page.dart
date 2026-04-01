import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:country_picker/country_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import 'package:untitled1/features/auth/presentation/providers/login_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/core/constant/app_strings.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:untitled1/core/utils/widgets/app_button.dart';
import 'package:untitled1/core/utils/widgets/app_logo.dart';
import 'package:untitled1/core/utils/widgets/gradient_bg.dart';
import 'package:untitled1/routes/app_routes.dart';

import '../../../../core/constant/app_assets.dart';
import '../../../../core/constant/app_theme.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(loginProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Transform.rotate(
            angle: 3.14159265359,
            child: Lottie.asset(
              AppAssets.splashJson,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: 30.px,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppLogo(),
                      12.hBox,
                      Text(
                        AppStrings.welcomeBack,
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      12.hBox,
                      Text(
                        AppStrings.enterPhoneNumber,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      20.hBox,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppStrings.phoneNumber,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                      5.hBox,
                      Container(
                        padding: EdgeInsets.only(
                          left: 20.w,
                          top: 5.h,
                          bottom: 5.h,
                          right: 4.w,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: AppColors.lightGray),
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
                                  Text(
                                    provider.selectedCountry.flagEmoji,
                                    style: TextStyle(fontSize: 18.sp),
                                  ),
                                  4.wBox,
                                  Text(
                                    "+${provider.selectedCountry.phoneCode}",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 2,
                              margin: 5.px,
                              color: AppColors.extraLightGray,
                            ),
                            20.hBox,

                            ///TextFiled
                            Flexible(
                              child: TextField(
                                controller: provider.phoneController,
                                keyboardType: TextInputType.phone,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Mobile Number",
                                  hintStyle: TextStyle(
                                    color: AppColors.secondary,
                                    fontSize: 14,
                                  ),
                                  // contentPadding: EdgeInsets.zero,
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
                                      // padding: EdgeInsets.all(5.5.sp),
                                      decoration: const BoxDecoration(
                                        color: AppColors.extraLightGray,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        size: 13.sp,
                                        color: AppColors.iconGray,
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      26.hBox,
                      AppButton(
                        onTap: () => context.pushNamed(AppRoutes.verifyCode),
                        title: "Continue",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.donTHaveAccount,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.secondary,
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                context.pushNamed(AppRoutes.createAccount),
                            child: Text(
                              AppStrings.createAccount,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      20.hBox,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
