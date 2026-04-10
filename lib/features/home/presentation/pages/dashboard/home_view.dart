import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_strings.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:untitled1/features/home/presentation/providers/home_provider.dart';
import 'package:untitled1/features/home/presentation/providers/reminder_provider.dart';
import 'package:untitled1/routes/app_routes.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeProvider).fetchProfile();
      ref.read(reminderProvider.notifier).fetchReminders();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                          style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w400, color: AppColors.blackLight, height: 1.3),
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

                        30.hBox,
                        30.hBox,
                        15.hBox,
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

class _Header extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(homeProvider).profileData?.data;
    final String fullName = "${profile?.firstName ?? "John"} ${profile?.lastName ?? "Doe"}";
    final String initials = (profile?.firstName?.isNotEmpty ?? false)
        ? (profile!.firstName![0] + (profile.lastName?.isNotEmpty == true ? profile.lastName![0] : ""))
        : "JD";

    return Row(
      children: [
        // Avatar
        GestureDetector(
          onTap: () => context.push(AppRoutes.profile),
          child: Container(
            width: 44.sp,
            height: 44.sp,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: Center(
              child: Text(
                initials,
                style: TextStyle(color: AppColors.blackLight, fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        12.wBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, $fullName",
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: AppColors.blackLight),
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
          onTap: () {
            ref.read(homeProvider).clearNotificationBadge();
            context.push(AppRoutes.notification);
          },
          child: Stack(
            children: [
              Container(
                width: 40.sp,
                height: 40.sp,
                decoration: const BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
                child: Center(
                  child: Image.asset(AppAssets.notification, width: 20.sp, height: 20.sp),
                ),
              ),
              if (ref.watch(homeProvider).hasNewNotification)
                Positioned(
                  top: 12,
                  right: 11,
                  child: Container(
                    width: 8.r,
                    height: 8.r,
                    decoration: BoxDecoration(
                      color: AppColors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.black1, width: 1.5),
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
            children: const [_HealthScoreCard(), _HealthScoreCard(), _HealthScoreCard()],
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
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Icon
              Container(
                width: 40.sp,
                height: 40.sp,
                decoration: const BoxDecoration(color: AppColors.blueColor, shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(AppAssets.mail, width: 18.sp, height: 18.sp),
                ),
              ),
              12.wBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Health Score",
                      style: TextStyle(fontSize: 12.sp, color: AppColors.secondary),
                    ),
                    10.hBox,
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                      decoration: BoxDecoration(color: AppColors.lightGray5, borderRadius: BorderRadius.circular(20.r)),
                      child: Text(
                        "2 big events this week",
                        style: TextStyle(fontSize: 11.sp, color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
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
                : const LinearGradient(colors: [Colors.white, Colors.white], begin: Alignment.topLeft, end: Alignment.bottomRight),
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
  const _CategoryItem({required this.asset, required this.label, required this.isSelected});
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
                  decoration: BoxDecoration(color: AppColors.gray2, borderRadius: BorderRadius.circular(12.r)),
                  child: Center(
                    child: SvgPicture.asset(
                      asset,
                      width: 18.sp,
                      height: 18.sp,
                      colorFilter: const ColorFilter.mode(Color(0xff2C2C2C), BlendMode.srcIn),
                    ),
                  ),
                ),
                8.hBox,
                Text(
                  label,
                  style: TextStyle(fontSize: 12.sp, color: AppColors.black, fontWeight: FontWeight.w500),
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
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.blackLight),
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
                              child: SvgPicture.asset(AppAssets.scanIcon, width: 18.sp, height: 18.sp),
                            ),
                          ),
                          Container(
                            height: 16.h,
                            width: 16.h,
                            decoration: BoxDecoration(color: AppColors.lightGray13, shape: BoxShape.circle),
                            child: Center(
                              child: Icon(Icons.arrow_outward, size: 18.sp, color: AppColors.black),
                            ),
                          ),
                        ],
                      ),
                      10.hBox,
                      Text(
                        "Scan Document",
                        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: AppColors.blackLight),
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
                              child: SvgPicture.asset(AppAssets.reminderIcon, width: 18.sp, height: 18.sp),
                            ),
                          ),
                          Container(
                            height: 16.h,
                            width: 16.h,
                            decoration: BoxDecoration(color: AppColors.lightGray13, shape: BoxShape.circle),
                            child: Center(
                              child: Icon(Icons.arrow_outward, size: 18.sp, color: AppColors.black),
                            ),
                          ),
                        ],
                      ),
                      10.hBox,
                      Text(
                        "Add Reminder",
                        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: AppColors.black),
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

class _TodaysReminders extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reminderProvider);
    final remindersList = state.data?.quickReminder ?? [];
    final reminders = remindersList.take(2).toList();

    if (state.isLoading && remindersList.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (remindersList.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.todaysReminders,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.black),
            ),
            GestureDetector(
              onTap: () => context.pushNamed(AppRoutes.remindersSeeAll),
              child: Text(
                AppStrings.seeAll,
                style: TextStyle(fontSize: 14.sp, color: AppColors.purple, fontWeight: FontWeight.w500),
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
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reminders.length,
            separatorBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: const Divider(height: 1, color: AppColors.lightGray1),
            ),
            itemBuilder: (context, index) {
              final reminder = reminders[index];
              final categoryData = _getCategoryData(reminder.category ?? "");
              final localDateTime = reminder.dateTime?.toLocal();
              final timeStr = localDateTime != null ? DateFormat('hh:mm a').format(localDateTime) : "N/A";

              return GestureDetector(
                onTap: () => context.pushNamed(
                  AppRoutes.reminderDetails,
                  extra: {
                    'icon': categoryData['icon'],
                    'iconBgColor': categoryData['bgColor'],
                    'iconColor': categoryData['iconColor'],
                    'title': reminder.title ?? "",
                    'subtitle': "$timeStr • ${reminder.repeat ?? ""}",
                  },
                ),
                child: _ReminderTile(
                  assetPath: categoryData['icon'],
                  iconBgColor: categoryData['bgColor'],
                  iconColor: categoryData['iconColor'],
                  title: reminder.title ?? "",
                  subtitle: "$timeStr • ${reminder.repeat ?? ""}",
                  badge: _getBadgeLabel(localDateTime),
                  badgeBgColor: _getBadgeBgColor(localDateTime),
                  badgeTextColor: _getBadgeTextColor(localDateTime),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Map<String, dynamic> _getCategoryData(String category) {
    switch (category.toLowerCase()) {
      case 'health':
        return {'icon': AppAssets.health, 'bgColor': AppColors.primaryLight3, 'iconColor': AppColors.primary};
      case 'events':
        return {'icon': AppAssets.event, 'bgColor': AppColors.lightGray2, 'iconColor': Colors.black};
      case 'warranty':
        return {'icon': AppAssets.warranty, 'bgColor': AppColors.lightGray10, 'iconColor': Colors.black};
      case 'money':
        return {'icon': AppAssets.money, 'bgColor': AppColors.gray2, 'iconColor': Colors.black};
      default:
        return {'icon': AppAssets.other, 'bgColor': AppColors.lightGray6, 'iconColor': Colors.black};
    }
  }

  String _getBadgeLabel(DateTime? date) {
    if (date == null) return "LATER";
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      if (date.difference(now).inMinutes.abs() < 60) return "NOW";
      return "TODAY";
    }
    return "LATER";
  }

  Color _getBadgeBgColor(DateTime? date) {
    if (date == null) return AppColors.badgeGray;
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      if (date.difference(now).inMinutes.abs() < 60) return AppColors.orange;
      return AppColors.badgeGray;
    }
    return AppColors.badgeGray;
  }

  Color _getBadgeTextColor(DateTime? date) {
    if (date == null) return AppColors.badgeGrayText;
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      if (date.difference(now).inMinutes.abs() < 60) return Colors.white;
      return AppColors.badgeGrayText;
    }
    return AppColors.badgeGrayText;
  }
}

class _ReminderTile extends StatelessWidget {
  const _ReminderTile({
    required this.assetPath,
    required this.iconBgColor,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.badgeBgColor,
    required this.badgeTextColor,
  });

  final String assetPath;
  final Color iconBgColor;
  final Color iconColor;
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
            decoration: BoxDecoration(color: iconBgColor, borderRadius: BorderRadius.circular(14.r)),
            child: Center(
              child: SvgPicture.asset(assetPath, width: 20.sp, height: 20.sp, colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn)),
            ),
          ),
          12.wBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500, color: AppColors.blackLight),
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
            decoration: BoxDecoration(color: badgeBgColor, borderRadius: BorderRadius.circular(20.r)),
            child: Text(
              badge,
              style: TextStyle(color: badgeTextColor, fontSize: 10.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
