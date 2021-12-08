import 'package:dio/dio.dart';

class RedirectionInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var _op = options;
    if (options.method == "POST") {
      _op = options.copyWith(
          headers: {"Accept": "application/json"},
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          });
    }
    return super.onRequest(_op, handler);
  }
}
