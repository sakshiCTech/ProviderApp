import 'package:get/get.dart';
import 'package:home_services_provider/app/models/wallet_model.dart';
import '../models/history_model.dart';
import '../providers/laravel_provider.dart';

class WalletRepository {
  LaravelApiClient _apiClient;

  WalletRepository() {
    _apiClient = Get.find<LaravelApiClient>();
  }

  Future<WalletModel>getTransactions(){
    return _apiClient.getWalletTransactions();
  }
}
