import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/app/global_widgets/circular_loading_widget.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../../common/ui.dart';

import 'wallet_logic.dart';

class WalletPage extends GetView<WalletLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Wallet".tr,
          style: context.textTheme.headline6,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        actions: [
          MaterialButton(
            elevation: 0,
            onPressed: () {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            // color: Get.theme.colorScheme.secondary,
            color:Color(0xff5B7BB6),
            child: Text("Withdrawal".tr,
                style: Get.textTheme.bodyText2
                    .merge(TextStyle(color: Get.theme.primaryColor))),
          ).paddingSymmetric(horizontal: 20, vertical: 8),
        ],
      ),
      body: Obx(
        () => controller.loading.value
            ? CircularLoadingWidget(height: 300)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/img/wallet.svg',
                    width: 100,
                    height: 100,
                  ).paddingSymmetric(vertical: 20),
                  Text('Your wallet amount is'),
                  Text(
                    controller.walletModel.value.walletBalance.toString(),
                    style: Get.textTheme.headline1,
                  ).paddingSymmetric(vertical: 10),
                  Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: Ui.getBoxDecoration(),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Enter the amount').paddingOnly(bottom: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade100,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: TextField(
                                        decoration: InputDecoration(
                                          hintText: '100',
                                          border: InputBorder.none,
                                        ),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ]).paddingSymmetric(horizontal: 10)),
                                ClipRRect(
                                  borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(8)),
                                  child: Material(
                                    // color: Get.theme.colorScheme.secondary,
                                    color:Color(0xff5B7BB6),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        child: Text("Add Amount".tr,
                                                style: Get.textTheme.bodyText2
                                                    .merge(TextStyle(
                                                        color: Get.theme
                                                            .primaryColor)))
                                            .paddingSymmetric(
                                                horizontal: 10, vertical: 15),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  )
                ],
              ),
      ),
    );
  }
}
