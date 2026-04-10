import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled1/core/constant/app_strings.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:untitled1/core/utils/widgets/app_logo.dart';
import 'package:untitled1/routes/app_routes.dart';

import '../../../../core/constant/app_assets.dart';
import '../../../../services/prefrense_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        if (preferences.getBool(SharedPreference.login) ?? false) {
          context.go(AppRoutes.home);
        } else if (preferences.getBool(SharedPreference.idOnBoardDone) ?? false) {
          context.go(AppRoutes.login);
        } else {
          context.go(AppRoutes.onboarding);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      body: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Lottie.asset(AppAssets.splashJson, height: double.infinity, width: double.infinity, fit: BoxFit.cover),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppLogo(),
                26.hBox,
                Text(
                  AppStrings.remindry,
                  style: TextStyle(color: Colors.black, fontSize: 40.sp, fontWeight: FontWeight.bold),
                ),
                10.hBox,
                Text(
                  AppStrings.yourAiAssistant,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 16.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
