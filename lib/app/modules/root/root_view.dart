import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'root_logic.dart';

class RootPage extends GetView<RootLogic> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(controller.name),
      ),
    );
  }
}
