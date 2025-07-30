import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';

import 'package:mechpro/feature/offers/data/models/response/offers_response/datum_offers.dart';
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request.dart';
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request_service.dart';
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request_sub_service.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_cubit.dart';

import 'package:firebase_auth/firebase_auth.dart';

class OfferCard extends StatelessWidget {
  final DatumOffers offer;
  final String defaultImageUrl; 

  const OfferCard({
    Key? key,
    required this.offer,
    required this.defaultImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    String discountText = '';
    if (offer.discountValue != null) {
      if (offer.isPercentage == true) {
        discountText = '${offer.discountValue!.toStringAsFixed(0)}% OFF';
      } else {
        discountText = 'Discount: ${offer.discountValue!.toStringAsFixed(2)}';
      }
    }

   
    String validityText = '';
    if (offer.startDate != null && offer.endDate != null) {
      validityText =
          '${LocaleKeys.ValidUntil.tr()}: ${DateFormat('yyyy-MM-dd').format(offer.endDate!)}'; 
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                defaultImageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 150,
                  width: double.infinity,
                  color: AppColors.grColor,
                  child: Icon(Icons.broken_image, color: AppColors.grColor),
                ),
              ),
            ),
            7.verticalSpace,
            
            Text(
              offer.title ?? LocaleKeys.UnknownOffer.tr(), 
              style: getTitleStyle(
                color: AppColors.primaryColor,
                fontSize: 20,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            7.verticalSpace,
           
            Text(
              offer.description ?? LocaleKeys.Nodescriptionavailable.tr(),
              style: getBodyStyle(
                color: AppColors.blackColor,
                fontSize: 14,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            7.verticalSpace,
            
            if (discountText.isNotEmpty)
              Text(
                discountText,
                style: getTitleStyle(
                  color: AppColors.primaryColor, 
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            7.verticalSpace,
           
            if (validityText.isNotEmpty)
              Text(
                validityText,
                style: getSmallStyle(
                  color: AppColors.grColor,
                  fontSize: 14,
                ),
              ),
            7.verticalSpace,
           
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final user = FirebaseAuth.instance.currentUser;
                  if (user == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(LocaleKeys.PleaseLoginToRedeemOffer.tr())), 
                    );
                    return;
                  }

                  final String? firebaseUserId = user.uid;
                  if (firebaseUserId == null) {
                    print('ERROR: Firebase User ID is null. Cannot create order.');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(LocaleKeys.ErrorUserIdNotFound.tr())), 
                    );
                    return;
                  }

                  final String locationDetails = LocaleKeys.OnlineOfferRedemption.tr(); 
                  const bool isHomeService = false;
                  final DateTime orderDateTime = DateTime.now();

                  final orderRequestService = OrderRequestService(
                    orderServiceName: "${LocaleKeys.OfferRedemption.tr()}: ${offer.title ?? LocaleKeys.UnknownOffer.tr()}", 
                    orderSubServices: [
                      OrderRequestSubService(
                        orderSubServiceName: offer.title,
                      )
                    ],
                  );

                  final orderRequest = OrderRequest(
                    userId: firebaseUserId,
                    userName: user.displayName ?? user.email ?? LocaleKeys.UnknownUser.tr(), 
                    orderServices: [orderRequestService],
                    maintenanceCenter: locationDetails,
                    isHomeService: isHomeService,
                    orderDate: orderDateTime,
                  );

                  context.read<OrdersCubit>().createNewOrder(orderRequest);
                  print('تم الضغط على زر الاستفادة من العروض لـ: ${offer.title} - تم إنشاء الطلب مباشرة.');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
                child: Text(
                  LocaleKeys.RedeemOffer.tr(), 
                  style: getBodyStyle(color: AppColors.whColor, fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
