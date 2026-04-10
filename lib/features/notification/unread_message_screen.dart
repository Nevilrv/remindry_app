import 'package:flip_card_swiper/flip_card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/app_ text_style.dart';
import '../../core/constant/app_theme.dart';
import 'providers/notification_provider.dart';
import 'widgets/notification_card_widget.dart';

class UnreadMessageScreen extends ConsumerStatefulWidget {
  const UnreadMessageScreen({super.key});

  @override
  ConsumerState<UnreadMessageScreen> createState() => _UnreadMessageScreenState();
}

class _UnreadMessageScreenState extends ConsumerState<UnreadMessageScreen> {
  final Set<String> _viewAllSections = {};

  @override
  Widget build(BuildContext context) {
    final notificationP = ref.watch(notificationProvider);

    if (notificationP.isLoading && notificationP.unreadNotifications.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (notificationP.unreadNotifications.isEmpty) {
      return const Center(
        child: Text(
          "No unread notifications",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

    final groupedNotifications = notificationP.groupNotificationsByDate(notificationP.unreadNotifications);
    final sections = groupedNotifications.entries.map((entry) {
      final sectionTitle = entry.key;
      final isViewAll = _viewAllSections.contains(sectionTitle);
      final rawData = entry.value;

      // Limit to 3 if not view all
      final displayData = isViewAll ? rawData : rawData.take(3).toList();

      return {
        "title": sectionTitle,
        "count": rawData.length.toString(),
        "isViewAll": isViewAll,
        "data": displayData
            .map(
              (n) => {
                "category": n.notificationType ?? "General",
                "titleText": n.title ?? "",
                "subtitle": n.notificationType ?? "",
                "message": n.body ?? "",
                "icon": notificationP.getIconForCategory(n.notificationType),
                "categoryColor": notificationP.getColorForCategory(n.notificationType),
              },
            )
            .toList(),
      };
    }).toList();

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: sections.length,
      itemBuilder: (context, index) {
        final section = sections[index];
        final title = section["title"] as String;
        final count = section["count"] as String;
        final notifications = section["data"] as List<Map<String, dynamic>>;
        final isViewAll = section["isViewAll"] as bool;

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
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.lightGray12.withOpacity(0.3)),
                      color: AppColors.lightGray11,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(count, style: AppTextStyle.f12W400Black),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isViewAll) {
                          _viewAllSections.remove(title);
                        } else {
                          _viewAllSections.add(title);
                        }
                      });
                    },
                    child: Text(
                      isViewAll ? "Show Less" : "View All",
                      style: AppTextStyle.f12W400Black.copyWith(color: const Color(0xff3C3C3C)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: isViewAll ? 20.h : 40.h),

              // LIST OR SWIPER
              if (isViewAll)
                ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: notifications.length,
                  separatorBuilder: (context, _) => SizedBox(height: 12.h),
                  itemBuilder: (context, idx) {
                    final card = notifications[idx];
                    return NotificationCard(
                      category: card["category"],
                      titleText: card["titleText"],
                      subtitle: card["subtitle"],
                      message: card["message"],
                      icon: card["icon"],
                      categoryColor: card["categoryColor"],
                    );
                  },
                )
              else
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
