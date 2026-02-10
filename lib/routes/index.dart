import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Login/index.dart';
import 'package:hm_shop/pages/Main/index.dart';

Widget getRootWidget(){
    return MaterialApp(
      // 路由配置
      initialRoute: '/',
      routes: getRootRoutes(),

    );
}


Map<String, Widget Function(BuildContext)> getRootRoutes(){
  return {
    '/': (context) => MainPage(),//主页
    '/login':(context)=>LoginPage(),//登录页
  };
}
