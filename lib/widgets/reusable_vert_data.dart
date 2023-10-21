import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableVertData extends StatelessWidget {
  final String text;
  final Color? textColor;
  final String data;
  final Color? dataColor;
  const ReusableVertData(
      {super.key,
      required this.text,
      required this.data,
      this.textColor,
      this.dataColor});

  @override
  Widget build(BuildContext context) {
    // Total Screen Width
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          data,
          style: TextStyle(
              fontSize: screenWidth <= 375 ? 12.sp.h : 14.sp.h,
              color: dataColor ?? Colors.white,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: screenWidth <= 375 ? 10.sp.h : 10.sp.h,
              color: textColor ?? Colors.white,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
