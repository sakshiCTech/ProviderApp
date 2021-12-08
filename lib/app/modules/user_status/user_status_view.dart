import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../root/widgets/main_drawer_widget.dart';

class UserStatusPage extends GetView<UserStatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: MainDrawerWidget(),
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Please wait while\n we are verifying your documents.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
