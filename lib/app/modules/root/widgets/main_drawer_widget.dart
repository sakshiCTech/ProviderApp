/*
 * Copyright (c) 2020 .
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../custom_pages/views/custom_page_drawer_link_widget.dart';
import '../controllers/root_controller.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../../services/settings_service.dart';

// import '../../routes/app_routes.dart';
// import '../../services/auth_service.dart';
// import '../../services/settings_service.dart';
// import '../custom_pages/views/custom_page_drawer_link_widget.dart';


import 'drawer_link_widget.dart';

class MainDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Obx(() {
            if (!Get.find<AuthService>().isAuth) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.LOGIN);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).hintColor.withOpacity(0.1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome".tr, style: Get.textTheme.headline5.merge(TextStyle(color: Get.theme.colorScheme.secondary))),
                      SizedBox(height: 5),
                      Text("Login account or create new one for free".tr, style: Get.textTheme.bodyText1),
                      SizedBox(height: 15),
                      Wrap(
                        spacing: 10,
                        children: <Widget>[
                          MaterialButton(
                            onPressed: () {
                              Get.toNamed(Routes.LOGIN);
                            },
                            color: Get.theme.colorScheme.secondary,
                            height: 40,
                            elevation: 0,
                            child: Wrap(
                              runAlignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 9,
                              children: [
                                Icon(Icons.exit_to_app_outlined, color: Get.theme.primaryColor, size: 24),
                                Text(
                                  "Login".tr,
                                  style: Get.textTheme.subtitle1.merge(TextStyle(color: Get.theme.primaryColor)),
                                ),
                              ],
                            ),
                            shape: StadiumBorder(),
                          ),
                          MaterialButton(
                            color: Get.theme.focusColor.withOpacity(0.2),
                            height: 40,
                            elevation: 0,
                            onPressed: () {
                              Get.toNamed(Routes.REGISTER);
                            },
                            child: Wrap(
                              runAlignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 9,
                              children: [
                                Icon(Icons.person_add_outlined, color: Get.theme.hintColor, size: 24),
                                Text(
                                  "Register".tr,
                                  style: Get.textTheme.subtitle1.merge(TextStyle(color: Get.theme.hintColor)),
                                ),
                              ],
                            ),
                            shape: StadiumBorder(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return GestureDetector(
                onTap: () {
                  Get.find<RootController>().changePageOutRoot(3);
                },
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).hintColor.withOpacity(0.1),
                  ),
                  accountName: Text(
                    Get.find<AuthService>().user.value.firstName,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  accountEmail: Text(
                    Get.find<AuthService>().user.value.email,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  currentAccountPicture: Stack(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(80)),
                          child: CachedNetworkImage(
                            height: 80,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            imageUrl: Get.find<AuthService>().user.value.avatar,
                            placeholder: (context, url) => Image.asset(
                              'assets/img/loading.gif',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 80,
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.error_outline),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        // child: Get.find<AuthService>().user.value.verifiedPhone ?? false ? Icon(Icons.check_circle, color: Get.theme.colorScheme.secondary, size: 24) : SizedBox(),
                        child:Icon(Icons.check_circle, color: Get.theme.colorScheme.secondary, size: 24),
                      )
                    ],
                  ),
                ),
              );
            }
          }),
          SizedBox(height: 20),
          DrawerLinkWidget(
            icon: Icons.assignment_outlined,
            text: "Bookings",
            onTap: (e) {
              Get.back();
              Get.find<RootController>().changePage(0);
            },
          ),
          DrawerLinkWidget(
            icon: Icons.folder_special_outlined,
            text: "Your Services",
            onTap: (e) {
              Get.offAndToNamed(Routes.E_SERVICES);
            },
          ),
          DrawerLinkWidget(
            icon: Icons.notifications_none_outlined,
            text: "Notifications",
            onTap: (e) {
              Get.offAndToNamed(Routes.NOTIFICATIONS);
            },
          ),
          DrawerLinkWidget(
            icon: Icons.chat_outlined,
            text: "Messages",
            onTap: (e) {
              Get.back();
              Get.find<RootController>().changePage(2);
            },
          ),
          DrawerLinkWidget(
            icon: Icons.account_balance_wallet_outlined,
            text: "Wallet",
            onTap: (e) {
              Get.back();
              Get.find<RootController>().changePage(2);
            },
          ),
          DrawerLinkWidget(
            icon: Icons.money_outlined,
            text: "Earnings",
            onTap: (e) {
              Get.back();
              Get.find<RootController>().changePage(2);
            },
          ),
          // DrawerLinkWidget(
          //   icon: Icons.payment_outlined,
          //   text: "Card",
          //   onTap: (e) {
          //     Get.back();
          //     Get.find<RootController>().changePage(2);
          //   },
          // ),
          ListTile(
            dense: true,
            title: Text(
              "Application preferences".tr,
              style: Get.textTheme.caption,
            ),
            trailing: Icon(
              Icons.remove,
              color: Get.theme.focusColor.withOpacity(0.3),
            ),
          ),
          // DrawerLinkWidget(
          //   icon: Icons.person_outline,
          //   text: "Account",
          //   onTap: (e) {
          //     Get.back();
          //     Get.find<RootController>().changePage(3);
          //   },
          // ),
          DrawerLinkWidget(
            icon: Icons.settings_outlined,
            text: "Settings",
            onTap: (e) {
              Get.offAndToNamed(Routes.SETTINGS);
            },
          ),
          DrawerLinkWidget(
            icon: Icons.notifications_none_outlined,
            text: "Notification Manager",
            onTap: (e) {
              Get.offAndToNamed(Routes.SETTINGS);
            },
          ),
          // DrawerLinkWidget(
          //   icon: Icons.translate_outlined,
          //   text: "Languages",
          //   onTap: (e) {
          //     Get.offAndToNamed(Routes.SETTINGS_LANGUAGE);
          //   },
          // ),
          // DrawerLinkWidget(
          //   icon: Icons.brightness_6_outlined,
          //   text: Get.isDarkMode ? "Light Theme" : "Dark Theme",
          //   onTap: (e) {
          //     Get.offAndToNamed(Routes.SETTINGS_THEME_MODE);
          //   },
          // ),
          ListTile(
            dense: true,
            title: Text(
              "Help & Privacy",
              style: Get.textTheme.caption,
            ),
            trailing: Icon(
              Icons.remove,
              color: Get.theme.focusColor.withOpacity(0.3),
            ),
          ),
          DrawerLinkWidget(
            icon: Icons.help_outline,
            text: "Help & FAQ",
            onTap: (e) {
              Get.offAndToNamed(Routes.HELP);
            },
          ),
          DrawerLinkWidget(
            icon: Icons.privacy_tip_outlined,
            text: "Privacy Policy",
            onTap: (e) {
              Get.offAndToNamed(Routes.HELP);
            },
          ),
          DrawerLinkWidget(
            icon: Icons.gavel_outlined,
            text: "Terms & Conditions",
            onTap: (e) {
              Get.offAndToNamed(Routes.HELP);
            },
          ),
          DrawerLinkWidget(
            icon: Icons.share_outlined,
            text: "Share",
            onTap: (e) {
              Get.offAndToNamed(Routes.HELP);
            },
          ),
          CustomPageDrawerLinkWidget(),
          Obx(() {
            if (Get.find<AuthService>().isAuth) {
              return DrawerLinkWidget(
                icon: Icons.logout,
                text: "Logout",
                onTap: (e) async {
                  await Get.find<AuthService>().removeCurrentUser();
                  await Get.offNamedUntil(Routes.LOGIN, (Route route) {
                    if (route.settings.name == Routes.LOGIN) {
                      return true;
                    }
                    return false;
                  });
                },
              );
            } else {
              return SizedBox(height: 0);
            }
          }),
          if (Get.find<SettingsService>().setting.value.enableVersion)
            ListTile(
              dense: true,
              title: Text(
                "Version".tr + " " + Get.find<SettingsService>().setting.value.appVersion,
                style: Get.textTheme.caption,
              ),
              trailing: Icon(
                Icons.remove,
                color: Get.theme.focusColor.withOpacity(0.3),
              ),
            )
        ],
      ),
    );
  }
}
