
import 'package:demo1/network/http_request.dart';
import 'package:dio/dio.dart';

/// 参数拦截器
class ParamsTokenInterceptor extends Interceptor{

  final String token;
  ParamsTokenInterceptor(this.token);

  @override
  Future onRequest(RequestOptions options) {
    options.headers[HttpRequest.PARAMS_HEADER_KEY] = token;
    return super.onRequest(options);
  }
}