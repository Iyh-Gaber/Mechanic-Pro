import 'package:flutter/material.dart';
import 'package:mechpro/core/widgets/custom_app_bar.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notification", showLeading: false),
      body: Center(
        child: Text(" No Notification Found"),
      ),
    );
  }
}
