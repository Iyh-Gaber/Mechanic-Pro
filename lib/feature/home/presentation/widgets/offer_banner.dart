import 'package:flutter/material.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/routing/routes.dart';
import 'package:mechpro/core/utils/app_assets.dart';
import 'package:mechpro/core/utils/app_color.dart';


class OfferBanner extends StatelessWidget {
  const OfferBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(Routes.offersView);
       // context.pushTo(OffersView());
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(10.0),
        height: 130,
        decoration: BoxDecoration(
          color: AppColors.whColor,
          borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(
              image: AssetImage(AppAssets.offer),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
