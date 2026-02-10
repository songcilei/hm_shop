import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // 轮播图数据
  List<BannerItem> _bannerList = 
  [
    // BannerItem(id: '1', imgUrl: 'https://env-00jxufh206k1.normal.cloudstatic.cn/Test/1.png'),
    // BannerItem(id: '2', imgUrl: 'https://env-00jxufh206k1.normal.cloudstatic.cn/Test/2.png'),
    // BannerItem(id: '3', imgUrl: 'https://env-00jxufh206k1.normal.cloudstatic.cn/Test/3.png'),
  ];
  // 分类列表
  List<CategoryItem> _categoryList = [];
  // 首页滚动列表
  List<Widget> _getScrollChildern(){
    return [
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)),//轮播图组件
      SliverToBoxAdapter(child: SizedBox(height: 10.0,),),//间距组件
      //SliverGrid和SliverList只能纵向排列 不能横向排列
      SliverToBoxAdapter(child: HmCategory(categoryList: _categoryList)),//分类组件
      SliverToBoxAdapter(child: SizedBox(height: 10.0,),),//间距组件
      SliverToBoxAdapter(child: HmSuggestion()),//推荐组件
      SliverToBoxAdapter(child: SizedBox(height: 10.0,),),//间距组件
      SliverToBoxAdapter(child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),//top和bottom间距为10
        child: Flex
          (
            direction: Axis.horizontal,children: 
            [
              Expanded(child: HmHot()),
              SizedBox(width: 10.0),
              Expanded(child: HmHot())
            ]
          ),//更多组件
        )
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10.0,),),//间距组件
      HmMoreList()
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBannderList();
    _getCategoryList();
  }

  // 获取轮播图列表
  void _getBannderList()async{
    _bannerList =  await getBannerListAPI();
    setState(() {
    });
  }
  // 获取分类列表
  void _getCategoryList()async{
    _categoryList =  await getCategoryListAPI();
    setState(() {
    });
  }



  @override
  Widget build(BuildContext context) {
    return Container(
       child: CustomScrollView(
         slivers: _getScrollChildern(),
       ),
    );
  }
}