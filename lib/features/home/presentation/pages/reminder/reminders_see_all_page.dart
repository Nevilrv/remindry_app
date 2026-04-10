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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled1/features/home/presentation/providers/reminder_provider.dart';
import 'package:intl/intl.dart';

class RemindersSeeAllPage extends ConsumerWidget {
  const RemindersSeeAllPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reminderProvider);
    final reminders = state.data?.quickReminder ?? [];

    return Scaffold(
      backgroundColor: AppColors.lightGray6,
      body: Column(
        children: [
          const CommonAppBarRemindry(
            title: AppStrings.todaysReminders,
            subtitle: AppStrings.joinRemindry,
          ),
          Expanded(
            child: state.isLoading && reminders.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : reminders.isEmpty
                    ? const Center(child: Text('No reminders found'))
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                        itemCount: reminders.length,
                        separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.lightGray1),
                        itemBuilder: (context, index) {
                          final reminder = reminders[index];
                          final categoryData = _getCategoryData(reminder.category ?? "");
                          final localDateTime = reminder.dateTime?.toLocal();
                          final timeStr = localDateTime != null ? DateFormat('hh:mm a').format(localDateTime) : "N/A";

                          return _buildReminderTile(
                            context,
                            assetPath: categoryData['icon'],
                            iconBgColor: categoryData['bgColor'],
                            iconColor: categoryData['iconColor'],
                            title: reminder.title ?? "",
                            subtitle: "$timeStr • ${reminder.repeat ?? ""}",
                            badge: _getBadgeLabel(localDateTime),
                            badgeBgColor: _getBadgeBgColor(localDateTime),
                            badgeTextColor: _getBadgeTextColor(localDateTime),
                          );
                        },
                      ),
          ),
        ],
      ),
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

  Widget _buildReminderTile(
    BuildContext context, {
    required String assetPath,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String badge,
    required Color badgeBgColor,
    required Color badgeTextColor,
  }) {
    return GestureDetector(
      onTap: () => context.pushNamed(
        AppRoutes.reminderDetails,
        extra: {
          'icon': assetPath,
          'iconBgColor': iconBgColor,
          'iconColor': iconColor,
          'title': title,
          'subtitle': subtitle,
        },
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
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
                child: SvgPicture.asset(
                  assetPath,
                  width: 20.sp,
                  height: 20.sp,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                ),
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
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.secondary,
                    ),
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
      ),
    );
  }
}
