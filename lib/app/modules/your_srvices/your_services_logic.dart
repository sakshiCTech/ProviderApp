import 'package:get/get.dart';
import 'package:home_services_provider/app/repositories/your_service_repository.dart';
import '../../models/history_model.dart';

class YourServicesLogic extends GetxController {
  var historyList = <HistoryModel>[].obs;

  var isLoading = true.obs;
  YourServiceRepository _yourServiceRepository;

  YourServicesLogic() {
    _yourServiceRepository = YourServiceRepository();
    getAllHistory();
  }

  Future getAllHistory() async {
    isLoading.value = true;
    historyList.assignAll(await _yourServiceRepository.getAllHistory());
    isLoading.value = false;
  }
}
