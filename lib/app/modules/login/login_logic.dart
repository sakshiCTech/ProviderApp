import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/ui.dart';
import '../../models/user_model.dart';
import '../../repositories/user_repository.dart';
import '../../routes/app_routes.dart';
import '../../services/auth_service.dart';
import '../../services/firebase_messaging_service.dart';

class LoginLogic extends GetxController {
  var loginFormKey = new GlobalKey<FormState>();
  var loading = false.obs;
  var hidePassword = true.obs;

  String email;
  String password;
  UserRepository _userRepository;

  final Rx<User> currentUser = Get.find<AuthService>().user;

  LoginLogic() {
    _userRepository = UserRepository();
  }

  void login() async {
    Get.focusScope.unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      loading.value = true;
      try {
        var data = {
          "email": email,
          "password": password,
          "device_token":
              await Get.find<FireBaseMessagingService>().getDeviceToken(),
          "device_type": "android",
          "device_id": "device_id"
        };
        currentUser.value = await _userRepository.login(data);
        await _userRepository.signInWithEmailAndPassword(email, password);
        // await Get.find<RootController>().changePage(0);
        Get.offAllNamed(Routes.ROOT);
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {
        loading.value = false;
      }
    }
  }
}
