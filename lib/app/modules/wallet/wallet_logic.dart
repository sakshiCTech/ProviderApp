import 'package:get/get.dart';
import 'package:home_services_provider/common/ui.dart';
import '../../../common/console.dart';
import '../../models/wallet_model.dart';
import '../../repositories/wallet_repository.dart';

class WalletLogic extends GetxController {
  var loading = true.obs;
  var walletModel = WalletModel().obs;

  WalletRepository _walletRepository;

  WalletLogic() {
    _walletRepository = WalletRepository();
    getWalletTransactions();
  }

  Future getWalletTransactions() async {
    loading.value = true;
    try {
      walletModel.value = await _walletRepository.getTransactions();
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      loading.value = false;
    }
  }
}
