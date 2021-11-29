import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/ui.dart';
import '../../repositories/user_repository.dart';
import '../../routes/app_routes.dart';

class ForgotPasswordLogic extends GetxController {
  var forgotPasswordFormKey = GlobalKey<FormState>();

  var loading = false.obs;
  UserRepository _userRepository;
  String email;

  ForgotPasswordLogic() {
    _userRepository = UserRepository();
  }

  void sendResetLink() async {
    Get.focusScope.unfocus();
    if (forgotPasswordFormKey.currentState.validate()) {
      forgotPasswordFormKey.currentState.save();
      loading.value = true;
      try {
        var data = {'email': email};
        await _userRepository.sendResetLinkEmail(data);
        loading.value = false;
        Get.showSnackbar(Ui.SuccessSnackBar(
            message:
                "The Password reset link has been sent to your email: ".tr +
                    email));
        Timer(Duration(seconds: 5), () {
          Get.offAndToNamed(Routes.LOGIN);
        });
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {
        loading.value = false;
      }
    }
  }
}
