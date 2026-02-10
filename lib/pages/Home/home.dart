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
  // 特惠推荐列表
  SpecialOfferResult? _specialOfferList = SpecialOfferResult(
    id: '',
    title: '',
    subTypes: [],
  );

    // 热榜推荐
  SpecialOfferResult _inVogueResult = SpecialOfferResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 一站式推荐
  SpecialOfferResult _oneStopResult = SpecialOfferResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 首页滚动列表
  List<Widget> _getScrollChildern(){
    return [
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)),//轮播图组件
      SliverToBoxAdapter(child: SizedBox(height: 10.0,),),//间距组件
      //SliverGrid和SliverList只能纵向排列 不能横向排列
      SliverToBoxAdapter(child: HmCategory(categoryList: _categoryList)),//分类组件
      SliverToBoxAdapter(child: SizedBox(height: 10.0,),),//间距组件
      SliverToBoxAdapter(child: HmSuggestion(specialOfferList:_specialOfferList!)),//推荐组件
      SliverToBoxAdapter(child: SizedBox(height: 10.0,),),//间距组件
      SliverToBoxAdapter(child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),//top和bottom间距为10
        child: Flex
          (
            direction: Axis.horizontal,children: 
            [
              Expanded(
                child: HmHot(result: _inVogueResult, type: "hot"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HmHot(result: _oneStopResult, type: "step"),
              ),
            ]
          ),//更多组件
        )
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10.0)),//间距组件
      HmMoreList(recommendList: _recommendList), // 无限滚动列表
    ];
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBannderList();
    _getCategoryList();
    _getSpecialOfferList();
    _getInVogueList();
    _getOneStopList();
    _getRecommendList();
    _registerEvent();
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
  // 获取特惠推荐列表
  void _getSpecialOfferList()async{
    _specialOfferList =  await getSpecialOfferListAPI();
    setState(() {
    });
  }



// 获取热榜推荐列表
  void _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
    setState(() {});
  }

  // 获取一站式推荐列表
  void _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
    setState(() {});
  }

// 推荐列表
  List<GoodDetailItem> _recommendList = [];


  //页码 
  int _page = 1;
  //当前是不是正在加载
  bool _isLoading = false;
  //是否还有下一页
  bool _hasMore = true;

  // 获取推荐列表
  void _getRecommendList() async {
    //判断是否正在加载中 或者 是否还有下一页
    if(_isLoading || !_hasMore){
      return;
    }
    _isLoading = true;
    int requestLimit = _page*8;
    _recommendList = await getRecommendListAPI({"limit": requestLimit});
    _isLoading = false;

    setState(() {});
    //判断是否还有下一页
    if(_recommendList.length < requestLimit){
      _hasMore = false;
      return;
    }
    print("page++ $_page");
    _page++;
  }

  //监听滚动到底部的事件
  void _registerEvent(){
    _controller.addListener(() {
      //_controller.position.pixels  当前滚动的距离
      //_controller.position.maxScrollExtent  最大滚动距离
      if(_controller.position.pixels >= _controller.position.maxScrollExtent-50){
        print("滚动到底部了");
        _getRecommendList();
      }
      // print("滚动了${_controller.position.pixels}");
    });
  }

  // 滚动控制器
  ScrollController _controller = ScrollController();



  @override
  Widget build(BuildContext context) {
    return Container(
       child: CustomScrollView(
          controller: _controller,
          // 滚动列表
          slivers: _getScrollChildern(),
       ),
    );
  }
}