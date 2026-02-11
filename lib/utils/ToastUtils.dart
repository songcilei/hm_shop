import 'package:flutter/material.dart';

class ToastUtils {
  static void showToast(BuildContext context,String? text) {
    //消息弹出框  类似vue的$message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text ?? "加载成功"),
        width: 200,
        shape: RoundedRectangleBorder(
          //圆角边框
          borderRadius: BorderRadius.circular(10),
        ),
        duration: Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
