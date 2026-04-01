import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_strings.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:untitled1/core/utils/widgets/app_button.dart';
import 'package:untitled1/features/onboarding/presentation/widgets/onboarding_footer.dart';
import 'package:untitled1/features/onboarding/presentation/widgets/onboarding_image.dart';
import 'package:untitled1/features/onboarding/presentation/widgets/onboarding_text.dart';
import 'package:untitled1/routes/app_routes.dart';

class OnboardingModel {
  final String title;
  final String subtitle;
  final String image;

  OnboardingModel({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

final List<OnboardingModel> onboardingData = [
  OnboardingModel(
    title: AppStrings.onboardingTitle1,
    subtitle: AppStrings.onboardingDescription1,
    image: AppAssets.onBoardingData,
  ),
  OnboardingModel(
    title: AppStrings.onboardingTitle2,
    subtitle: AppStrings.onboardingDescription2,
    image: AppAssets.onboar2,
  ),
  OnboardingModel(
    title: AppStrings.onboardingTitle3,
    subtitle: AppStrings.onboardingDescription3,
    image: AppAssets.onb3,
  ),
  OnboardingModel(
    title: AppStrings.onboardingTitle4,
    subtitle: AppStrings.onboardingDescription4,
    image: AppAssets.onbo4,
  ),
];

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentIndex = 0;

  void next() {
    if (currentIndex < onboardingData.length - 1) {
      setState(() => currentIndex++);
    } else {
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = onboardingData[currentIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Spacer(),
          OnboardingImage(index: currentIndex, image: data.image),
          /*  currentIndex == 0
              ? Lottie.asset(AppAssets.onBoardingData, height: 398.h)
              : Expanded(
                  flex: 2,
                  child: OnboardingImage(
                    index: currentIndex,
                    image: data.image,
                  ),
                ),*/
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              53.hBox,
              OnboardingText(data: data),
              33.hBox,
              // const Spacer(),
              Padding(
                padding: 30.px,
                child: AppButton(title: AppStrings.next, onTap: next),
              ),
              20.hBox,
              const OnboardingFooter(),
              20.hBox,
            ],
          ),
        ],
      ),
    );
  }
}
