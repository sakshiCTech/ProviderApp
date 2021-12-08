import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/app/routes/app_routes.dart';
import 'package:home_services_provider/common/console.dart';
import '../../../common/ui.dart';
import '../../../common/image_picker_dialog.dart';
import '../../models/document_model.dart';
import 'repos/document_repository.dart';
import 'package:intl/intl.dart';

class DocumentUploadLogic extends GetxController {
  GlobalKey<FormState> documentFormKey;
  final loading = true.obs;
  final documents = <DocumentModel>[].obs;
  final fieldControllers = <TextEditingController>[];
  final filePaths = <int, String>{};
  final f = DateFormat('dd-MM-yyyy');
  DocumentRepository _documentRepository;

  var expiryDates = <Rx<String>>[];

  DocumentUploadLogic() {
    _documentRepository = DocumentRepository();
    getDocuments();
  }

  Future getDocuments() async {
    loading.value = true;
    try {
      documents.value = await _documentRepository.getDocuments();
      fieldControllers.clear();
      for (DocumentModel document in documents) {
        if (document.providerdocuments != null) {
          fieldControllers.add(TextEditingController(
              text: document.providerdocuments.url.split('/').last));
        } else {
          fieldControllers.add(TextEditingController());
        }
        expiryDates.add('Expiry Date'.obs);
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      loading.value = false;
    }
  }

  Future selectDocument(int index) async {
    var filePath = await ImagePickerDialog.show();
    if (filePath != null) {
      fieldControllers[index].text = filePath.split("/").last;
      filePaths[index + 1] = filePath;
    }
  }

  Future uploadDocuments() async {
    loading.value = true;
    try {
      var data = <String, dynamic>{};
      filePaths.forEach((key, value) {
        data['document[$key]'] = dio.MultipartFile.fromFileSync(value);
        data['id[$key]'] = key;
        data['expiry_date[$key]'] = expiryDates[key - 1].value;
      });
      documents.value = await _documentRepository.uploadDocuments(data);
      for (int i = 0; i < documents.length; i++) {
        if (documents[i].providerdocuments != null) {
          fieldControllers[i].text =
              documents[i].providerdocuments.url.split('/').last;
        }
      }
      loading.value = false;
      Get.showSnackbar(Ui.SuccessSnackBar(message: 'Upload Success full'));
      Future.delayed(Duration(seconds: 2), () {
        Get.toNamed(Routes.ROOT);
      });
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      loading.value = false;
    }
  }
}
