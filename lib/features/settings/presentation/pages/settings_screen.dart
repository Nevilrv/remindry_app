import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/routes/app_routes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextStyle tsBase = TextStyle(color: const Color(0xff09090B), fontFamily: "Intel", fontWeight: FontWeight.w400);

  bool _voiceAssistant = false;
  bool _smartSuggestions = true;
  bool _emailNotif = false;
  bool _smsNotif = true;
  bool _whatsappNotif = true;
  bool _callNotif = true;

  double _sliderValue = 1.0;
  final List<String> _intensityLabels = ["Gentle", "Balanced", "Aggressive"];

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
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
                    _voiceAssistant,
                    (val) => setState(() => _voiceAssistant = val),
                  ),
                  Divider(color: Color(0xffF1F5F9)),
                  _buildToggleRow(
                    "Smart Suggestions",
                    "AI-generated health tips",
                    _smartSuggestions,
                    (val) => setState(() => _smartSuggestions = val),
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
                        _intensityLabels[_sliderValue.toInt()],
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
                      value: _sliderValue,
                      min: 0,
                      max: 2,
                      divisions: 2,
                      onChanged: (v) {
                        setState(() {
                          _sliderValue = v;
                        });
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
                  _buildToggleRow("Email", "Toggle Email notifications", _emailNotif, (val) => setState(() => _emailNotif = val)),
                  const Divider(color: Color(0xffF1F5F9), height: 1),
                  _buildToggleRow("SMS", "Toggle SMS notifications", _smsNotif, (val) => setState(() => _smsNotif = val)),
                  const Divider(color: Color(0xffF1F5F9), height: 1),
                  _buildToggleRow(
                    "WhatsApp",
                    "Toggle WhatsApp notifications",
                    _whatsappNotif,
                    (val) => setState(() => _whatsappNotif = val),
                  ),
                  const Divider(color: Color(0xffF1F5F9), height: 1),
                  _buildToggleRow("Calls", "Toggle Call notifications", _callNotif, (val) => setState(() => _callNotif = val)),
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
                  _buildLinkRow(
                    "Privacy Policy",
                    "Read our privacy policy",
                    () => context.pushNamed(AppRoutes.privacyPolicy),
                  ),
                  const Divider(color: Color(0xffF1F5F9), height: 1),
                  _buildLinkRow(
                    "Terms and Condition",
                    "Read our terms and conditions",
                    () => context.pushNamed(AppRoutes.termsAndConditions),
                  ),
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
