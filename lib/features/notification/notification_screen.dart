import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/app_ text_style.dart';
import '../../core/constant/app_theme.dart';

import '../../core/utils/widgets/app_button.dart';
import '../../core/utils/widgets/common_app_bar_remindry.dart';
import 'providers/notification_provider.dart';
import 'read_message_screen.dart';
import 'unread_message_screen.dart';
import 'widgets/common_tab_wiget.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationP = ref.watch(notificationProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: const CommonAppBar(
      //   title: "Notifications",
      //   subtitle: "Join Remindry for a healthier life.",
      //   showBackButton: true,
      // ),
      body: Column(
        children: [
          CommonAppBarRemindry(
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
                  Expanded(
                    child: notificationP.isLeft
                        ? const UnreadMessageScreen()
                        : const ReadMessageScreen(),
                  ),

                  Center(
                    child: AppButton(
                      onTap: () {},
                      title: "Mark all as read",
                      icon: Icon(
                        Icons.done_all,
                        color: Colors.white,
                        size: 20.r,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
