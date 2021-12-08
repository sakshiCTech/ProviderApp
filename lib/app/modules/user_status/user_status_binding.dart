import 'package:get/get.dart';

import 'user_status_logic.dart';

class UserStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserStatusLogic());
  }
}
