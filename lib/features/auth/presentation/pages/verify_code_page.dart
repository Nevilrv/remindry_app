import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_strings.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:untitled1/core/utils/widgets/app_button.dart';
import 'package:untitled1/features/auth/presentation/providers/otp_provider.dart';
import 'package:untitled1/routes/app_routes.dart';

class VerifyCodePage extends StatelessWidget {
  final bool isFromProfile;
  const VerifyCodePage({super.key, this.isFromProfile = false});

  @override
  Widget build(BuildContext context) {
    return _VerifyCodeView(isFromProfile: isFromProfile);
  }
}

class _VerifyCodeView extends ConsumerWidget {
  final bool isFromProfile;
  const _VerifyCodeView({this.isFromProfile = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(otpProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Back button
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 12.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => context.pop(),
                  child: Container(
                    width: 40.sp,
                    height: 40.sp,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: AppColors.lightGray1, width: 1),
                    ),
                    child: const Icon(
                      Icons.chevron_left,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
            ),

            // OTP illustration
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: SvgPicture.asset(
                AppAssets.verifyOTP,
                height: 180.h,
                fit: BoxFit.contain,
              ),
            ),

            // Title
            Text(
              AppStrings.verifyYourCode,
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            12.hBox,

            // Subtitle
            Text(
              AppStrings.sentOtpCode,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.secondary,
                fontWeight: FontWeight.w400,
              ),
            ),
            32.hBox,

            // OTP boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  width: 60.sp,
                  height: 60.sp,
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: provider.controllers[index].text.isNotEmpty
                          ? AppColors.primary
                          : AppColors.lightGray,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: TextField(
                      controller: provider.controllers[index],
                      focusNode: provider.focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      cursorColor: AppColors.primary,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          provider.focusNodes[index + 1].requestFocus();
                        } else if (value.isEmpty && index > 0) {
                          provider.focusNodes[index - 1].requestFocus();
                        }
                        provider.triggerNotify();
                      },
                    ),
                  ),
                );
              }),
            ),
            20.hBox,

            // OTP expiry timer
            Text(
              "${AppStrings.otpExpire} ${provider.otpExpireMinutes}:${provider.otpExpireSecondsLeft.toString().padLeft(2, '0')}",
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.blackLight,
                fontWeight: FontWeight.w500,
              ),
            ),

            const Spacer(),

            // Verify Code button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: AppButton(
                onTap: () {
                  if (isFromProfile) {
                    context.pop();
                  } else {
                    context.pushNamed(AppRoutes.setPermissions);
                  }
                },
                title: AppStrings.verifyCode,
              ),
            ),
            20.hBox,

            // Resend code
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.resendCode,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.secondary,
                  ),
                ),
                GestureDetector(
                  onTap: provider.canResend ? provider.resendCode : null,
                  child: Text(
                    provider.canResend
                        ? "Resend"
                        : "${provider.secondsRemaining}s",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            20.hBox,
          ],
        ),
      ),
    );
  }
}
