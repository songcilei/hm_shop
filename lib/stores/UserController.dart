import 'package:get/get.dart';
import 'package:hm_shop/viewmodels/home.dart';
//需要共享的对象 要有一些共享的属性 属性需要响应式更新
class UserController extends GetxController{
  var user = UserInfo.fromJSON({}).obs;//.obs结尾意味着 user对象被监听了
  //想要取值的话 需要user.value 取值
  updateUserInfo(UserInfo newUser){  //这个感觉类似 vue的ref(UserInfo)
    user.value = newUser;
  }
}