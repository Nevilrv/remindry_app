import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_strings.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/utils/widgets/common_app_bar_remindry.dart';
import 'package:untitled1/core/extentions/extentions.dart';

class AiMessagePage extends StatefulWidget {
  const AiMessagePage({super.key});

  @override
  State<AiMessagePage> createState() => _AiMessagePageState();
}

class _AiMessagePageState extends State<AiMessagePage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      "isMe": false,
      "message": "Hello Nice",
      "time": "02:10 PM",
      "sender": "Livechat",
    },
    {
      "isMe": false,
      "message": "I'm Remindry AI. How can I help you today? 💊",
      "time": "02:10 PM",
      "sender": "Livechat",
    },
    {
      "isMe": true,
      "message": "Scan this bill",
      "time": "02:12 PM",
      "sender": "Visitor",
    },
    {
      "isMe": false,
      "message": "I'll help you with that! Let me process your request...",
      "time": "02:13 PM",
      "sender": "Livechat",
    },
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add({
          "isMe": true,
          "message": _messageController.text.trim(),
          "time": TimeOfDay.now().format(context),
          "sender": "Visitor",
        });
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CommonAppBarRemindry(
        title: AppStrings.askRemindry,
        subtitle: AppStrings.joinRemindry,
      ),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: Container(
              color: const Color(0xffF8FAFC),
              child: ListView.builder(
                padding: EdgeInsets.all(20.r),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return _ChatBubble(
                    isMe: msg['isMe'],
                    message: msg['message'],
                    time: msg['time'],
                    sender: msg['sender'],
                  );
                },
              ),
            ),
          ),
          // Categories
          Container(
            height: 60.h,
            color: const Color(0xffF8FAFC),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              children: [
                const _ChatCategoryChip(
                  label: "Event",
                  icon: AppAssets.eventsIcon,
                  color: Color(0xffEFF6FF),
                  textColor: Color(0xff2563EB),
                ),
                const _ChatCategoryChip(
                  label: "Health",
                  icon: AppAssets.healthIcon,
                  color: Color(0xffFEF2F2),
                  textColor: Color(0xffEF4444),
                ),
                const _ChatCategoryChip(
                  label: "Warranty",
                  icon: AppAssets.warrantyIcon,
                  color: Color(0xffFFFBEB),
                  textColor: Color(0xffD97706),
                ),
                const _ChatCategoryChip(
                  label: "Warranty",
                  icon: AppAssets.warrantyIcon,
                  color: Color(0xffECFDF5),
                  textColor: Color(0xff10B981),
                ),
              ],
            ),
          ),
          // Input
          Container(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              bottom: MediaQuery.of(context).padding.bottom + 10,
              top: 10.h,
            ),
            color: AppColors.white,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(color: AppColors.lightGray),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: AppStrings.writeAMessage,
                        hintStyle: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 14.sp,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  10.wBox,
                  GestureDetector(
                    onTap: () {}, // Smile icon function
                    child: SvgPicture.asset(
                      AppAssets.smile,
                      height: 24.sp,
                      width: 24.sp,
                    ),
                  ),
                  16.wBox,
                  GestureDetector(
                    onTap: () {}, // Attachment icon function
                    child: SvgPicture.asset(
                      AppAssets.paperclip,
                      height: 24.sp,
                      width: 24.sp,
                    ),
                  ),
                  16.wBox,
                  GestureDetector(
                    onTap: _sendMessage,
                    child: SvgPicture.asset(
                      AppAssets.send,
                      height: 24.sp,
                      width: 24.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final bool isMe;
  final String message;
  final String time;
  final String sender;

  const _ChatBubble({
    required this.isMe,
    required this.message,
    required this.time,
    required this.sender,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: isMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              if (!isMe) ...[
                Container(
                  width: 28.w,
                  height: 28.w,
                  decoration: const BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.pinkGradient, AppColors.red],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppAssets.aiTip,
                      height: 16.sp,
                      width: 16.sp,
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                10.wBox,
              ],
              Text(
                "$sender $time",
                style: TextStyle(fontSize: 10.sp, color: AppColors.secondary),
              ),
            ],
          ),
          8.hBox,
          Container(
            padding: EdgeInsets.all(16.r),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            decoration: BoxDecoration(
              color: isMe ? const Color(0xffEF4444) : AppColors.white,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: isMe
                  ? null
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                color: isMe ? AppColors.white : AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatCategoryChip extends StatelessWidget {
  final String label;
  final String icon;
  final Color color;
  final Color textColor;

  const _ChatCategoryChip({
    required this.label,
    required this.icon,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12.w, top: 10.h, bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: textColor.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            width: 16.sp,
            height: 16.sp,
            colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
          ),
          8.wBox,
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
