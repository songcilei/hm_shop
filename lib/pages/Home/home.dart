import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // 首页滚动列表
  List<Widget> _getScrollChildern(){
    return [
      SliverToBoxAdapter(child: HmSlider(),),//轮播图组件
      SliverToBoxAdapter(child: SizedBox(height: 10.0,),),//间距组件
      //SliverGrid和SliverList只能纵向排列 不能横向排列
      SliverToBoxAdapter(child: HmCategory()),//分类组件
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
  Widget build(BuildContext context) {
    return Container(
       child: CustomScrollView(
         slivers: _getScrollChildern(),
       ),
    );
  }
}