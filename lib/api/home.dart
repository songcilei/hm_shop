//封装一个api 目的是返回业务侧要的数据结构
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<List<BannerItem>> getBannerListAPI()async{
  List aa =((await dioRequest.get(HttpConstants.BANNER_LIST, null)) as List);
  print(aa.map((item)=>item['id']));

  final  tt = ((await dioRequest.get(HttpConstants.BANNER_LIST, null)) as List).map((item){
    return BannerItem.fromJson(item as Map<String,dynamic>);
  }).toList();
  return tt;
}

//获取分类列表
Future<List<CategoryItem>> getCategoryListAPI()async{
  List aa =((await dioRequest.get(HttpConstants.CATEGORY_LIST, null)) as List);
  print(aa.map((item)=>item['id']));

  final  tt = ((await dioRequest.get(HttpConstants.CATEGORY_LIST, null)) as List).map((item){
    return CategoryItem.fromJson(item as Map<String,dynamic>);
  }).toList();
  return tt;
}

//获取特惠推荐列表
Future<SpecialOfferResult> getSpecialOfferListAPI()async{
  final  tt = await dioRequest.get(HttpConstants.PRODUCT_LIST, null);
  return SpecialOfferResult.fromJson(tt as Map<String,dynamic>);
}

// 热榜推荐
Future<SpecialOfferResult> getInVogueListAPI() async {
  // 返回请求
  return SpecialOfferResult.fromJson(
    await dioRequest.get(HttpConstants.IN_VOGUE_LIST,null),
  );
}

// 一站式推荐
Future<SpecialOfferResult> getOneStopListAPI() async {
  // 返回请求
  return SpecialOfferResult.fromJson(
    await dioRequest.get(HttpConstants.ONE_STOP_LIST,null),
  );
}

// 推荐列表
Future<List<GoodDetailItem>> getRecommendListAPI(
  Map<String, dynamic> params,
) async {
  // 返回请求
  return ((await dioRequest.get(HttpConstants.RECOMMEND_LIST,params))
          as List)
      .map((item) {
        return GoodDetailItem.formJSON(item as Map<String, dynamic>);
      })
      .toList();
}
