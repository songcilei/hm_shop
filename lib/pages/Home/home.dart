import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/utils/ToastUtils.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // 轮播图数据
  List<BannerItem> _bannerList = [
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
  List<Widget> _getScrollChildern() {
    return [
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)), //轮播图组件
      SliverToBoxAdapter(child: SizedBox(height: 10.0)), //间距组件
      //SliverGrid和SliverList只能纵向排列 不能横向排列
      SliverToBoxAdapter(child: HmCategory(categoryList: _categoryList)), //分类组件
      SliverToBoxAdapter(child: SizedBox(height: 10.0)), //间距组件
      SliverToBoxAdapter(
        child: HmSuggestion(specialOfferList: _specialOfferList!),
      ), //推荐组件
      SliverToBoxAdapter(child: SizedBox(height: 10.0)), //间距组件
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10), //top和bottom间距为10
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: HmHot(result: _inVogueResult, type: "hot"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HmHot(result: _oneStopResult, type: "step"),
              ),
            ],
          ), //更多组件
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10.0)), //间距组件
      HmMoreList(recommendList: _recommendList), // 无限滚动列表
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _getBannderList();
    // _getCategoryList();
    // _getSpecialOfferList();
    // _getInVogueList();
    // _getOneStopList();
    // _getRecommendList();
    Future.microtask(() {
      //因为执行的时机需要在构建完组件之后 所以需要用微任务在build完之后调用
      _key.currentState?.show(); //通过key 去操控RefreshIndicator组件
      _topPadding = 100; //这个是为了动画
    });
    _registerEvent();
  }
  //initState > build > 下拉刷新 > 才可以操作
  //Furture.micoTask 微任务

  // 获取轮播图列表
  Future<void> _getBannderList() async {
    _bannerList = await getBannerListAPI();
  }

  // 获取分类列表
  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
  }

  // 获取特惠推荐列表
  Future<void> _getSpecialOfferList() async {
    _specialOfferList = await getSpecialOfferListAPI();
  }

  // 获取热榜推荐列表
  Future<void> _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
  }

  // 获取一站式推荐列表
  Future<void> _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
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
  Future<void> _getRecommendList() async {
    //判断是否正在加载中 或者 是否还有下一页
    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true;
    int requestLimit = _page * 8;
    _recommendList = await getRecommendListAPI({"limit": requestLimit});
    _isLoading = false;

    setState(() {});
    //判断是否还有下一页
    if (_recommendList.length < requestLimit) {
      _hasMore = false;
      return;
    }
    print("page++ $_page");
    _page++;
  }

  //监听滚动到底部的事件  触底更新
  void _registerEvent() {
    _controller.addListener(() {
      //添加侦听器
      //_controller.position.pixels  当前滚动的距离
      //_controller.position.maxScrollExtent  最大滚动距离
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 50) {
        print("滚动到底部了");
        _getRecommendList();
      }
      // print("滚动了${_controller.position.pixels}");
    });
  }

  // 滚动控制器
  final ScrollController _controller = ScrollController();

  // 下拉刷新
  Future<void> _onRefresh() async {
    _page = 1;
    _hasMore = true;
    _isLoading = false;
    await _getBannderList();
    await _getCategoryList();
    await _getSpecialOfferList();
    await _getInVogueList();
    await _getOneStopList();
    await _getRecommendList();
    setState(() {});
    ToastUtils.showToast(context, "下拉刷新成功");
    _topPadding = 0;
    // print("下拉刷新成功");
  }

  //GlobalKey 时一个方法 可以创建一个key  绑定到widget 部件里 可以操作Widget 部件
  final GlobalKey<RefreshIndicatorState> _key =
      GlobalKey<RefreshIndicatorState>();

  double _topPadding = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      //下拉刷新组件
      key: _key,
      onRefresh: _onRefresh, //函数绑定到事件上 没有小括号
      child: AnimatedContainer(
        //很无聊的效果 每次刷新场景 会自动下拉并回弹
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.only(top: _topPadding),
        child: Container(
          child: CustomScrollView(
            controller: _controller,
            // 滚动列表
            slivers: _getScrollChildern(),
          ),
        ),
      ),
    );
  }
}
