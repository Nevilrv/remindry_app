import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/app_ text_style.dart';
import '../../../core/constant/app_theme.dart';

class SegmentedTab extends StatelessWidget {
  final String leftText;
  final String rightText;
  final bool isLeftSelected;
  final Function(bool) onChanged;

  const SegmentedTab({
    super.key,
    required this.leftText,
    required this.rightText,
    required this.isLeftSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58.h,
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: AppColors.lightGray11,
        borderRadius: BorderRadius.circular(58.r),
      ),
      child: Row(
        children: [
          // LEFT OPTION
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                  gradient: isLeftSelected
                      ? const LinearGradient(
                          colors: [
                            AppColors.pinkGradient,
                            AppColors.redGradient,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  leftText,
                  style: AppTextStyle.f16boldBlack.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: isLeftSelected ? Colors.white : Colors.black54,
                  ),
                  // style: TextStyle(
                  //   fontSize: 15.sp,
                  //   color: isLeftSelected ? Colors.white : Colors.black54,
                  //   fontWeight: isLeftSelected ? FontWeight.w600 : FontWeight.normal,
                  // ),
                ),
              ),
            ),
          ),

          // RIGHT OPTION
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                  gradient: !isLeftSelected
                      ? const LinearGradient(
                          colors: [Color(0xFFFF5282), Color(0xFFFF4B5A)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  rightText,
                  style: AppTextStyle.f16boldBlack.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: !isLeftSelected ? Colors.white : Colors.black54,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
