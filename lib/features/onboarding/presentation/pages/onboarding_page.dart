import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_strings.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:untitled1/core/utils/widgets/app_button.dart';
import 'package:untitled1/features/onboarding/presentation/providers/onboarding_provider.dart';
import 'package:untitled1/features/onboarding/presentation/widgets/onboarding_footer.dart';
import 'package:untitled1/features/onboarding/presentation/widgets/onboarding_image.dart';
import 'package:untitled1/features/onboarding/presentation/widgets/onboarding_text.dart';
import 'package:untitled1/routes/app_routes.dart';
import 'package:untitled1/services/prefrense_services.dart';

class OnboardingModel {
  final String title;
  final String subtitle;
  final String image;

  OnboardingModel({required this.title, required this.subtitle, required this.image});
}

final List<OnboardingModel> onboardingData = [
  OnboardingModel(title: AppStrings.onboardingTitle1, subtitle: AppStrings.onboardingDescription1, image: AppAssets.onBoardingData),
  OnboardingModel(title: AppStrings.onboardingTitle2, subtitle: AppStrings.onboardingDescription2, image: AppAssets.onboar2),
  OnboardingModel(title: AppStrings.onboardingTitle3, subtitle: AppStrings.onboardingDescription3, image: AppAssets.onb3),
  OnboardingModel(title: AppStrings.onboardingTitle4, subtitle: AppStrings.onboardingDescription4, image: AppAssets.onbo4),
];

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(onboardingProvider);
    final data = onboardingData[provider.currentIndex];

    void next() {
      ref.read(onboardingProvider).next(
        onboardingData.length,
        () {
          preferences.setBool(SharedPreference.idOnBoardDone, true);
          context.go(AppRoutes.login);
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Spacer(),
          OnboardingImage(index: provider.currentIndex, image: data.image),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              53.hBox,
              OnboardingText(data: data),
              33.hBox,
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
