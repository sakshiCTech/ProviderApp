import 'package:get/get.dart';

import 'document_upload_logic.dart';

class DocumentUploadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DocumentUploadLogic());
  }
}
