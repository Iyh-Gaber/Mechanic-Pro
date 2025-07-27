// lib/feature/orders/data/models/response/order_response/order_response.dart

import 'package:json_annotation/json_annotation.dart';
import 'package:mechpro/feature/orders/data/models/response/datum_order.dart'; // مسار كامل
import 'package:mechpro/feature/orders/data/models/response/order_number_model.dart'; // مسار كامل

part 'order_response.g.dart'; // هذا السطر يجب أن يكون بعد كل الـ imports وقبل الكلاس

@JsonSerializable()
class OrderResponse {
  final dynamic data; // سيكون إما OrderNumberModel أو List<DatumOrder>
  final String? successMessage;
  final int? statusCode;
  final List<String>? errorList;
  final List<String>?
  validationErrorList; // قد يكون List<dynamic> إذا كانت الأنواع مختلفة
  final bool? isSuccess;
  final int? totalRecords;

  OrderResponse({
    this.data,
    this.successMessage,
    this.statusCode,
    this.errorList,
    this.validationErrorList,
    this.isSuccess,
    this.totalRecords,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    dynamic parsedData;
    if (json['data'] is Map<String, dynamic> &&
        json['data'].containsKey('orderNumber')) {
      // هذا هو سيناريو MakeOrder
      parsedData = OrderNumberModel.fromJson(
        json['data'] as Map<String, dynamic>,
      );
    } else if (json['data'] is List) {
      // هذا هو سيناريو GetAllOrders
      parsedData = (json['data'] as List<dynamic>)
          .map((e) => DatumOrder.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      // في حالة وجود 'data' بنوع غير متوقع أو null
      parsedData = null;
    }

    return OrderResponse(
      data: parsedData,
      successMessage: json['successMessage'] as String?,
      statusCode: json['statusCode'] as int?,
      errorList: (json['errorList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      validationErrorList: (json['validationErrorList'] as List<dynamic>?)
          ?.map((e) => e as String) // افترض أنها List<String>
          .toList(),
      isSuccess: json['isSuccess'] as bool?,
      totalRecords: json['totalRecords'] as int?,
    );
  }

  // يمكننا جعل toJson أبسط إذا كنا لا نرسل هذا الموديل مرة أخرى إلى API
  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}
