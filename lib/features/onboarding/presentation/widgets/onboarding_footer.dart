import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/core/constant/app_strings.dart';
import 'package:untitled1/core/extentions/extentions.dart';

class OnboardingFooter extends StatelessWidget {
  const OnboardingFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        Text(AppStrings.privacyPolicy, style: TextStyle(fontSize: 14.sp)),
        6.hBox,
        Text("•", style: TextStyle(fontSize: 20.sp)),
        6.hBox,
        Text(AppStrings.termsOfService, style: TextStyle(fontSize: 14.sp)),
      ],
    );
  }
}