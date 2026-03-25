import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:untitled1/features/home/presentation/providers/home_provider.dart';
import 'package:untitled1/routes/app_routes.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        // bg2 background at top
        Image.asset(AppAssets.bg3, fit: BoxFit.cover, width: double.infinity),
        SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        16.hBox,

                        // ─── Header ───────────────────────────────────
                        _Header(),
                        20.hBox,

                        // ─── Hero title ───────────────────────────────
                        Text(
                          "Track Your Health,\nStay in Control",
                          style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blackLight,
                            height: 1.3,
                          ),
                        ),
                        16.hBox,

                        // ─── Health Carousel ──────────────────────────
                        _HealthCarousel(),
                        24.hBox,

                        // ─── Category Icons ────────────────────────────
                        _CategoryRow(),
                        20.hBox,

                        // ─── Quick Access ──────────────────────────────
                        _QuickAccess(),
                        24.hBox,

                        // ─── Today's Reminders ─────────────────────────
                        _TodaysReminders(),
                        24.hBox,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Header ─────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar
        Container(
          width: 44.sp,
          height: 44.sp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              "JD",
              style: TextStyle(
                color: AppColors.blackLight,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        12.wBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, John Doe",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.blackLight,
              ),
            ),
            Text(
              "Good Afternoon",
              style: TextStyle(fontSize: 12.sp, color: AppColors.secondary),
            ),
          ],
        ),
        const Spacer(),
        // Notification bell
        GestureDetector(
          onTap: () => context.push(AppRoutes.notification),
          child: Container(
            width: 40.sp,
            height: 40.sp,
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                AppAssets.notificationIcon,
                colorFilter: const ColorFilter.mode(
                  AppColors.black,
                  BlendMode.srcIn,
                ),
                width: 20.sp,
                height: 20.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Health Carousel ─────────────────────────────────────────────────────────

class _HealthCarousel extends ConsumerStatefulWidget {
  @override
  ConsumerState<_HealthCarousel> createState() => _HealthCarouselState();
}

class _HealthCarouselState extends ConsumerState<_HealthCarousel> {
  late final PageController _pageController;
  static const int _cardCount = 3;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(homeProvider);
    return Column(
      children: [
        SizedBox(
          height: 110.h,
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) => provider.setCarouselPage(index),
            physics: const BouncingScrollPhysics(),
            children: const [
              _HealthScoreCard(),
              _HealthScoreCard(),
              _HealthScoreCard(),
            ],
          ),
        ),
        12.hBox,
        _CarouselDots(count: _cardCount, active: provider.carouselPage),
      ],
    );
  }
}

// ─── Health Score Card (Slide 1) ─────────────────────────────────────────────

class _HealthScoreCard extends StatelessWidget {
  const _HealthScoreCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Icon
              Container(
                width: 40.sp,
                height: 40.sp,
                decoration: const BoxDecoration(
                  color: AppColors.blueColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.mail,
                    width: 18.sp,
                    height: 18.sp,
                  ),
                ),
              ),
              12.wBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Health Score",
                    style: TextStyle(fontSize: 12.sp, color: AppColors.secondary),
                  ),
                  10.hBox,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.lightGray5,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      "2 big events this week",
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
          10.hBox,
          Row(
            children: [
              Container(width: 50.sp),
              4.wBox,
              Text(
                "Next:Rahul's Birthday",
                style: TextStyle(fontSize: 12.sp, color: AppColors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Carousel Dot Indicators ─────────────────────────────────────────────────

class _CarouselDots extends StatelessWidget {
  const _CarouselDots({required this.count, required this.active});
  final int count;
  final int active;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == active;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
          margin: EdgeInsets.symmetric(horizontal: 3.w),
          width: isActive ? 20.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            gradient: isActive
                ? const LinearGradient(
                    colors: [AppColors.pinkGradient, AppColors.red],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : const LinearGradient(
                    colors: [Color(0xffE0E0E0), Color(0xffE0E0E0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            borderRadius: BorderRadius.circular(4.r),
          ),
        );
      }),
    );
  }
}

// ─── Category Row ────────────────────────────────────────────────────────────

class _CategoryRow extends ConsumerWidget {
  final _categories = const [
    {'asset': AppAssets.eventsIcon, 'label': 'Events'},
    {'asset': AppAssets.healthIcon, 'label': 'Health'},
    {'asset': AppAssets.warrantyIcon, 'label': 'Warranty'},
    {'asset': AppAssets.moneyIcon, 'label': 'Money'},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(homeProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_categories.length, (index) {
        final cat = _categories[index];
        return GestureDetector(
          onTap: () {
            provider.setSelectedCategory(index);
            if (index == 0) {
              context.pushNamed(AppRoutes.events);
            } else if (index == 1) {
              context.pushNamed(AppRoutes.healthCare);
            } else if (index == 2) {
              context.pushNamed(AppRoutes.warranties);
            } else if (index == 3) {
              provider.setTab(2); // Switch to Money & Debt tab
            }
          },
          child: _CategoryItem(
            asset: cat['asset'] as String,
            label: cat['label'] as String,
            isSelected: provider.selectedCategory == index,
          ),
        );
      }),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    required this.asset,
    required this.label,
    required this.isSelected,
  });
  final String asset;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColors.lightGray4, width: 1),
          ),
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 42.sp,
                  height: 42.sp,
                  decoration: BoxDecoration(
                    color: AppColors.gray2,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      asset,
                      width: 18.sp,
                      height: 18.sp,
                      colorFilter: const ColorFilter.mode(
                        Color(0xff2C2C2C),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                8.hBox,
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Quick Access ─────────────────────────────────────────────────────────────

class _QuickAccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Access",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.blackLight,
          ),
        ),
        12.hBox,
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => context.push(AppRoutes.scanDocument),
                child: Container(
                  padding: EdgeInsets.all(14.r),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.lightGray4, width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 40.sp,
                            height: 40.sp,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppColors.pinkGradient, AppColors.red],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                AppAssets.scanIcon,
                                width: 18.sp,
                                height: 18.sp,
                              ),
                            ),
                          ),
                          Container(
                            height: 16.h,
                            width: 16.h,
                            decoration: BoxDecoration(
                              color: AppColors.lightGray13,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_outward,
                                size: 18.sp,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      10.hBox,
                      Text(
                        "Scan Document",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackLight,
                        ),
                      ),
                      4.hBox,
                      Text(
                        "Digitize your paperwork in seconds.",
                        style: TextStyle(fontSize: 11.sp, color: AppColors.secondary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            12.wBox,
            Expanded(
              child: GestureDetector(
                onTap: () => context.pushNamed(AppRoutes.addReminder),
                child: Container(
                  padding: EdgeInsets.all(14.r),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.lightGray4, width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 40.sp,
                            height: 40.sp,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppColors.pinkGradient, AppColors.red],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                AppAssets.reminderIcon,
                                width: 18.sp,
                                height: 18.sp,
                              ),
                            ),
                          ),
                          Container(
                            height: 16.h,
                            width: 16.h,
                            decoration: BoxDecoration(
                              color: AppColors.lightGray13,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_outward,
                                size: 18.sp,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      10.hBox,
                      Text(
                        "Add Reminder",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                      4.hBox,
                      Text(
                        "Never miss an important deadline.",
                        style: TextStyle(fontSize: 11.sp, color: AppColors.secondary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ─── Today's Reminders ────────────────────────────────────────────────────────

class _TodaysReminders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Today's Reminders",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
            Text(
              "See All",
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.purple,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        12.hBox,
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: AppColors.lightGray4, width: 1.5),
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => context.pushNamed(
                  AppRoutes.reminderDetails,
                  extra: {
                    'icon': AppAssets.tablet,
                    'iconBgColor': AppColors.lightOrange,
                    'iconColor': AppColors.orange,
                    'title': "Take Antibiotics",
                    'subtitle': "8:00 AM • After Breakfast",
                  },
                ),
                child: _ReminderTile(
                  assetPath: AppAssets.tablet,
                  iconBgColor: AppColors.lightOrange,
                  title: "Take Antibiotics",
                  subtitle: "8:00 AM • After Breakfast",
                  badge: "NOW",
                  badgeBgColor: AppColors.orange,
                  badgeTextColor: AppColors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: const Divider(height: 1, color: AppColors.lightGray1),
              ),
              GestureDetector(
                onTap: () => context.pushNamed(
                  AppRoutes.reminderDetails,
                  extra: {
                    'icon': AppAssets.medical,
                    'iconBgColor': AppColors.lightBlueBox,
                    'iconColor': AppColors.primary,
                    'title': "Dr.Smith Chekup",
                    'subtitle': "2:30 AM • Cardiology",
                  },
                ),
                child: _ReminderTile(
                  assetPath: AppAssets.medical,
                  iconBgColor: AppColors.lightBlueBox,
                  title: "Dr.Smith Chekup",
                  subtitle: "2:30 AM • Cardiology",
                  badge: "TODAY",
                  badgeBgColor: AppColors.badgeGray,
                  badgeTextColor: AppColors.badgeGrayText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReminderTile extends StatelessWidget {
  const _ReminderTile({
    required this.assetPath,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.badgeBgColor,
    required this.badgeTextColor,
  });

  final String assetPath;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final String badge;
  final Color badgeBgColor;
  final Color badgeTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          Container(
            width: 48.sp,
            height: 48.sp,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Center(
              child: SvgPicture.asset(assetPath, width: 20.sp, height: 20.sp),
            ),
          ),
          12.wBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackLight,
                  ),
                ),
                4.hBox,
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 13.sp, color: AppColors.secondary),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: badgeBgColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              badge,
              style: TextStyle(
                color: badgeTextColor,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
