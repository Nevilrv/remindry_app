import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/features/profile/provider/profile_provider.dart';
import 'package:untitled1/features/settings/presentation/providers/settings_provider.dart';
import 'package:untitled1/routes/app_routes.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final TextStyle tsBase = TextStyle(color: const Color(0xff09090B), fontFamily: "Intel", fontWeight: FontWeight.w400);

  final List<String> _intensityLabels = ["Gentle", "Balanced", "Aggressive"];

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(settingsProvider).fetchSettings());
  }

  @override
  Widget build(BuildContext context) {
    final settingsWatch = ref.watch(settingsProvider);
    final settingsData = settingsWatch.settings?.data;

    // Map intensity string to double
    double currentIntensity = 1.0;
    if (settingsData?.reminderIntensity != null) {
      final intensity = settingsData!.reminderIntensity!.toLowerCase();
      if (intensity == "gentle") currentIntensity = 0.0;
      if (intensity == "balanced") currentIntensity = 1.0;
      if (intensity == "aggressive") currentIntensity = 2.0;
    }

    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80.h,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(top: 0.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xffE2E8F0)),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(Icons.chevron_left, color: const Color(0xff09090B), size: 24.sp),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Settings",
                      style: tsBase.copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "Join Remindry for a healthier life.",
                      style: tsBase.copyWith(fontSize: 12.sp, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: settingsWatch.isLoading && settingsData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("AI Preferences"),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22.r),
                      border: Border.all(color: const Color(0xffE4E4E7)),
                    ),
                    child: Column(
                      children: [
                        _buildToggleRow(
                          "Voice Assistant",
                          "Enable voice commands",
                          settingsData?.isVoiceAssistant ?? false,
                          (val) => ref.read(settingsProvider).updateSetting(isVoiceAssistant: val),
                        ),
                        Divider(color: Color(0xffF1F5F9)),
                        _buildToggleRow(
                          "Smart Suggestions",
                          "AI-generated health tips",
                          settingsData?.isSmartSuggestions ?? false,
                          (val) => ref.read(settingsProvider).updateSetting(isSmartSuggestions: val),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  _buildSectionTitle("Notifications"),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: const Color(0xffE4E4E7)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Reminder Intensity",
                              style: tsBase.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500, color: const Color(0xff2D3436)),
                            ),
                            Text(
                              _intensityLabels[currentIntensity.toInt()],
                              style: tsBase.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w500, color: const Color(0xFFFF3F57)),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: const Color(0xFFFF3F57),
                            inactiveTrackColor: const Color(0xffF1F5F9), // light grey inactive track
                            trackHeight: 6.h,
                            thumbColor: const Color(0xFFFF3F57),
                            overlayColor: const Color(0xFFFF3F57).withOpacity(0.1),
                            thumbShape: _CustomThumbShape(thumbRadius: 10.r),
                            trackShape: const RoundedRectSliderTrackShape(), // Rounded ends
                            tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 0),
                          ),
                          child: Slider(
                            value: currentIntensity,
                            min: 0,
                            max: 2,
                            divisions: 2,
                            onChanged: (v) {
                              ref.read(settingsProvider).updateSetting(reminderIntensity: _intensityLabels[v.toInt()]);
                            },
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [_buildSliderLabel("Gentle", 0), _buildSliderLabel("Balanced", 1), _buildSliderLabel("Aggressive", 2)],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  _buildSectionTitle("Notification Settings"),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22.r),
                      border: Border.all(color: const Color(0xffE4E4E7)),
                    ),
                    child: Column(
                      children: [
                        _buildToggleRow(
                          "Email",
                          "Toggle Email notifications",
                          settingsData?.isEmail ?? false,
                          (val) => ref.read(settingsProvider).updateSetting(isEmail: val),
                        ),
                        const Divider(color: Color(0xffF1F5F9), height: 1),
                        _buildToggleRow(
                          "SMS",
                          "Toggle SMS notifications",
                          settingsData?.isSms ?? false,
                          (val) => ref.read(settingsProvider).updateSetting(isSms: val),
                        ),
                        const Divider(color: Color(0xffF1F5F9), height: 1),
                        _buildToggleRow(
                          "WhatsApp",
                          "Toggle WhatsApp notifications",
                          settingsData?.isWhatsapp ?? false,
                          (val) => ref.read(settingsProvider).updateSetting(isWhatsapp: val),
                        ),
                        const Divider(color: Color(0xffF1F5F9), height: 1),
                        _buildToggleRow(
                          "Calls",
                          "Toggle Call notifications",
                          settingsData?.isCalls ?? false,
                          (val) => ref.read(settingsProvider).updateSetting(isCalls: val),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

            _buildSectionTitle("Legal"),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(color: const Color(0xffE4E4E7)),
              ),
              child: Column(
                children: [
                  _buildLinkRow("Privacy Policy", "Read our privacy policy", () => context.pushNamed(AppRoutes.privacyPolicy)),
                  const Divider(color: Color(0xffF1F5F9), height: 1),
                  _buildLinkRow(
                    "Terms and Condition",
                    "Read our terms and conditions",
                    () => context.pushNamed(AppRoutes.termsAndConditions),
                  ),
                ],
              ),
            ),
            SizedBox(height: 19.h),

            _buildSectionTitle("Account"),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(color: const Color(0xffE4E4E7)),
              ),
              child: Column(
                children: [
                  _buildDangerLinkRow("Logout", "Sign out of your account", () {
                    _showLogoutConfirmationDialog(context);
                  }),
                  Divider(color: AppColors.extraLightGray, height: 1),
                  _buildDangerLinkRow("Delete My Account", "Toggle SMS notifications", () {
                    _showDeleteConfirmationDialog(context);
                  }),
                ],
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, left: 4.w),
      child: Text(
        title,
        style: tsBase.copyWith(fontSize: 13.sp, color: Colors.black),
      ),
    );
  }

  Widget _buildSliderLabel(String label, int index) {
    return Text(
      label,
      style: tsBase.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Color(0xff2D3436)),
    );
  }

  Widget _buildToggleRow(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: tsBase.copyWith(fontSize: 14.sp, color: const Color(0xff2D3436), fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: tsBase.copyWith(fontSize: 12.sp, color: const Color(0xff636E72)),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => onChanged(!value),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 46.w,
              height: 31.h,
              padding: EdgeInsets.symmetric(horizontal: 6),
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              decoration: BoxDecoration(
                color: value ? const Color(0xFFFF3F57) : const Color(0xffD0D0D0),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Container(
                width: 15.w,
                height: 15.w,
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkRow(String title, String subtitle, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: tsBase.copyWith(fontSize: 14.sp, color: const Color(0xff2D3436), fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: tsBase.copyWith(fontSize: 12.sp, color: const Color(0xff636E72)),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: const Color(0xff636E72), size: 20.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildDangerLinkRow(String title, String subtitle, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: tsBase.copyWith(fontSize: 14.sp, color: AppColors.redGradient, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: tsBase.copyWith(fontSize: 12.sp, color: AppColors.gray1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
            backgroundColor: AppColors.white,
            title: Text(
              "Delete Account",
              style: tsBase.copyWith(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.black),
            ),
            content: Text(
              "Are you sure you want to delete your account? This action cannot be undone.",
              style: tsBase.copyWith(fontSize: 14.sp, color: AppColors.gray1),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: tsBase.copyWith(fontSize: 14.sp, color: AppColors.secondary, fontWeight: FontWeight.w500),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ref.read(profileProvider).deleteAccount(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                ),
                child: Text(
                  "Delete",
                  style: tsBase.copyWith(fontSize: 14.sp, color: AppColors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
            backgroundColor: AppColors.white,
            title: Text(
              "Logout",
              style: tsBase.copyWith(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.black),
            ),
            content: Text(
              "Are you sure you want to log out?",
              style: tsBase.copyWith(fontSize: 14.sp, color: AppColors.gray1),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: tsBase.copyWith(fontSize: 14.sp, color: AppColors.secondary, fontWeight: FontWeight.w500),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ref.read(profileProvider).logoutAccount(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                ),
                child: Text(
                  "Logout",
                  style: tsBase.copyWith(fontSize: 14.sp, color: AppColors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
    );
  }
}

class _CustomThumbShape extends SliderComponentShape {
  final double thumbRadius;
  const _CustomThumbShape({required this.thumbRadius});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Path shadowPath = Path()..addOval(Rect.fromCircle(center: center, radius: thumbRadius));
    canvas.drawShadow(shadowPath, Colors.black, 4, true);

    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, thumbRadius, borderPaint);

    final Paint innerPaint = Paint()
      ..color = sliderTheme.thumbColor ?? const Color(0xFFFF3F57)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, thumbRadius - 2.5, innerPaint);
  }
}
