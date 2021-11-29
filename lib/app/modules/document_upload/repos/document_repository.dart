import 'package:get/get.dart';
import '../../../models/document_model.dart';
import '../../../providers/laravel_provider.dart';

class DocumentRepository {
  LaravelApiClient _laravelApiClient;

  DocumentRepository() {
    this._laravelApiClient = Get.find<LaravelApiClient>();
  }

  Future<List<DocumentModel>> getDocuments() {
    return _laravelApiClient.getDocuments();
  }

  Future<List<DocumentModel>> uploadDocuments(Map<String, dynamic> data) {
    return _laravelApiClient.uploadProviderDocuments(data);
  }
}
