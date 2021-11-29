import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'repos/document_repository.dart';
import '../../providers/laravel_provider.dart';
import '../../routes/app_routes.dart';
import '../../services/auth_service.dart';
import '../../../common/console.dart';
import '../../../common/image_picker_dialog.dart';
import '../../models/document_model.dart';
import 'package:dio/dio.dart' as dio;

class DocumentUploadLogic extends GetxController {
  GlobalKey<FormState> documentFormKey;
  final loading = true.obs;
  final documents = <DocumentModel>[].obs;
  final fieldControllers = <TextEditingController>[];
  final filePaths = <int, String>{};

  DocumentRepository _documentRepository;

  DocumentController() {
    _documentRepository = DocumentRepository();
  }

  Future getDocuments() async {
    loading.value = true;
    documents.value = await _documentRepository.getDocuments();
    fieldControllers.clear();
    for (DocumentModel document in documents) {
      if (document.providerdocuments != null) {
        fieldControllers.add(TextEditingController(
            text: document.providerdocuments.url.split('/').last));
      } else {
        fieldControllers.add(TextEditingController());
      }
    }
    loading.value = false;
  }

  Future setDocuments() async {}

  Future selectDocument(int index) async {
    var filePath = await ImagePickerDialog.show();
    if (filePath != null) {
      fieldControllers[index].text = filePath.split("/").last;
      filePaths[index + 1] = filePath;
      Console.log(filePath);
    }
  }

  Future uploadDocuments() async {
    loading.value = true;
    var data = <String, dynamic>{};
    filePaths.forEach((key, value) {
      data['document[$key]'] = dio.MultipartFile.fromFileSync(value);
      data['id[$key]'] = key;
    });
    Console.log(data);
    await _documentRepository.uploadDocuments(data);
    loading.value = false;
    await Get.find<AuthService>().removeCurrentUser();
    Get.toNamed(Routes.LOGIN);
  }
}
