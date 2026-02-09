import 'package:dio/dio.dart';
import 'package:hm_shop/constants/index.dart';



//基于Dio进行二次的封装
class Diorequest {
  final _dio = Dio();
  Diorequest(){
    _dio.options//连续赋值
    ..baseUrl = GlobalConstants.BASE_URL
    ..connectTimeout = Duration(seconds: GlobalConstants.TIMEOUT)
    ..sendTimeout = Duration(seconds: GlobalConstants.TIMEOUT)
    ..receiveTimeout = Duration(seconds: GlobalConstants.TIMEOUT);

    //添加拦截器
    _addInterceptor();
  }

  //添加拦截器
  void _addInterceptor(){
    _dio.interceptors.add(InterceptorsWrapper(
      //请求拦截器
      onRequest: (request,handle){
        handle.next(request);
      },
      //响应拦截器
      onResponse: (response,handle){
        //http 状态码  200 300
        //对响应数据进行处理
        if(response.statusCode! >= 200 && response.statusCode! < 300){
          //对响应数据进行处理
          handle.next(response);
          return ;
        }
        handle.reject(DioException(requestOptions: response.requestOptions));//抛出异常
      },
      //错误拦截器
      onError: (error,handle){
        //对错误进行处理
        handle.next(error);
      },
    ));
  }
  Future<dynamic> get(String url,Map<String,dynamic>? params){
    return _handleResponse(_dio.get(url,queryParameters: params));
  }


  //dio 请求工具 发出请求  返回的数据 保存在 Response<dynamic> 中
  //使用时 可以通过 response.data 来获取数据
  //所以需要把所有的接口的data解构出来 并判断业务状态码是不是等于1
  //进一步处理返回结果
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task)async{
    try{
      Response<dynamic> res = await task;
      final data = res.data as Map<String,dynamic>;
      if(data['code'] != GlobalConstants.SUCCESS_CODE){
        throw DioException(requestOptions: res.requestOptions);//抛出网路异常
      }
      return data['result']; //成功则返回结果
    }catch(e){
      throw Exception(e);//抛出异常
    }
  }
}

//单例对象
final dioRequest = Diorequest();


