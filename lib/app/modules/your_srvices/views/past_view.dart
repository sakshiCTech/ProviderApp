import 'package:get/get.dart';
import '../../../global_widgets/circular_loading_widget.dart';
import 'service_item.dart';
import '../your_services_logic.dart';
import 'package:flutter/material.dart';

class PastView extends GetView<YourServicesLogic> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? CircularLoadingWidget(
              height: 300,
            )
          : ListView.builder(
              itemBuilder: (context, index) => ServiceItem(
                historyModel: controller.historyList[index],
              ),
              itemCount: controller.historyList.length,
            ),
    );
  }
}
