import 'package:flip_card_swiper/flip_card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/app_ text_style.dart';
import '../../core/constant/app_assets.dart';
import '../../core/constant/app_theme.dart';
import 'widgets/notification_card_widget.dart';

class UnreadMessageScreen extends ConsumerWidget {
  const UnreadMessageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Grouping the data properly so that FlipCardSwiper actually has a stack to display
    final todayNotifications = [
      {
        "category": "Urgent",
        "titleText": "Final Reminder",
        "subtitle": "AI Escalated",
        "message": "Sony Headphones Warranty Expires Tomorrow",
        "icon": AppAssets.alert,
        "categoryColor": AppColors.red,
      },
      {
        "category": "Urgent",
        "titleText": "Second Reminder",
        "subtitle": "AI Escalated",
        "message": "Your subscription is about to end.",
        "icon": AppAssets.alert,
        "categoryColor": AppColors.red,
      },
      {
        "category": "Urgent",
        "titleText": "Third Reminder",
        "subtitle": "AI Escalated",
        "message": "Please update your payment method.",
        "icon": AppAssets.alert,
        "categoryColor": AppColors.red,
      },
    ];

    final yesterdayNotifications = [
      {
        "category": "Medication",
        "titleText": "Time for Antibiotics",
        "subtitle": "AI Escalated",
        "message": "Take With Food • 8:00 AM Daily",
        "icon": AppAssets.tablet,
        "categoryColor": AppColors.orange,
      },
      {
        "category": "Medication",
        "titleText": "Vitamin D",
        "subtitle": "Daily",
        "message": "Take one tablet after lunch",
        "icon": AppAssets.tablet,
        "categoryColor": AppColors.orange,
      },
      {
        "category": "Medication",
        "titleText": "Vitamin D",
        "subtitle": "Daily",
        "message": "Take one tablet after lunch",
        "icon": AppAssets.tablet,
        "categoryColor": AppColors.orange,
      },
    ];

    final sections = [
      {"title": "Today", "count": "5", "data": todayNotifications},
      {"title": "Yesterday", "count": "8", "data": yesterdayNotifications},
    ];

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: sections.length,
      itemBuilder: (context, index) {
        final section = sections[index];
        final title = section["title"] as String;
        final count = section["count"] as String;
        final notifications = section["data"] as List<Map<String, dynamic>>;

        return Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TITLE ROW
              Row(
                children: [
                  Text(title, style: AppTextStyle.f12W400Black),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.lightGray12.withValues(alpha: 0.3),
                      ),
                      color: AppColors.lightGray11,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(count, style: AppTextStyle.f12W400Black),
                  ),
                  const Spacer(),
                  Text("View All", style: AppTextStyle.f12W400Black),
                ],
              ),
              SizedBox(height: 40.h),

              // SWIPER LIST
              StackedNotificationList(notifications: notifications),
            ],
          ),
        );
      },
    );
  }
}

class StackedNotificationList extends StatelessWidget {
  final List<Map<String, dynamic>> notifications;

  const StackedNotificationList({required this.notifications, super.key});

  @override
  Widget build(BuildContext context) {
    // Wrapping in a SizedBox to provide fixed height for the swiper stack
    return IntrinsicHeight(
      child: FlipCardSwiper(
        cardData: notifications,
        onCardChange: (_) {},
        onCardCollectionAnimationComplete: (_) {},
        cardBuilder: (context, index, visibleIndex) {
          final card = notifications[index];

          double opacity;
          if (visibleIndex == 0) {
            // top card
            opacity = 1.0;
          } else if (visibleIndex == 1) {
            // second card
            opacity = 0.7;
          } else if (visibleIndex == 2) {
            // third card
            opacity = 0.4;
          } else {
            // rest (hidden below)
            opacity = 0.0;
          }

          return Opacity(
            opacity: opacity,
            child: Padding(
              padding: EdgeInsets.only(top: 0.sp),
              child: NotificationCard(
                category: card["category"],
                titleText: card["titleText"],
                subtitle: card["subtitle"],
                message: card["message"],
                icon: card["icon"],
                categoryColor: card["categoryColor"],
              ),
            ),
          );
        },
      ),
    );
  }
}
