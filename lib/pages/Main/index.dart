import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/api/user.dart';
import 'package:hm_shop/pages/Cart/cart.dart';
import 'package:hm_shop/pages/Category/category.dart';
import 'package:hm_shop/pages/Home/home.dart';
import 'package:hm_shop/pages/Mine/mine.dart';
import 'package:hm_shop/stores/TokenManager.dart';
import 'package:hm_shop/stores/UserController.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //Tab 栏目数据
  final List<Map<String, String>> _tabs = [
    {
      "title": "首页",
      "icon": "lib/assets/tab/ic_public_home_normal.png",
      "active_icon": "lib/assets/tab/ic_public_home_active.png",
    },
    {
      "title": "分类",
      "icon": "lib/assets/tab/ic_public_pro_normal.png",
      "active_icon": "lib/assets/tab/ic_public_pro_active.png",
    },
    {
      "title": "购物车",
      "icon": "lib/assets/tab/ic_public_cart_normal.png",
      "active_icon": "lib/assets/tab/ic_public_cart_active.png",
    },
    {
      "title": "我的",
      "icon": "lib/assets/tab/ic_public_my_normal.png",
      "active_icon": "lib/assets/tab/ic_public_my_active.png",
    },
  ];
  //Tab 栏目
  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(_tabs.length, (index) {
      return BottomNavigationBarItem(
        icon: Image.asset(_tabs[index]["icon"]!, width: 30, height: 30),
        activeIcon: Image.asset(
          _tabs[index]["active_icon"]!,
          width: 30,
          height: 30,
        ),
        label: _tabs[index]["title"]!,
      );
    });
  }

  //当前选中的index
  int _currentIndex = 0;

  List<Widget> _getChildren() {
    return [HomeView(), CategoryView(), CartView(), MineView()];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initUser();
  }

  final UserController _userController = Get.put(UserController());
  _initUser() async {
    await tokenManager.init();
    //获取token
    if (tokenManager.getToken().isNotEmpty) {
      //如果token有值就获取用户信息
      print("写入了getx");
      _userController.updateUserInfo(await getUserInfoAPI());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        //顶部导航栏
        appBar: AppBar(title: Text(_tabs[_currentIndex]["title"]!)),
        //页面内容
        body: SafeArea(
          //安全区域
          child: IndexedStack(
            //索引栈
            index: _currentIndex,
            children: _getChildren(),
          ),
        ),
        //底部导航栏
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true, //显示未选中的文本
          unselectedItemColor: Colors.grey, //未选中的颜色
          selectedItemColor: Colors.black, //选中的颜色
          onTap: (int index) {
            //当前点击的索引
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          items: _getTabBarWidget(),
        ),
      ),
    );
  }
}
