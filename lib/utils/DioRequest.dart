
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
        // handle.next(error);
        handle.reject(
          DioException(
            requestOptions: error.requestOptions,
            message: error.response?.data["msg"]??"")
          );
      },
    ));
  }
  Future<dynamic> get(String url,Map<String,dynamic>? params){
    return _handleResponse(_dio.get(url,queryParameters: params));
  }


  //定义post接口
  Future<dynamic> post(String url,{Map<String,dynamic>? data}){
    return _handleResponse(_dio.post(url,data: data));
  }


  //dio 请求工具 发出请求  返回的数据 保存在 Response<dynamic> 中
  //使用时 可以通过 response.data 来获取数据
  //所以需要把所有的接口的data解构出来 并判断业务状态码是不是等于1
  //进一步处理返回结果
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task)async{
    try{
      Response<dynamic> res = await task;//result
      final data = res.data as Map<String,dynamic>;//result data
      if(data['code'] == GlobalConstants.SUCCESS_CODE){
        return data['result']; //成功则返回结果
        
      }
      throw DioException(//如果有问题 则抛出 Dio异常
        requestOptions: res.requestOptions,
        message: data["msg"]??""
      );
    }catch(e){
      // throw Exception(e);//抛出异常  这个会覆盖dio 异常 所以取消掉
      rethrow;//不改变原来抛出的异常的 类型
    }
  }
}

//单例对象
final dioRequest = Diorequest();


