import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/routing/routes.dart';
import 'package:mechpro/core/translate/app_translate.g.dart';
import 'package:mechpro/core/utils/app_assets.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';

class OfferBanner extends StatefulWidget {
  const OfferBanner({super.key});

  @override
  State<OfferBanner> createState() => _OfferBannerState();
}

class _OfferBannerState extends State<OfferBanner> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(Routes.offersView);
        // context.pushTo(OffersView());
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(10.0),
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.whColor,
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                image: AssetImage(AppAssets.offer),
                fit: BoxFit.cover,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              context.pushNamed(Routes.offersView);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(LocaleKeys.ShowMore.tr(), style: getSmallStyle()),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
