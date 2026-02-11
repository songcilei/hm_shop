import 'package:flutter/material.dart';

class ToastUtils {
  //阀门控制
  static bool showLoading = false;

  static void showToast(BuildContext context,String? text) {

    if(showLoading){
      return;
    }
    ToastUtils.showLoading = true;
    Future.delayed(Duration(seconds: 3),(){// 异步 3秒后执行
      ToastUtils.showLoading=false;
    });
    //消息弹出框  类似vue的$message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text ?? "加载成功"),
        width: 200,
        shape: RoundedRectangleBorder(
          //圆角边框
          borderRadius: BorderRadius.circular(10),
        ),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
