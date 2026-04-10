import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/widgets/app_button.dart';
import '../../core/utils/widgets/common_app_bar_remindry.dart';
import '../home/presentation/providers/home_provider.dart';
import 'providers/notification_provider.dart';
import 'read_message_screen.dart';
import 'unread_message_screen.dart';
import 'widgets/common_tab_wiget.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationProvider).fetchNotifications(status: 0);
      ref.read(notificationProvider).fetchNotifications(status: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final notificationP = ref.watch(notificationProvider);

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        ref.read(homeProvider).clearNotificationBadge();
      },
      child: Scaffold(
        backgroundColor: Colors.white,

        // appBar: const CommonAppBar(
        //   title: "Notifications",
        //   subtitle: "Join Remindry for a healthier life.",
        //   showBackButton: true,
        // ),
        body: Column(
          children: [
            CommonAppBarRemindry(
              onBack: () {
                ref.read(homeProvider).clearNotificationBadge();
                context.pop();
              },
              title: "Notifications",
              subtitle: "Join Remindry for a healthier life.",
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(height: 24.h),
                    SegmentedTab(
                      leftText: "Unread",
                      rightText: "Read",
                      isLeftSelected: notificationP.isLeft,
                      onChanged: (val) {
                        notificationP.isChangeLeft(value: val);
                      },
                    ),
                    SizedBox(height: 17.h),
                    Expanded(child: notificationP.isLeft ? const UnreadMessageScreen() : const ReadMessageScreen()),

                    if (notificationP.isLeft && notificationP.unreadNotifications.isNotEmpty) ...[
                      Center(
                        child: AppButton(
                          onTap: () {
                            notificationP.markAllRead();
                          },
                          title: "Mark all as read",
                          icon: Icon(Icons.done_all, color: Colors.white, size: 20.r),
                        ),
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
