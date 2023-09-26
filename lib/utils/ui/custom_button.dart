import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const CustomButton({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black.withOpacity(0.75),
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.w),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
          side: const BorderSide(color: Colors.white, width: 2),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 14.sp, color: Colors.white),
      ),
    );
  }
}
