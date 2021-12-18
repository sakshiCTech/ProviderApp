import 'package:get/get.dart';

import 'your_services_logic.dart';

class YourServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => YourServicesLogic());
  }
}
