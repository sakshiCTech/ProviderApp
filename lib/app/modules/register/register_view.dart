import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/app/global_widgets/field_container.dart';
import 'package:home_services_provider/app/routes/app_routes.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../../models/setting_model.dart';
import '../../services/settings_service.dart';
import '../../../common/helper.dart';
import '../../../common/ui.dart';

import 'register_logic.dart';

class RegisterPage extends GetView<RegisterLogic> {
  final Setting _settings = Get.find<SettingsService>().setting.value;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Register".tr,
            style: Get.textTheme.headline6
                .merge(TextStyle(color: context.theme.primaryColor)),
          ),
          centerTitle: true,
          // backgroundColor: Get.theme.colorScheme.secondary,
          backgroundColor:Color(0xff5B7BB6),
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Get.theme.primaryColor),
            onPressed: () => {
              // Get.find<RootController>().changePageOutRoot(0)
            },
          ),
        ),
        body: Form(
          key: controller.registerFormKey,
          child: ListView(
            primary: true,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    height: 160,
                    width: Get.width,
                    decoration: BoxDecoration(
                      // color: Get.theme.colorScheme.secondary,
                      color: Color(0xff5B7BB6),
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Get.theme.focusColor.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 5)),
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 50),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            _settings.appName,
                            style: Get.textTheme.headline6.merge(TextStyle(
                                color: Get.theme.primaryColor, fontSize: 24)),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Welcome to the best service provider system!".tr,
                            style: Get.textTheme.caption.merge(
                                TextStyle(color: Get.theme.primaryColor)),
                            textAlign: TextAlign.center,
                          ),
                          // Text("Fill the following credentials to login your account", style: Get.textTheme.caption.merge(TextStyle(color: Get.theme.primaryColor))),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: Ui.getBoxDecoration(
                      radius: 14,
                      border:
                          Border.all(width: 5, color: Get.theme.primaryColor),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        'assets/icon/icon.png',
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ],
              ),
              Obx(() {
                if (controller.loading.isTrue) {
                  return CircularLoadingWidget(height: 300);
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFieldWidget(
                        labelText: "Full Name".tr,
                        hintText: "John Doe".tr,
                        initialValue: controller.name,
                        onSaved: (input) => controller.name = input,
                        validator: (input) => input.length < 3
                            ? "Should be more than 3 characters".tr
                            : null,
                        iconData: Icons.person_outline,
                        isFirst: true,
                        isLast: false,
                      ),
                      FieldContainer(
                        labelText: "Gender".tr,
                        // hintText: "John Doe".tr,
                        // initialValue: controller.currentUser?.value?.name,
                        // onSaved: (input) =>
                        //     controller.currentUser.value.name = input,
                        // validator: (input) => input.length < 3
                        //     ? "Should be more than 3 characters".tr
                        //     : null,
                        // iconData: Icons.person_outline,
                        isFirst: false,
                        isLast: false,
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(children: [
                                Obx(
                                  () => Radio(
                                      value: "Male",
                                      groupValue: controller.gender.value,
                                      onChanged: (value) {
                                        controller.gender.value = "Male";
                                      }),
                                ),
                                Text('Male')
                              ]),
                            ),
                            Expanded(
                              child: Row(children: [
                                Obx(
                                  () => Radio(
                                      value: "Female",
                                      groupValue: controller.gender.value,
                                      onChanged: (value) {
                                        controller.gender.value = "Female";
                                      }),
                                ),
                                Text('Female')
                              ]),
                            )
                          ],
                        ),
                      ),
                      TextFieldWidget(
                        labelText: "Email Address".tr,
                        hintText: "johndoe@gmail.com".tr,
                        keyboardType: TextInputType.emailAddress,
                        initialValue: controller.email,
                        onSaved: (input) => controller.email = input,
                        validator: (input) => !input.contains('@')
                            ? "Should be a valid email".tr
                            : null,
                        iconData: Icons.alternate_email,
                        isFirst: false,
                        isLast: false,
                      ),
                      TextFieldWidget(
                        labelText: "Phone Number".tr,
                        hintText: "+1 223 665 7896".tr,
                        keyboardType: TextInputType.phone,
                        initialValue: controller.phoneNumber,
                        onSaved: (input) {
                          if (input.startsWith("00")) {
                            input = "+" + input.substring(2);
                          }
                          return controller.phoneNumber = input;
                        },
                        validator: (input) {
                          return !input.startsWith('\+') &&
                                  !input.startsWith('00')
                              ? "Should be valid mobile number with country code"
                              : null;
                        },
                        iconData: Icons.phone_android_outlined,
                        isLast: false,
                        isFirst: false,
                      ),
                      // TextFieldWidget(
                      //   labelText: "OTP Code".tr,
                      //   hintText: "- - - - - -".tr,
                      //   style: Get.textTheme.headline4.merge(TextStyle(letterSpacing: 8)),
                      //   textAlign: TextAlign.center,
                      //   keyboardType: TextInputType.number,
                      //   onChanged: (input) => controller.smsSent.value = input,
                      //   isLast: false,
                      //   isFirst: false,
                      //   // iconData: Icons.add_to_home_screen_outlined,
                      // ),
                      Obx(() {
                        return TextFieldWidget(
                          labelText: "Password".tr,
                          hintText: "••••••••••••".tr,
                          initialValue: controller.currentUser?.value?.password,
                          onChanged: (input) => controller.password = input,
                          onSaved: (input) => controller.password = input,
                          validator: (input) => input.length < 3
                              ? "Should be more than 3 characters".tr
                              : null,
                          obscureText: controller.hidePassword.value,
                          iconData: Icons.lock_outline,
                          keyboardType: TextInputType.visiblePassword,
                          isLast: false,
                          isFirst: false,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.hidePassword.value =
                                  !controller.hidePassword.value;
                            },
                            color: Theme.of(context).focusColor,
                            icon: Icon(controller.hidePassword.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                          ),
                        );
                      }),
                      Obx(() {
                        return TextFieldWidget(
                          labelText: "Conform Password".tr,
                          hintText: "••••••••••••".tr,
                          initialValue: controller.currentUser?.value?.password,
                          onSaved: (input) => controller.password = input,
                          validator: (input) => input != controller.password
                              ? "Should match password field".tr
                              : null,
                          obscureText: controller.hidePassword.value,
                          iconData: Icons.lock_outline,
                          keyboardType: TextInputType.visiblePassword,
                          isLast: true,
                          isFirst: false,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.hidePassword.value =
                                  !controller.hidePassword.value;
                            },
                            color: Theme.of(context).focusColor,
                            icon: Icon(controller.hidePassword.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                          ),
                        );
                      }),
                    ],
                  );
                }
              })
            ],
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
              children: [
                SizedBox(
                  width: Get.width,
                  child: BlockButtonWidget(
                    onPressed: () {
                      controller.register();
                      //Get.offAllNamed(Routes.PHONE_VERIFICATION);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => SelectOfferingView()));
                    },
                    // color: Get.theme.colorScheme.secondary,
                    color: Color(0xff5B7BB6),
                    text: Text(
                      "Next".tr,
                      style: Get.textTheme.headline6
                          .merge(TextStyle(color: Get.theme.primaryColor)),
                    ),
                  ).paddingOnly(top: 15, bottom: 5, right: 20, left: 20),
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOGIN);
                  },
                  child: Text("You already have an account?".tr),
                ).paddingOnly(bottom: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
