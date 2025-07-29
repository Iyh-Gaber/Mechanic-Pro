import 'package:flutter/material.dart';
import 'package:mechpro/core/widgets/custom_app_bar.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_color.dart';

class OffersView extends StatefulWidget {
  const OffersView({super.key});

  @override
  State<OffersView> createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Offers", showLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(7.0),
        child: ListView(
          children: [
           
           
          ],
        ),
      ),
    );
  }
}
