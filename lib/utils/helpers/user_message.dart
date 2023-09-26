import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserMessage {
  void toastMessage(
      {required String message,
      Color textColor = Colors.white,
      Color backgroundColor = Colors.grey}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 12.sp,
    );
  }

  void noInternetMessage() {
    toastMessage(
      message: 'İnternet bağlantınızı kontrol ediniz!',
      backgroundColor: Colors.red.withOpacity(0.9),
    );
  }
}
