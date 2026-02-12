//登录接口API
import 'dart:io';

import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<UserInfo> loginAPI(Map<String, dynamic> data) async {
  return UserInfo.fromJSON(
    await dioRequest.post(HttpConstants.LOGIN, data: data),
  );
}

Future<UserInfo> getUserInfoAPI() async {
  return UserInfo.fromJSON(
    await dioRequest.get(HttpConstants.USER_PROFILE, null),
  );
}
