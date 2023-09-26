import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomIconButton extends StatelessWidget {
  final String? tooltip;
  final IconData icon;
  final Color iconColor;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;

  const CustomIconButton(
      {super.key,
      required this.icon,
      this.tooltip,
      this.iconColor = Colors.black,
      this.padding,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 4.w),
      child: IconButton(
        onPressed: onPressed ?? () {},
        tooltip: tooltip,
        color: Colors.black,
        style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            elevation: 5,
            shadowColor: Colors.black),
        padding: padding ?? EdgeInsets.all(10.w),
        icon: FaIcon(
          icon,
          size: 18.sp,
          color: iconColor,
        ),
      ),
    );
  }
}
