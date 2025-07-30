

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';
import 'package:mechpro/core/widgets/custom_app_bar.dart';


import 'package:mechpro/feature/offers/data/models/response/offers_response/datum_offers.dart';
import 'package:mechpro/feature/offers/presentation/cubit/offers_cubit.dart';
import 'package:mechpro/feature/offers/presentation/cubit/offers_state.dart';

import 'package:mechpro/feature/offers/presentation/widgets/offer_card.dart';

import 'package:mechpro/core/routing/routes.dart';

import 'package:mechpro/feature/orders/presentation/cubit/orders_cubit.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_state.dart';



class OffersView extends StatefulWidget {
  const OffersView({super.key});

  @override
  State<OffersView> createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersView> {
  final List<String> _defaultImagePaths = [
    'assets/images/cooling.png',
    'assets/images/mech.png',
    'assets/images/acc.png',
    'assets/images/spare.png',
    'assets/images/elect.png',
    'assets/images/Diagnostic Scanner Renta.png',
    'assets/images/Brake Pads.png',
    'assets/images/Brake Pads.png',
    'assets/images/offer.PNG',
  ];

  @override
  void initState() {
    super.initState();
    context.read<OffersCubit>().getOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.Offers.tr(),
        showLeading: false,
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
   
      body: MultiBlocListener(
        listeners: [
          BlocListener<OffersCubit, OffersState>(
            listener: (context, state) {
              if (state is OffersError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
          ),
          BlocListener<OrdersCubit, OrdersState>(
            listener: (context, state) {
              if (state is CreateOrderLoading) {
              
              } else if (state is CreateOrderSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
                Navigator.of(context).pushNamed(Routes.ordersView);
              } else if (state is CreateOrderError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
          ),
        ],
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: BlocBuilder<OffersCubit, OffersState>(
              builder: (context, state) {
                if (state is OffersLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is OffersSuccess) {
                  final List<DatumOffers> offersData = state.offerResponse.data ?? [];
                  if (offersData.isEmpty) {
                    return Center(child: Text(LocaleKeys.NoOffersAvailable.tr()));
                  }
                  return ListView.separated(
                    itemCount: offersData.length,
                    separatorBuilder: (context, index) => 7.verticalSpace,
                    itemBuilder: (context, index) {
                      final DatumOffers offer = offersData[index];
                      final String imageUrl = _defaultImagePaths[index % _defaultImagePaths.length];

                      return OfferCard( 
                        offer: offer,
                        defaultImageUrl: imageUrl,
                      );
                    },
                  );
                } else if (state is OffersError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.ErrorLoadingServices.tr(),
                          style: getTitleStyle(color: AppColors.primaryColor),
                        ),
                       
                        7.verticalSpace,
                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: getSmallStyle(color: AppColors.redColor),
                        ),
                       
                         7.verticalSpace,
                        ElevatedButton(
                          onPressed: () {
                            context.read<OffersCubit>().getOffers();
                          },
                          child: Text(LocaleKeys.TryAgain.tr()),
                        ),
                      ],
                    ),
                  );
                }
                return const Center(
                  child: Text(''),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
