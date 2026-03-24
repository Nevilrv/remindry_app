import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:untitled1/core/utils/widgets/gradient_text.dart';
import 'package:untitled1/features/onboarding/presentation/pages/onboarding_page.dart';

class OnboardingText extends StatelessWidget {
  final OnboardingModel data;

  const OnboardingText({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: GradientText(
            data.title,
            key: ValueKey(data.title),
            style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w700),
            gradient: const LinearGradient(
              colors: [Color(0xff8227FF), Color(0xffD595B7), Color(0xffFF8B99)],
            ),
          ),
        ),

        6.hBox,

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: Text(
            data.subtitle,
            key: ValueKey(data.subtitle),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
