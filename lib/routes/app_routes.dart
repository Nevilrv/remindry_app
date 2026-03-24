import 'package:flutter/material.dart';
import 'package:untitled1/features/auth/presentation/pages/create_account_page.dart';
import 'package:untitled1/features/auth/presentation/pages/login_page.dart';
import 'package:untitled1/features/auth/presentation/pages/set_permissions_page.dart';
import 'package:untitled1/features/auth/presentation/pages/verify_code_page.dart';
import 'package:untitled1/features/home/presentation/pages/home_page.dart';
import 'package:untitled1/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:untitled1/features/onboarding/presentation/pages/splash_screen.dart';



class AppRoutes {

  static const String initial = "/";
  static const String onboarding = "/onboarding";
  static const String login = "/login";
  static const String createAccount = "/createAccount";
  static const String verifyCode = "/verifyCode";
  static const String setPermissions = "/setPermissions";
  static const String home = "/home";


  static Route onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return MaterialPageRoute(builder: (_) =>  SplashScreen());

      case onboarding:
        return MaterialPageRoute(
            builder: (_) => const OnboardingPage());


      case login:
        return MaterialPageRoute(
            builder: (_) => const LoginPage());

      case createAccount:
        return MaterialPageRoute(
            builder: (_) => const CreateAccountPage());

      case verifyCode:
        return MaterialPageRoute(
            builder: (_) => const VerifyCodePage());

      case setPermissions:
        return MaterialPageRoute(
            builder: (_) => const SetPermissionsPage());

      case home:
        return MaterialPageRoute(
            builder: (_) => const HomePage());

      default:
        return MaterialPageRoute(builder: (_) =>  SplashScreen());
    }
  }
}