import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/past_view.dart';

import 'your_services_logic.dart';

class YourServicesPage extends GetView<YourServicesLogic> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Your Service'),
          bottom: TabBar(
            tabs: [Tab(text: 'PAST'), Tab(text: 'UPCOMING')],
          ),
        ),
        body: TabBarView(
          children: [PastView(), PastView()],
        ),
      ),
    );
  }
}
