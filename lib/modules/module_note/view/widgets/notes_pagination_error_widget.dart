import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NotesPaginationErrorWidget extends StatelessWidget {
  final PagingController<dynamic, dynamic> controller;
  final String messageTitle, messageContent, buttonText;
  final IconData buttonIcon;
  final VoidCallback? onPressed;
  final bool buttonVisible;

  const NotesPaginationErrorWidget({
    super.key,
    required this.controller,
    required this.messageTitle,
    required this.messageContent,
    this.buttonText = 'Tekrar Dene',
    this.buttonIcon = FontAwesomeIcons.rotateRight,
    this.onPressed,
    this.buttonVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
      child: Column(
        children: [
          Text(
            messageTitle,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 4.w,
          ),
          Text(
            messageContent,
            style: TextStyle(fontSize: 14.sp),
          ),
          SizedBox(
            height: 8.w,
          ),
          if (buttonVisible)
            ElevatedButton(
              onPressed: onPressed ?? () => controller.refresh(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    buttonIcon,
                    size: 16.sp,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    buttonText,
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
