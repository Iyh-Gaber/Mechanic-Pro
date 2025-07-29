import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';

import 'package:mechpro/feature/offers/data/models/response/offers_response/datum_offers.dart';
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request.dart';
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request_service.dart';
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request_sub_service.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_cubit.dart';
import 'package:mechpro/core/routing/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OfferCard extends StatelessWidget {
  final DatumOffers offer;
  final String defaultImageUrl; // لكي نستخدم الصور الافتراضية

  const OfferCard({
    Key? key,
    required this.offer,
    required this.defaultImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // بناء نص الخصم
    String discountText = '';
    if (offer.discountValue != null) {
      if (offer.isPercentage == true) {
        discountText = '${offer.discountValue!.toStringAsFixed(0)}% OFF';
      } else {
        discountText = 'Discount: ${offer.discountValue!.toStringAsFixed(2)}';
      }
    }

    // بناء نص تاريخ الصلاحية
    String validityText = '';
    if (offer.startDate != null && offer.endDate != null) {
      validityText =
          '${LocaleKeys.ValidUntil.tr()}: ${DateFormat('yyyy-MM-dd').format(offer.endDate!)}'; // "صالح حتى"
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة العرض
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
                  color: AppColors.grColor.withOpacity(0.2),
                  child: Icon(Icons.broken_image, color: AppColors.grColor),
                ),
              ),
            ),
            12.verticalSpace,
            // عنوان العرض
            Text(
              offer.title ?? LocaleKeys.UnknownOffer.tr(), // "عرض غير معروف"
              style: getTitleStyle(
                color: AppColors.primaryColor,
                fontSize: 20,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            8.verticalSpace,
            // وصف العرض
            Text(
              offer.description ?? LocaleKeys.Nodescriptionavailable.tr(),
              style: getBodyStyle(
                color: AppColors.blackColor.withOpacity(0.7),
                fontSize: 14,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            8.verticalSpace,
            // الخصم (إذا كان موجودًا)
            if (discountText.isNotEmpty)
              Text(
                discountText,
                style: getTitleStyle(
                  color: AppColors.primaryColor, // لون مميز للخصم
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            4.verticalSpace,
            // تاريخ الصلاحية (إذا كان موجودًا)
            if (validityText.isNotEmpty)
              Text(
                validityText,
                style: getSmallStyle(
                  color: AppColors.grColor,
                  fontSize: 12,
                ),
              ),
            12.verticalSpace,
            // زر الحجز
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final user = FirebaseAuth.instance.currentUser;
                  if (user == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(LocaleKeys.PleaseLoginToRedeemOffer.tr())), // "الرجاء تسجيل الدخول للاستفادة من العرض."
                    );
                    return;
                  }

                  final String? firebaseUserId = user.uid;
                  if (firebaseUserId == null) {
                    print('ERROR: Firebase User ID is null. Cannot create order.');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(LocaleKeys.ErrorUserIdNotFound.tr())), // "خطأ: لم يتم العثور على معرف المستخدم. الرجاء تسجيل الدخول مرة أخرى."
                    );
                    return;
                  }

                  final String locationDetails = LocaleKeys.OnlineOfferRedemption.tr(); // "استفادة من العرض عبر الإنترنت"
                  const bool isHomeService = false;
                  final DateTime orderDateTime = DateTime.now();

                  final orderRequestService = OrderRequestService(
                    orderServiceName: "${LocaleKeys.OfferRedemption.tr()}: ${offer.title ?? LocaleKeys.UnknownOffer.tr()}", // "استفادة من العرض"
                    orderSubServices: [
                      OrderRequestSubService(
                        orderSubServiceName: offer.title,
                      )
                    ],
                  );

                  final orderRequest = OrderRequest(
                    userId: firebaseUserId,
                    userName: user.displayName ?? user.email ?? LocaleKeys.UnknownUser.tr(), // "مستخدم غير معروف"
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
                  LocaleKeys.RedeemOffer.tr(), // "استفد من العرض"
                  style: getBodyStyle(color: AppColors.whColor, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
