import 'package:get/get.dart';

import '../models/user_model.dart';
import '../providers/firebase_provider.dart';
import '../providers/laravel_provider.dart';
import '../services/auth_service.dart';
import 'package:dio/dio.dart' as dio;

class UserRepository {
  LaravelApiClient _laravelApiClient;
  FirebaseProvider _firebaseProvider;

  UserRepository() {}

  Future<User> login(Map<String, dynamic> data) {
    _laravelApiClient = Get.find<LaravelApiClient>();
    return _laravelApiClient.login(data);
  }

  Future<User> get(User user) {
    _laravelApiClient = Get.find<LaravelApiClient>();
    return _laravelApiClient.getUser(user);
  }

  Future<User> update(User user) {
    _laravelApiClient = Get.find<LaravelApiClient>();
    return _laravelApiClient.updateUser(user);
  }

  Future<bool> sendResetLinkEmail(Map<String, dynamic> data) {
    _laravelApiClient = Get.find<LaravelApiClient>();
    return _laravelApiClient.sendResetLinkEmail(data);
  }

  Future<User> getCurrentUser() {
    return this.get(Get.find<AuthService>().user.value);
  }

  Future<User> register(Map<String, dynamic> data) {
    _laravelApiClient = Get.find<LaravelApiClient>();
    return _laravelApiClient.register(data);
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    _firebaseProvider = Get.find<FirebaseProvider>();
    return _firebaseProvider.signInWithEmailAndPassword(email, password);
  }

  Future<bool> signUpWithEmailAndPassword(String email, String password) async {
    _firebaseProvider = Get.find<FirebaseProvider>();
    return _firebaseProvider.signUpWithEmailAndPassword(email, password);
  }

  Future<void> verifyPhone(String verId, String smsCode) async {
    _firebaseProvider = Get.find<FirebaseProvider>();
    return _firebaseProvider.verifyPhone(verId, smsCode);
  }

  Future<void> sendCodeToPhone(String phone, RxString verId) async {
    _firebaseProvider = Get.find<FirebaseProvider>();
    return _firebaseProvider.sendCodeToPhone(phone, verId);
  }

  Future signOut() async {
    _firebaseProvider = Get.find<FirebaseProvider>();
    return await _firebaseProvider.signOut();
  }
}
