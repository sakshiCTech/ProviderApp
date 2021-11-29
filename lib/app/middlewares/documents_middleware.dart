import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../services/auth_service.dart';

class DocumentsMiddleware extends GetMiddleware {
  // @override
  // RouteSettings redirect(String route) {
  //   return null;
  // }

  @override
  Widget onPageBuilt(Widget page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.
      final authService = Get.find<AuthService>();
      if (authService.user.value.status == 'document' ||
          authService.user.value.status == 'onboarding') {
        Get.toNamed(Routes.UPLOAD_DOCUMENTS);
      }
    });

    return page;
  }
}
