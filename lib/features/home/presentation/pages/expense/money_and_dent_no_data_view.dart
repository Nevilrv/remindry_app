import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constant/app_assets.dart';
import '../../../../../core/constant/app_strings.dart';
import '../../../../../core/constant/app_theme.dart';
import '../../../../../core/extentions/extentions.dart';
import '../../../../../core/utils/widgets/app_button.dart';
import '../../../../../core/utils/widgets/common_app_bar_remindry.dart';
import '../../../../../features/profile/provider/profile_provider.dart';
import '../../../../../routes/app_routes.dart';

class MoneyAndDentNoDataView extends ConsumerWidget {
  const MoneyAndDentNoDataView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isMale =
        ref.watch(profileProvider).selectedGender.toLowerCase() == 'male';
    String currentImage = isMale ? AppAssets.boy : AppAssets.girl;

    return Scaffold(
      backgroundColor: AppColors.lightGray6,
      body: Stack(
        children: [
          Column(
            children: [
              CommonAppBarRemindry(
                title: AppStrings.moneyAndDebt,
                subtitle: AppStrings.joinRemindry,
                showBackButton: false,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        13.hBox,
                        SizedBox(
                          height: 340.h,
                          width: 300.w,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(currentImage, height: 340.h),
                              Positioned(
                                top: 100.h,
                                left: 20.w,
                                child: _FloatingTag(
                                  title: "Entertainment",
                                  amount: "\$120",
                                  bgColor: const Color(0xffF9D8E6),
                                  amountColor: AppColors.primary,
                                  angle: -20,
                                  iconAsset: AppAssets.entaintament,
                                ),
                              ),
                              Positioned(
                                top: 120.h,
                                right: 59.w,
                                child: _FloatingTag(
                                  title: "Dining",
                                  amount: "\$830",
                                  bgColor: const Color(0xffF7E9D7),
                                  amountColor: AppColors.black,
                                  angle: 20,
                                  iconAsset: AppAssets.pizza,
                                ),
                              ),
                              Positioned(
                                bottom: 110.h,
                                left: 65.w,
                                child: _FloatingTag(
                                  title: "Savings",
                                  amount: "\$260",
                                  bgColor: const Color(0xffF7E9D7),
                                  amountColor: AppColors.black,
                                  angle: -30,
                                  iconAsset: AppAssets.moneyPng,
                                ),
                              ),
                              Positioned(
                                bottom: 90.h,
                                right: 50.w,
                                child: _FloatingTag(
                                  title: "Groceries",
                                  amount: "\$455",
                                  bgColor: const Color(0xffF9D8E6),
                                  amountColor: AppColors.primary,
                                  angle: 20,
                                  iconAsset: AppAssets.trolli,
                                ),
                              ),
                              Positioned(
                                bottom: 23.h,
                                left: 90.w,
                                child: _FloatingTag(
                                  title: "Subscriptions",
                                  amount: "\$82",
                                  bgColor: const Color(0xffF7E9D7),
                                  amountColor: AppColors.black,
                                  angle: 8,
                                  iconAsset: AppAssets.tv,
                                ),
                              ),
                            ],
                          ),
                        ),
                        27.hBox,
                        Text(
                          AppStrings.nothingHere,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          AppStrings.addFirstExpense,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.black,
                          ),
                        ),
                        18.hBox,
                        AppButton(
                          onTap: () => context.pushNamed(AppRoutes.addExpense),
                          title: AppStrings.addExpensePlus,
                        ),
                        66.hBox,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Positioned(bottom: 20.h, left: 0, right: 0, child: const AppBottomBar()),
          100.hBox,
        ],
      ),
    );
  }
}

class _FloatingTag extends StatefulWidget {
  final String title;
  final String amount;
  final Color bgColor;
  final Color amountColor;
  final double angle;
  final String iconAsset;

  const _FloatingTag({
    required this.title,
    required this.amount,
    required this.bgColor,
    required this.amountColor,
    required this.angle,
    required this.iconAsset,
  });

  @override
  State<_FloatingTag> createState() => _FloatingTagState();
}

class _FloatingTagState extends State<_FloatingTag>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Use slightly different speeds and starting offsets for a natural floating look
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500 + (widget.title.length * 50)),
      vsync: this,
    );
    _controller.value = (widget.angle.abs() % 10) / 10;
    _controller.repeat(reverse: true);

    _animation = Tween<double>(
      begin: -8.0,
      end: 8.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: Transform.rotate(
        angle: widget.angle * 3.14159 / 180,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: widget.bgColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(widget.iconAsset, height: 16.h, width: 16.w),
              4.wBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    widget.amount,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w800,
                      color: widget.amountColor,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
