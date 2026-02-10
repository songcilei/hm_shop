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