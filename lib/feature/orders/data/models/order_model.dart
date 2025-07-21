/* import 'package:flutter/material.dart';
import 'package:mechpro/feature/home/data/models/response/main_services_response/datum.dart';

//import '../../../home/data/models/response/main_services_response/datum.dart';


class OrderModel {
  final String orderId; // معرف فريد للطلب
  final List<Datum> selectedServices; // قائمة بالخدمات المختارة (Datum)
  final DateTime selectedDate; // التاريخ المختار
  final TimeOfDay selectedTime; // الوقت المختار
  final String locationType; // نوع الموقع ('my_location' أو 'our_branches')
  final String? locationDetails; // تفاصيل الموقع (العنوان أو اسم الفرع)
  final DateTime createdAt; // وقت إنشاء الطلب
  String status; // حالة الطلب (مثال: 'Pending', 'Confirmed', 'Completed', 'Cancelled')

  OrderModel({
    required this.orderId,
    required this.selectedServices,
    required this.selectedDate,
    required this.selectedTime,
    required this.locationType,
    this.locationDetails,
    required this.createdAt,
    this.status = 'Pending', // الحالة الافتراضية
  });

  // Convert OrderModel to JSON (Map) for storage or API calls
  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'selectedServices': selectedServices.map((s) => s.toJson()).toList(), // تحويل Datum إلى JSON
      'selectedDate': selectedDate.toIso8601String(),
      'selectedTimeHour': selectedTime.hour,
      'selectedTimeMinute': selectedTime.minute,
      'locationType': locationType,
      'locationDetails': locationDetails,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
    };
  }

  // Create OrderModel from JSON (Map)
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'] as String,
      selectedServices: (json['selectedServices'] as List)
          .map((item) => Datum.fromJson(item as Map<String, dynamic>))
          .toList(),
      selectedDate: DateTime.parse(json['selectedDate'] as String),
      selectedTime: TimeOfDay(
        hour: json['selectedTimeHour'] as int,
        minute: json['selectedTimeMinute'] as int, // ⬅️ **خطأ تم تصحيحه هنا**
      ),
      locationType: json['locationType'] as String,
      locationDetails: json['locationDetails'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: json['status'] as String,
    );
  }
}


*/
