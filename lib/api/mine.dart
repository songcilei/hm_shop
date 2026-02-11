import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

//page:1 pageSize 10

Future<GoodsDetailsItems> getGuessListAPI(Map<String,dynamic> params)async{
  return GoodsDetailsItems.fromJson(await dioRequest.get(HttpConstants.GUESS_LIST,params));
}