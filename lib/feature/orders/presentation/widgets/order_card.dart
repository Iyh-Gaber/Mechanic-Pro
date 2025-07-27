/*import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/feature/orders/data/models/response/order_response/order_response/datum_order.dart';

import '../../../../core/translate/locale_keys.g.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/text_style.dart';
import '../../data/models/request/order_model/order_service.dart';


class OrderCard extends StatelessWidget {
  final DatumOrder orderData; // 🌟🌟🌟 غير النوع هنا إلى Data 🌟🌟🌟

  const OrderCard({super.key, required this.orderData});

  // هذه الدالة كانت تستخدم حالة (string status)، ولكن API الخاص بك يرجع statusCode
  // إذا أردت تلوين الحالة بناءً على الـ statusCode، يجب أن يكون الـ statusCode متاحًا
  // من كائن Data، أو أن تمرره من OrderResponse الكلية إذا كنت لا تزال تستخدمها
  // ولكن في التصميم الحالي، Data فقط تحتوي على orderNumber.
  // لذا، هذه الدالة قد تحتاج لإعادة تقييم أو إزالتها إذا لم تكن تستخدم.
  Color _getStatusColor(int? statusCode) {
    // غيرت نوع الإدخال إلى int?
    if (statusCode == null) return Colors.grey;
    if (statusCode >= 200 && statusCode < 300) return Colors.green; // نجاح
    if (statusCode >= 400 && statusCode < 500) return Colors.red; // خطأ عميل
    if (statusCode >= 500) return Colors.deepOrange; // خطأ سيرفر
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🌟🌟🌟 الوصول إلى orderNumber مباشرة من orderData 🌟🌟🌟
            Text(
              //'${LocaleKeys.OrderId.tr()}: ${orderData.orderId?? 'N/A'}',

             '${LocaleKeys.OrderId.tr()}: ${OrderService.orderServiceName?? 'N/A'}',
             
              style: getSmallStyle(color: AppColors.blackColor),
            ),
            4.verticalSpace,
            // 💡 ملاحظات هامة:
            // - حقول مثل 'Status', 'Services', 'Date', 'Time', 'Location', 'Details', 'RequestedAt'
            //   ليست موجودة حالياً في كلاس `Data` بناءً على تعريفك.
            // - إذا أردت عرض هذه البيانات، فيجب أن يقوم الـ API بإرجاعها داخل كل كائن `Data`،
            //   وعليك تحديث كلاس `Data` ليحتوي على هذه الحقول (ثم تشغيل build_runner إذا استخدمت freezed).
            // - حالياً، نحن نعرض فقط `orderNumber` لأنه الوحيد المتوفر في `Data`.

            // مثال على ما يمكنك فعله إذا كان الـ API يرجع Status داخل Data:
            // Text(
            //   '${LocaleKeys.Status.tr()}: ${orderData.status ?? 'Unknown'}', // لو كان Data يحتوي على status
            //   style: getSmallStyle(color: _getStatusColor(orderData.statusCode)), // لو كان Data يحتوي على statusCode
            // ),

            // الأجزاء المعلقة في الكود الأصلي لا يمكن تفعيلها إلا إذا كانت الحقول موجودة في كلاس Data
            Text(
             orderData.maintenanceCenter?? 'N/A'
             
             // 'Status: Not available in Data'
              
              , // رسالة توضيحية لعدم توفر الحقل
              style: getSmallStyle(color: AppColors.grColor),
            ),
            8.verticalSpace,
            Text(
            //  LocaleKeys.Services.tr().orderData.services?? 'N/A',
              '${LocaleKeys.Date.tr() }:  ${orderData.orderDate?? 'N/A'}',
              style: getSmallStyle(color: AppColors.blackColor),
            ),
            // ... باقي الأسطر المعلقة تحتاج إلى توفر البيانات في كائن Data
          ],
        ),
      ),
    );
  }
}
*/

/*
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';

import 'package:intl/intl.dart'; // 🌟🌟🌟 مهم: استيراد مكتبة intl لتنسيق التاريخ 🌟🌟🌟
import 'package:mechpro/feature/orders/data/models/response/datum_order.dart';

import '../../../../core/translate/locale_keys.g.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/text_style.dart';
// لا نحتاج لاستيراد OrderService هنا لأننا نستخدمه من خلال DatumOrder
// import '../../data/models/request/order_model/order_service.dart';

class OrderCard extends StatelessWidget {
  final DatumOrder orderData;

  const OrderCard({super.key, required this.orderData});

  // هذه الدالة لتلوين الحالة بناءً على الـ statusCode
  // ملاحظة: الـ statusCode موجود في OrderResponse وليس في DatumOrder مباشرةً.
  // إذا كنت تريد استخدامها، يجب أن يكون الـ statusCode متاحًا في DatumOrder أو تمرره بشكل منفصل.
  Color _getStatusColor(int? statusCode) {
    if (statusCode == null) return Colors.grey;
    if (statusCode >= 200 && statusCode < 300) return Colors.green; // نجاح
    if (statusCode >= 400 && statusCode < 500) return Colors.red; // خطأ عميل
    if (statusCode >= 500) return Colors.deepOrange; // خطأ سيرفر
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // 🌟🌟🌟 استخدم const هنا 🌟🌟🌟
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🌟🌟🌟 تصحيح الوصول إلى orderId من orderData 🌟🌟🌟
            Text(
              '${LocaleKeys.OrderId.tr()}: ${orderData.orderId ?? 'N/A'}',
              style: getSmallStyle(color: AppColors.blackColor),
            ),
            4.verticalSpace,

            // 🌟🌟🌟 عرض Maintenance Center (مركز الصيانة) 🌟🌟🌟
            Text(
              '${LocaleKeys.Location.tr()}: ${orderData.maintenanceCenter ?? 'N/A'}',
              style: getSmallStyle(color: AppColors.grColor),
            ),
            8.verticalSpace,

            // 🌟🌟🌟 عرض Order Date (تاريخ الطلب) مع التنسيق 🌟🌟🌟
            Text(
              '${LocaleKeys.Date.tr()}: ${orderData.orderDate != null ? DateFormat('dd MMM yyyy').format(orderData.orderDate!) : 'N/A'}',
              style: getSmallStyle(color: AppColors.blackColor),
            ),
            8.verticalSpace,

            // 🌟🌟🌟 عرض Order Services والخدمات الفرعية (orderSubServices) 🌟🌟🌟
            if (orderData.orderServices != null &&
                orderData.orderServices!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${LocaleKeys.Services.tr()}:', // يمكنك إضافة هذا المفتاح في ملف الترجمة
                    style: getSmallStyle(color: AppColors.blackColor),
                  ),
                  8.verticalSpace,
                  ...orderData.orderServices!.map((service) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                          child: Text(
                            '- ${service.orderServiceName ?? 'N/A'}', // الوصول الصحيح لـ orderServiceName
                            style: getSmallStyle(color: AppColors.blackColor),
                          ),
                        ),
                        if (service.orderSubServices != null &&
                            service.orderSubServices!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  service.orderSubServices!.map((subService) {
                                return Text(
                                  '  • ${subService.orderSubServiceName ?? 'N/A'}', // الوصول الصحيح لـ orderSubServiceName
                                  style:
                                      getSmallStyle(color: AppColors.grColor),
                                );
                              }).toList(),
                            ),
                          ),
                      ],
                    );
                  }).toList(),
                ],
              )
            else
              Text(
                "No Services available", // يمكنك إضافة هذا المفتاح في ملف الترجمة
                style: getSmallStyle(color: AppColors.grColor),
              ),
          ],
        ),
      ),
    );
  }
}
*/
/*

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';

import 'package:intl/intl.dart'; // مهم لتنسيق التاريخ
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request_service.dart';
import 'package:mechpro/feature/orders/data/models/response/datum_order.dart'; // هذا هو الموديل الصحيح لاستقبال بيانات الطلب
import 'package:mechpro/feature/orders/data/models/response/order_sub_service.dart';

import '../../../../core/translate/locale_keys.g.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/text_style.dart';

// لا نحتاج لاستيراد OrderService هنا لأننا نستخدمه من خلال DatumOrder
// تأكد أنك لا تستورد أي شيء من 'request/order_request/' هنا
// import '../../data/models/request/order_model/order_service.dart'; // هذا السطر يجب حذفه إذا كان موجودًا لديك

class OrderCard extends StatelessWidget {
  final DatumOrder orderData; // هنا نستخدم DatumOrder وهو صحيح

  const OrderCard({super.key, required this.orderData});

  // هذه الدالة لتلوين الحالة بناءً على الـ statusCode
  // ملاحظة: الـ statusCode موجود في OrderResponse وليس في DatumOrder مباشرةً.
  // إذا كنت تريد استخدامها، يجب أن يكون الـ statusCode متاحًا في DatumOrder أو تمرره بشكل منفصل.
  // حالياً، لن نستخدمها في عرض "حالة الطلب" لأن DatumOrder لا يحتوي على حقل حالة مباشر اسمه "status" أو "statusCode"
  // إلا إذا قمت بإضافته في DatumOrder.
  Color _getStatusColor(int? statusCode) {
    if (statusCode == null) return Colors.grey;
    if (statusCode >= 200 && statusCode < 300) return Colors.green; // نجاح
    if (statusCode >= 400 && statusCode < 500) return Colors.red; // خطأ عميل
    if (statusCode >= 500) return Colors.deepOrange; // خطأ سيرفر
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // استخدم const هنا
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عرض رقم الطلب (orderId)
            Text(
              '${LocaleKeys.OrderId.tr()}: ${orderData.orderId ?? 'N/A'}',
              style: getSmallStyle(color: AppColors.blackColor),
            ),
            4.verticalSpace,

            // عرض مركز الصيانة (maintenanceCenter)
            Text(
              '${LocaleKeys.Location.tr()}: ${orderData.maintenanceCenter ?? 'N/A'}',
              style: getSmallStyle(color: AppColors.grColor),
            ),
            8.verticalSpace,

            // عرض تاريخ الطلب (orderDate) مع التنسيق
            Text(
              '${LocaleKeys.Date.tr()}: ${orderData.orderDate != null ? DateFormat('dd MMM yyyy').format(orderData.orderDate!) : 'N/A'}',
              style: getSmallStyle(color: AppColors.blackColor),
            ),
            8.verticalSpace,

            // عرض مبلغ الطلب (orderAmount) - إذا كان متاحاً في DatumOrder
            Text(
              '${LocaleKeys.OrderAmount.tr()}: ${orderData.orderAmount?.toStringAsFixed(2) ?? 'N/A'}', // toStringAsFixed(2) لتنسيق رقم عشري
              style: getSmallStyle(color: AppColors.blackColor),
            ),
            8.verticalSpace,

            // عرض حالة الدفع (isPaid)
            Text(
              '${LocaleKeys.IsPaid.tr()}: ${(orderData.isPaid ?? false) ? LocaleKeys.Yes.tr() : LocaleKeys.No.tr()}',
              style: getSmallStyle(
                color: (orderData.isPaid ?? false)
                    ? AppColors.primaryColor
                    : AppColors.redColor,
              ),
            ),
            8.verticalSpace,

            // عرض Order Services والخدمات الفرعية (orderSubServices)
            if (orderData.orderServices != null &&
                orderData.orderServices!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${LocaleKeys.Services.tr()}:', // تأكد من إضافة هذا المفتاح في ملف الترجمة
                    style: getSmallStyle(color: AppColors.blackColor),
                  ),
                  8.verticalSpace,
                  ...orderData.orderServices!.map((service) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                          child: Text(
                            '- ${service.orderServiceName ?? 'N/A'}', // الوصول الصحيح لـ orderServiceName
                            style: getSmallStyle(color: AppColors.blackColor),
                          ),
                        ),
                        if (service.orderSubServices != null &&
                            service.orderSubServices!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: service.orderSubServices!.map((
                                subService,
                              ) {
                                return Text(
                                  '  • ${OrderRequestService(orderServiceName: subService.orderSubServiceName) ?? 'N/A'}', // الوصول الصحيح لـ orderSubServiceName
                                  style: getSmallStyle(
                                    color: AppColors.grColor,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                      ],
                    );
                  }),
                ],
              )
            else
              Text(
                "No Services available",
                style: getSmallStyle(color: AppColors.grColor),
              ),
          ],
        ),
      ),
    );
  }
}
*/

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';

import 'package:intl/intl.dart'; // مهم لتنسيق التاريخ
// تأكد من استيراد DatumOrder من مجلد الـ RESPONSE
import 'package:mechpro/feature/orders/data/models/response/datum_order.dart'; // <--- هذا هو الاستيراد الصحيح

import '../../../../core/translate/locale_keys.g.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/text_style.dart';

class OrderCard extends StatelessWidget {
  // OrderCard الآن يستقبل DatumOrder بشكل صحيح
  final DatumOrder orderData;

  const OrderCard({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عرض رقم الطلب (orderId)
            Text(
              '${LocaleKeys.OrderId.tr()}: ${orderData.orderId ?? 'N/A'}',
              style: getSmallStyle(color: AppColors.blackColor),
            ),
            4.verticalSpace,

            // عرض مركز الصيانة (maintenanceCenter)
            Text(
              '${LocaleKeys.Location.tr()}: ${orderData.maintenanceCenter ?? 'N/A'}',
              style: getSmallStyle(color: AppColors.grColor),
            ),
            8.verticalSpace,

            // عرض تاريخ الطلب (orderDate) مع التنسيق
            Text(
              '${LocaleKeys.Date.tr()}: ${orderData.orderDate != null ? DateFormat('dd MMM yyyy').format(orderData.orderDate!) : 'N/A'}',
              style: getSmallStyle(color: AppColors.blackColor),
            ),
            8.verticalSpace,

            // عرض مبلغ الطلب (orderAmount)
            Text(
              '${LocaleKeys.OrderAmount.tr()}: ${orderData.orderAmount?.toStringAsFixed(2) ?? 'N/A'}',
              style: getSmallStyle(color: AppColors.blackColor),
            ),
            8.verticalSpace,

            // عرض حالة الدفع (isPaid)
            Text(
              '${LocaleKeys.IsPaid.tr()}: ${(orderData.isPaid ?? false) ? LocaleKeys.yes.tr() : LocaleKeys.no.tr()}',
              style: getSmallStyle(
                color: (orderData.isPaid ?? false)
                    ? AppColors.primaryColor
                    : AppColors.redColor,
              ),
            ),
            8.verticalSpace,

            // عرض Order Services والخدمات الفرعية (orderSubServices)
            // هذا الجزء يعتمد على بنية OrderService و OrderSubService داخل DatumOrder
            if (orderData.orderServices != null &&
                orderData.orderServices!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${LocaleKeys.Services.tr()}:',
                    style: getSmallStyle(color: AppColors.blackColor),
                  ),
                  8.verticalSpace,
                  ...orderData.orderServices!.map((service) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                          child: Text(
                            '- ${service.orderServiceName ?? 'N/A'}', // الوصول الصحيح لـ orderServiceName
                            style: getSmallStyle(color: AppColors.blackColor),
                          ),
                        ),
                        if (service.orderSubServices != null &&
                            service.orderSubServices!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: service.orderSubServices!.map((
                                subService,
                              ) {
                                return Text(
                                  '  • ${subService.orderSubServiceName ?? 'N/A'}', // الوصول الصحيح لـ orderSubServiceName
                                  style: getSmallStyle(
                                    color: AppColors.grColor,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                      ],
                    );
                  }).toList(),
                ],
              )
            else
              Text(
                "No Services available",
                style: getSmallStyle(color: AppColors.grColor),
              ),
          ],
        ),
      ),
    );
  }
}
