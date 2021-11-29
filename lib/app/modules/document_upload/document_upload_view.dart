import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/auto_complete_text_field_widget.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../models/setting_model.dart';
import '../../services/settings_service.dart';
import 'document_upload_logic.dart';

class DocumentUploadPage extends GetView<DocumentUploadLogic> {
  final Setting _settings = Get.find<SettingsService>().setting.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Document Upload".tr,
          style: Get.textTheme.headline6
              .merge(TextStyle(color: context.theme.primaryColor)),
        ),
        centerTitle: true,
        backgroundColor: Get.theme.colorScheme.secondary,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Get.theme.primaryColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: Form(
        key: controller.documentFormKey,
        child: Obx(
          () => controller.loading.isTrue
              ? CircularLoadingWidget(height: double.infinity)
              : ListView.builder(
                  primary: true,
                  itemCount: controller.documents.length,
                  itemBuilder: (context, index) => AutoCompleteTextFieldWidget(
                      labelText: controller.documents[index].name.tr,
                      hintText: controller.documents[index].name.tr.tr,
                      // initialValue: controller.currentUser?.value?.email,
                      // onSaved: (input) =>
                      //     controller.currentUser.value.email = input,
                      controller: controller.fieldControllers[index],
                      validator: (input) => input.isEmpty
                          ? "Should be a valid id proof".tr
                          : null,
                      iconData: Icons.perm_identity_outlined,
                      isFirst: index == 0,
                      isLast: index == (controller.documents.length - 1),
                      onTap: () => controller.selectDocument(index)),
                ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: Get.width,
        child: BlockButtonWidget(
          onPressed: () {
            controller.uploadDocuments();
            //Get.offAllNamed(Routes.PHONE_VERIFICATION);
          },
          color: Get.theme.colorScheme.secondary,
          text: Text(
            "Proceed".tr,
            style: Get.textTheme.headline6
                .merge(TextStyle(color: Get.theme.primaryColor)),
          ),
        ).paddingOnly(top: 15, bottom: 20, right: 20, left: 20),
      ),
    );
  }
}
