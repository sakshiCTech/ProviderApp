import 'package:get/get.dart';
import '../models/history_model.dart';
import '../providers/laravel_provider.dart';

class YourServiceRepository {
  LaravelApiClient _apiClient;

  YourServiceRepository() {
    _apiClient = Get.find<LaravelApiClient>();
  }

  Future<List<HistoryModel>>getAllHistory(){
    return _apiClient.getAllHistory();
  }
}
