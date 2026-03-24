import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled1/core/constant/app_assets.dart';

class GradientBg extends StatelessWidget {
  const GradientBg({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AppAssets.bg,fit: BoxFit.cover,);
  }
}
