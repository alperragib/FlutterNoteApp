import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget CardPropertiesWidget({required String name, required IconData icon}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      boxShadow: const [
        BoxShadow(color: Colors.grey, spreadRadius: 1),
      ],
    ),
    margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
    padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FaIcon(icon, size: 16.sp),
        SizedBox(
          width: 4.w,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 12.sp,
          ),
        ),
      ],
    ),
  );
}
