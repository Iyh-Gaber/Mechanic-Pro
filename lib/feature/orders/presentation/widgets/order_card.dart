import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/feature/orders/data/models/response/order_response/order_response/datum_order.dart';

import '../../../../core/translate/locale_keys.g.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/text_style.dart';


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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🌟🌟🌟 الوصول إلى orderNumber مباشرة من orderData 🌟🌟🌟
            Text(
              '${LocaleKeys.OrderId.tr()}: ${orderData.orderId ?? 'N/A'}',
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
              'Status: Not available in Data', // رسالة توضيحية لعدم توفر الحقل
              style: getSmallStyle(color: AppColors.grColor),
            ),
            8.verticalSpace,
            Text(
              LocaleKeys.Services.tr(),
              style: getBodyStyle(color: AppColors.blackColor),
            ),
            // ... باقي الأسطر المعلقة تحتاج إلى توفر البيانات في كائن Data
          ],
        ),
      ),
    );
  }
}
