import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_strings.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:untitled1/core/utils/widgets/common_app_bar_remindry.dart';

import 'package:untitled1/routes/app_routes.dart';

class MoneyAndDebtView extends StatelessWidget {
  const MoneyAndDebtView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray6,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: CommonAppBarRemindry(
              title: AppStrings.moneyAndDebt,
              subtitle: AppStrings.joinRemindry,
              showBackButton: false,
              actions: [
                GestureDetector(
                  onTap: () => context.pushNamed(AppRoutes.addExpense),
                  child: SvgPicture.asset(
                    AppAssets.add,
                    width: 46.sp,
                    height: 46.sp,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.hBox,
                    // Total Owe Card
                    Container(
                      height: 110.h,
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                            AppAssets.expensesCardBg,
                            width: double.infinity,
                            height: 160.h,
                            fit: BoxFit.fill,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 18.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppStrings.totalYouOwe,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 11.w,
                                        vertical: 5.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(
                                          73.r,
                                        ),
                                      ),
                                      child: Text(
                                        AppStrings.due5thFeb,
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: AppColors.badgeGrayText,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  AppStrings.totalOweAmount,
                                  style: TextStyle(
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                                Text(
                                  AppStrings.acrossPendingDebts,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.hBox,
                    // Paid Back Section
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 13.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.paidBack,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              ),
                              Text(
                                AppStrings.paidBackProgress,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                          8.hBox,
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: LinearProgressIndicator(
                              value: 1750 / 4250,
                              minHeight: 6.h,
                              backgroundColor: AppColors.lightGray1,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primary,
                              ),
                            ),
                          ),
                          16.hBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatItem("₹1750", AppStrings.paid),
                              Container(
                                height: 24.h,
                                width: 1.w,
                                color: AppColors.lightGray1,
                              ),
                              _buildStatItem("₹2,500", AppStrings.remaining),
                              Container(
                                height: 24.h,
                                width: 1.w,
                                color: AppColors.lightGray1,
                              ),
                              _buildStatItem("3", AppStrings.debt),
                            ],
                          ),
                        ],
                      ),
                    ),
                    19.hBox,
                    Text(
                      AppStrings.spendingBreakdown,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ),
                    13.hBox,
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      crossAxisCount: 4,
                      mainAxisSpacing: 10.h,
                      crossAxisSpacing: 10.w,
                      childAspectRatio: 0.72,
                      children: [
                        _buildBreakdownItem(
                          AppAssets.food,
                          AppStrings.food,
                          "₹1.2k",
                        ),
                        _buildBreakdownItem(
                          AppAssets.transport,
                          AppStrings.transport,
                          "₹1.2k",
                        ),
                        _buildBreakdownItem(
                          AppAssets.fun,
                          AppStrings.fun,
                          "₹1.2k",
                        ),
                        _buildBreakdownItem(
                          AppAssets.shooping,
                          AppStrings.shopping,
                          "₹1.2k",
                        ),
                        _buildBreakdownItem(
                          AppAssets.health,
                          AppStrings.health,
                          "₹1.2k",
                        ),
                        _buildBreakdownItem(
                          AppAssets.bills,
                          AppStrings.bills,
                          "₹1.2k",
                        ),
                        _buildBreakdownItem(
                          AppAssets.travel,
                          AppStrings.travel,
                          "₹1.2k",
                        ),
                        _buildBreakdownItem(
                          AppAssets.other,
                          AppStrings.other,
                          "₹1.2k",
                        ),
                      ],
                    ),
                    13.hBox,
                    Text(
                      AppStrings.pendingDebts,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ),
                    13.hBox,
                    _buildDebtItem("Ravi Kumar", "Dinner Split", "- ₹500"),
                    8.hBox,
                    _buildDebtItem("Ravi Kumar", "Dinner Split", "- ₹500"),
                    24.hBox,
                    // AI Insights Card
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 40.h,
                                width: 40.h,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.pinkGradient,
                                      AppColors.redGradient,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    AppAssets.aiTip,
                                    width: 20.sp,
                                    height: 20.sp,
                                    colorFilter: const ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                              8.wBox,
                              Text(
                                AppStrings.aiInsights,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                          12.hBox,
                          Text(
                            AppStrings.raviDebtInsight,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    100.hBox, // Space for bottom bar
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 10.sp, color: AppColors.iconGray),
        ),
      ],
    );
  }

  Widget _buildBreakdownItem(String asset, String label, String amount) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.lightGray1.withOpacity(0.5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: AppColors.lightGray10,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: SvgPicture.asset(
              asset,
              width: 20.sp,
              height: 20.sp,
              colorFilter: const ColorFilter.mode(
                AppColors.badgeGrayText,
                BlendMode.srcIn,
              ),
            ),
          ),
          5.hBox,
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.badgeGrayText,
              fontWeight: FontWeight.w500,
            ),
          ),
          5.hBox,
          Text(
            amount,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDebtItem(String name, String reason, String amount) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 44.sp,
            height: 44.sp,
            decoration: BoxDecoration(
              color: AppColors.primaryLight1,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(Icons.person_outline, color: AppColors.primary),
          ),
          12.wBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                Text(
                  reason,
                  style: TextStyle(fontSize: 11.sp, color: AppColors.iconGray),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
