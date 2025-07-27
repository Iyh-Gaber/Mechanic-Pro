/*import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mechpro/core/utils/app_assets.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/feature/home/data/repo/main_services_repo.dart';

import '../cars_registration/presentation/views/show_cars.dart';
import '../connect_us/presentation/views/connect_us.dart';

import '../home/presentation/cubit/main_services_cubit.dart';
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
    BlocProvider(
        create: (BuildContext context) {
          return MainServicesCubit(MainServicesRepo());
        },
        child: HomeView()),
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
          color: AppColors.whColor,
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
              color: AppColors.primaryColor,
              width: 30,
              height: 30,
            ),
            Icon(
              Icons.home_outlined,
              color: AppColors.primaryColor,
              size: 30,
            ),
            SvgPicture.asset(AppAssets.oredrSvg,
                width: 30, height: 30, color: AppColors.primaryColor),
            SvgPicture.asset(AppAssets.connectSvg,
                width: 30, height: 30, color: AppColors.primaryColor),
          ],
        ));
  }
}
*/
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_assets.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';
import 'package:mechpro/feature/home/data/repo/main_services_repo.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_cubit.dart';
import 'package:mechpro/feature/orders/presentation/views/orders_view.dart';

import '../cars_registration/presentation/views/show_cars.dart';
import '../connect_us/presentation/views/connect_us.dart';

import '../home/presentation/cubit/main_services_cubit.dart';
import '../home/presentation/views/home_view.dart';

import '../offers/presentation/views/offers.dart';
import '../orders/data/repo/order_repo.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  List<Widget> views = [
    ShowCarsView(),
    BlocProvider(
      create: (BuildContext context) {
        return MainServicesCubit(MainServicesRepo());
      },
      child: HomeView(),
    ),
    BlocProvider(
      create: (BuildContext context) {
        return OrdersCubit(OrdersRepo());
      },
      child: OrdersView(),
    ),
    ConnectUsView(),
  ];
  int currentPage = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whColor,
      body: views[currentPage],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppColors.whColor,
        color: AppColors.primaryColor,
        animationDuration: const Duration(milliseconds: 300),
        index: currentPage,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        items: [
          Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center items vertically
            children: [
              SvgPicture.asset(
                AppAssets.carSvg,
                color: AppColors.whColor,
                width: 30,
                height: 30,
              ),
              2.verticalSpace, // Add some space between icon and text
              Text(
                'Cars', // Label for Cars
                style: getSmallStyle(color: AppColors.whColor),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.home_outlined, color: AppColors.whColor, size: 30),
              2.verticalSpace,
              Text(
                'Home', // Label for Home
                style: getSmallStyle(color: AppColors.whColor),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.oredrSvg,
                width: 27,
                height: 27,
                color: AppColors.whColor,
              ),
              2.verticalSpace,
              Text(
                'Orders', // Label for Offers
                style: getSmallStyle(color: AppColors.whColor),
                // style: TextStyle(color: AppColors.whColor, fontSize: 17),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.connectSvg,
                width: 30,
                height: 30,
                color: AppColors.whColor,
              ),
              2.verticalSpace,
              Text(
                'Contact Us', // Label for Connect Us
                style: getSmallStyle(color: AppColors.whColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
