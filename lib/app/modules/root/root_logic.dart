import 'package:get/get.dart';
import '../../services/auth_service.dart';

class RootLogic extends GetxController {
  final authService = Get.find<AuthService>();
  String name;

  RootLogic() {
    name = 'You are in the root screen: ${authService.user.value.firstName}';
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
