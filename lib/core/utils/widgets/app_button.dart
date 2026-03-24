import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/core/extentions/extentions.dart';

class AppButton extends StatelessWidget {
  final Function() onTap;
  final String title;
  const AppButton({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return   GestureDetector(
      onTap: onTap,
      child: Container(
        padding: 20.py,
        width: size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35.r),
            gradient: LinearGradient(
              colors: [Color(0xff363543), Color(0xff1C1C24)],
            ),
            border: Border.all()
        ),
        child: Center(
          child: Text(title,style: TextStyle(
            fontSize: 14.sp,color: Colors.white,
            fontWeight: FontWeight.w500,
          ),),
        ),
      ),
    );
  }
}
