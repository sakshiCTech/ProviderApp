import 'package:get/get.dart';
import '../root/controllers/root_controller.dart';

import 'user_status_logic.dart';

class UserStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserStatusLogic());
    Get.lazyPut(() => RootController());
  }
}
