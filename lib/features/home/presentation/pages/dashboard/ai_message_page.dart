import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/core/constant/app_assets.dart';
import 'package:untitled1/core/constant/app_strings.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/core/utils/widgets/common_app_bar_remindry.dart';
import 'package:untitled1/core/extentions/extentions.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class AiMessagePage extends StatefulWidget {
  const AiMessagePage({super.key});

  @override
  State<AiMessagePage> createState() => _AiMessagePageState();
}

class _AiMessagePageState extends State<AiMessagePage> {
  final TextEditingController _messageController = TextEditingController();
  bool _showEmojiPicker = false;
  final FocusNode _focusNode = FocusNode();
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
        _showEmojiPicker = false;
      });
    }
  }

  void _onEmojiSelected(Emoji emoji) {
    _messageController.text = _messageController.text + emoji.emoji;
  }

  void _showAttachmentSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xffE2E8F0),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            24.hBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _AttachmentOption(
                  icon: AppAssets.camera,
                  label: "Camera",
                  onTap: () async {
                    Navigator.pop(context);
                    final picker = ImagePicker();
                    final image = await picker.pickImage(
                      source: ImageSource.camera,
                    );
                    if (image != null) _handleFileSelected(image.name);
                  },
                ),
                _AttachmentOption(
                  icon: AppAssets.gallery,
                  label: "Gallery",
                  onTap: () async {
                    Navigator.pop(context);
                    final picker = ImagePicker();
                    final image = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (image != null) _handleFileSelected(image.name);
                  },
                ),
                _AttachmentOption(
                  icon: AppAssets.reportdoc,
                  label: "Documents",
                  onTap: () async {
                    Navigator.pop(context);
                    final result = await FilePicker.platform.pickFiles();
                    if (result != null)
                      _handleFileSelected(result.files.single.name);
                  },
                ),
              ],
            ),
            20.hBox,
          ],
        ),
      ),
    );
  }

  void _handleFileSelected(String name) {
    setState(() {
      _messages.add({
        "isMe": true,
        "message": "📎 Attached: $name",
        "time": TimeOfDay.now().format(context),
        "sender": "Visitor",
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_showEmojiPicker,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _showEmojiPicker) {
          setState(() {
            _showEmojiPicker = false;
          });
        }
      },
      child: Scaffold(
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
                bottom: _showEmojiPicker
                    ? 10
                    : MediaQuery.of(context).padding.bottom + 10,
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
                        focusNode: _focusNode,
                        onTap: () {
                          if (_showEmojiPicker) {
                            setState(() {
                              _showEmojiPicker = false;
                            });
                          }
                        },
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
                      onTap: () {
                        _focusNode.unfocus();
                        setState(() {
                          _showEmojiPicker = !_showEmojiPicker;
                        });
                      },
                      child: SvgPicture.asset(
                        AppAssets.smile,
                        height: 24.sp,
                        width: 24.sp,
                      ),
                    ),
                    16.wBox,
                    GestureDetector(
                      onTap: _showAttachmentSheet,
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
            if (_showEmojiPicker)
              SizedBox(
                height: 250.h,
                child: EmojiPicker(
                  onEmojiSelected: (category, emoji) => _onEmojiSelected(emoji),
                  config: const Config(
                    height: 256,
                    checkPlatformCompatibility: true,
                    emojiViewConfig: EmojiViewConfig(
                      columns: 7,
                      emojiSizeMax: 28,
                      verticalSpacing: 0,
                      horizontalSpacing: 0,
                      gridPadding: EdgeInsets.zero,
                      backgroundColor: const Color(0xFFF8FAFC),
                    ),
                    categoryViewConfig: CategoryViewConfig(
                      initCategory: Category.RECENT,
                      backgroundColor: const Color(0xFFF2F2F2),
                      indicatorColor: AppColors.primary,
                      iconColor: AppColors.secondary,
                      iconColorSelected: AppColors.primary,
                      backspaceColor: AppColors.primary,
                      dividerColor: AppColors.primary,
                    ),
                    skinToneConfig: SkinToneConfig(
                      enabled: true,
                      dialogBackgroundColor: Colors.white,
                      indicatorColor: AppColors.primary,
                    ),
                    searchViewConfig: SearchViewConfig(),
                    bottomActionBarConfig: BottomActionBarConfig(
                      buttonColor: AppColors.lightGray2,
                      backgroundColor: Colors.white,
                      buttonIconColor: AppColors.primary,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AttachmentOption extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const _AttachmentOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60.sp,
            height: 60.sp,
            decoration: BoxDecoration(
              color: const Color(0xffF8FAFC),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: const Color(0xffE2E8F0)),
            ),
            child: Center(
              child: SvgPicture.asset(
                icon,
                width: 24.sp,
                height: 24.sp,
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
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
              color: const Color(0xff09090B),
              fontWeight: FontWeight.w500,
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
