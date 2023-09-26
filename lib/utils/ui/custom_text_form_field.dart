import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final IconData? prefixIcon;
  final String hintText;
  final String? errorText;
  final int maxLength, maxLines;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final String? Function()? onEditingComplete;
  final String? Function(String?)? onFieldSubmitted;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.prefixIcon,
    required this.hintText,
    this.errorText,
    this.maxLines = 1,
    this.maxLength = 100,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.black, fontSize: 14.sp),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(width: 1.25, color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(width: 2, color: Colors.black),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(width: 1.25, color: Colors.black),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(width: 1.25, color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(width: 2, color: Colors.red),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(width: 1.25, color: Colors.black),
        ),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.w),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
        errorStyle: TextStyle(color: Colors.red, fontSize: 12.sp),
        hintText: hintText,
        fillColor: Colors.white,
        errorText: errorText,
        prefixIcon: prefixIcon != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    prefixIcon,
                    color: Colors.black,
                    size: 22.sp,
                  ),
                ],
              )
            : null,
      ),
      maxLength: maxLength,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
