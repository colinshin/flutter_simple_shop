import 'package:demo1/network/aes_util.dart';
import 'package:demo1/network/interceptor/params_token_interceptor.dart';
import 'package:demo1/network/request_util.dart';
import 'package:demo1/network/result_model.dart';
import 'package:dio/dio.dart';

import 'dio_errors.dart';

/// 典典的小卖部
/// 网络请求工具封装
/// v2
/// 2020-12-1 14:11:37
///
class HttpRequest {
  static Dio dio;

  static const String HOST = "http://192.168.43.44:8089/tkapi";
  // static const String HOST = "http://127.0.0.1:8089/tkapi";

  /// 网络请求超时时间 10秒
  /// 注意超过十秒钟服务器可能不会 返回正确数据!
  /// timeToken 如果超过十秒钟系统认定此次请求非法操作
  /// 返回示例:
  /// {
  ///     "state": 500,
  ///     "message": "非法操作:请求超时",
  ///     "data": null
  /// }
  static const int TIMEOUT = 10000;

  /// get 请求
  static const String GET = "get";

  /// post 请求
  static const String POST = "post";

  /// 不能改
  /// 固定值
  /// 服务器如果查不到这个header值
  /// 将返回非法操作提示
  /// 返回示例
  /// (同上) 非法操作,缺少参数
  static const String PARAMS_HEADER_KEY = "params_token";

  /// 参数key
  /// 值是aes字符串
  static const String DATA_KEY = "data";

  /// 请求成功code
  static const int SUCCESS_CODE = 200;

  /// 发起一个网络请求
  /// [url] 接口地址. (require)
  /// [data] 参数. 列子:{"id":"10553823"}
  /// [method] 请求方法.
  static Future<String> req(String url, {Map<String, String> data, String method,ServerError onError}) async {
    /// 请求前的准备
    method = method ?? GET;
    onError = onError ?? serverErrorDefaultHandle;
    Dio dio = createInstance();
    data = data ?? Map<String, String>();
    ServerEncryptionData serverEncryptionData = RequestUtil.handleParams(data);
    dio.interceptors.add(ParamsTokenInterceptor(serverEncryptionData.paramsToken));

    /// 准备完成

    /// 开始请求数据
    Response response;

    try {
      switch (method) {
        case GET:
          print(url);
          response = await dio.request(url, queryParameters: {DATA_KEY: serverEncryptionData.data}, options: Options(method: GET));
          break;
        case POST:
          response = await dio.request(url, data: {DATA_KEY: serverEncryptionData.data}, options: Options(method: POST));
          break;
        default:
          break;
      }
      if (response != null) {
        Result result = Result.fromJson(response.data);
        if(result.state==SUCCESS_CODE){
          String data = AesUtil.aesDecrypt(result.data);
          return data;
        }else{
          onError(result.state,result.message,url);
        }
      }
    } on DioError catch (e) {
      ErrorEntity en = new ErrorEntity().createErrorEntity(e);
      print("dio请求出错:[${en.code}],错误信息:${en.message},接口:$url");
      return "";
    }
    return "";
  }

  /// 创建dio实例
  static Dio createInstance() {
    if (dio == null) {
      BaseOptions options = BaseOptions(baseUrl:HOST, connectTimeout: TIMEOUT);
      dio = Dio(options);
    }
    return dio;
  }
}

/// 定义服务器错误处理函数HOST
typedef ServerError = void Function(int code,String message,String api);

/// 默认错误处理
/// 这里只打印了一下服务器返回的报错信息
void serverErrorDefaultHandle(int code,String message,String api){
  print("服务器自定义错误.code=$code,message=$message,url=$api");
}
