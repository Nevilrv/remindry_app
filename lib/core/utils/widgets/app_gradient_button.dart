import 'package:flutter/material.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/utils/widgets/app_button.dart';

class AppGradientButton extends StatelessWidget {
  final Function() onTap;
  final String title;
  final Widget? icon;

  const AppGradientButton({
    super.key,
    required this.onTap,
    required this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onTap: onTap,
      title: title,
      icon: icon,
      gradient: const LinearGradient(
        colors: [AppColors.pinkGradient, AppColors.redGradient],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }
}
