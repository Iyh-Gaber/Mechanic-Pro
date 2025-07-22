import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';

import '../../../../core/translate/app_translate.g.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/text_style.dart';
import '../widgets/custom_service_card.dart';

class SellingOriginalPartsView extends StatelessWidget {
  const SellingOriginalPartsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(LocaleKeys.OtherServices.tr(),
            style: getBodyStyle(color: AppColors.whColor)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              CustomServiceCard(
                imageUrl: 'assets/images/Brake Pads.png',
                serviceName: 'gjhhjhj',
                serviceDescription:
                    'rgrtuyikuydtjndtyldddddrwesdeerhfgktythrsswtgt',
                onButtonPressed: () {},
              ),
              7.verticalSpace,
              CustomServiceCard(
                imageUrl: 'assets/images/Oil Filter.png',
                serviceName: 'gjhhjhj',
                serviceDescription:
                    'rgrtuyikuydtjndtyldddddrwesdeerhfgktythrsswtgt',
                onButtonPressed: () {},
              ),
              7.verticalSpace,
              CustomServiceCard(
                imageUrl: 'assets/images/Air Filter.png',
                serviceName: 'gjhhjhj',
                serviceDescription:
                    'rgrtuyikuydtjndtyldddddrwesdeerhfgktythrsswtgt',
                onButtonPressed: () {},
              ),
              7.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
