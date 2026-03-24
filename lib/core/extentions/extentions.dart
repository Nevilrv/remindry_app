import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SpaceExtension on num {
  SizedBox get hBox => SizedBox(height: h);
  SizedBox get wBox => SizedBox(width: w);
  SizedBox get box => SizedBox(height: h, width: w);
}

extension PaddingExtension on num {
  EdgeInsets get p => EdgeInsets.all(r);

  EdgeInsets get px => EdgeInsets.symmetric(horizontal: w);
  EdgeInsets get py => EdgeInsets.symmetric(vertical: h);

  EdgeInsets get pt => EdgeInsets.only(top: h);
  EdgeInsets get pb => EdgeInsets.only(bottom: h);
  EdgeInsets get pl => EdgeInsets.only(left: w);
  EdgeInsets get pr => EdgeInsets.only(right: w);
}

