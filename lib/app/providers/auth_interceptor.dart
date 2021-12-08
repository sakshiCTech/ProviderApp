import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import '../services/auth_service.dart';

class AuthInterceptor extends InterceptorsWrapper {
  final authService = Get.find<AuthService>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (authService.isAuth) {
      options.headers["Authorization"] = "Bearer ${authService.apiToken}";
    }
    return super.onRequest(options, handler);
  }
}
