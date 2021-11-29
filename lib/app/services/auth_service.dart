import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user_model.dart';
import '../repositories/user_repository.dart';
import 'settings_service.dart';

class AuthService extends GetxService {
  final user = User().obs;
  GetStorage _box;

  UserRepository _usersRepo;

  AuthService() {
    _usersRepo = new UserRepository();
    _box = new GetStorage();
  }

  Future<AuthService> init() async {
    user.listen((User _user) {
      // if (Get.isRegistered<SettingsService>()) {
      //   Get.find<SettingsService>().address.value.userId = _user.id;
      // }
      Get.log('user : $_user');
      if (_user != null) {
        _box.write('current_user', _user.toJson());
      }
    });
    if (_box.hasData('current_user')) {
      user.value = User.fromJson(await _box.read('current_user'));
    }
    return this;
  }

  Future removeCurrentUser() async {
    user.value = new User();
    await _usersRepo.signOut();
    await _box.remove('current_user');
  }

  bool get isAuth => user.value != null;

  String get apiToken => isAuth ? user.value.accessToken : '';
}
