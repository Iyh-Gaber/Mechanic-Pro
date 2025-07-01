import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mechpro/core/utils/app_assets.dart';
import 'package:mechpro/core/utils/app_color.dart';

import '../cars_registration/presentation/views/show_cars.dart';
import '../connect_us/presentation/views/connect_us.dart';

import '../home/presentation/views/home_view.dart';

import '../offers/presentation/views/offers.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  List<Widget> views = [
    ShowCarsView(),
    HomeView(),
    OffersView(),
    ConnectUsView()
  ];
  int currentPage = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whColor,
        body: views[currentPage],
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: AppColors.primaryColor,
          color: AppColors.primaryColor,
          animationDuration: Duration(milliseconds: 300),
          index: currentPage,
          onTap: (value) {
            setState(() {
              currentPage = value;
            });
          },
          items: [
            SvgPicture.asset(
              AppAssets.carSvg,
              color: AppColors.whColor,
              width: 30,
              height: 30,
            ),
            Icon(
              Icons.home_outlined,
              color: AppColors.whColor,
              size: 30,
            ),
            SvgPicture.asset(AppAssets.oredrSvg,
                width: 30, height: 30, color: AppColors.whColor),
            SvgPicture.asset(AppAssets.connectSvg,
                width: 30, height: 30, color: AppColors.whColor),
          ],
        ));
  }
}
