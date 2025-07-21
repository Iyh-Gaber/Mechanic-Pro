/*import 'data.dart';

class OrderResponse {
  Data? data;
  String? successMessage;
  int? statusCode;
  List<dynamic>? errorList;
  dynamic validationErrorList;
  bool? isSuccess;
  dynamic totalRecords;

  OrderResponse({
    this.data,
    this.successMessage,
    this.statusCode,
    this.errorList,
    this.validationErrorList,
    this.isSuccess,
    this.totalRecords,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        successMessage: json['successMessage'] as String?,
        statusCode: json['statusCode'] as int?,
        errorList: json['errorList'] as List<dynamic>?,
        validationErrorList: json['validationErrorList'] as dynamic,
        isSuccess: json['isSuccess'] as bool?,
        totalRecords: json['totalRecords'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'successMessage': successMessage,
        'statusCode': statusCode,
        'errorList': errorList,
        'validationErrorList': validationErrorList,
        'isSuccess': isSuccess,
        'totalRecords': totalRecords,
      };
}
*/

// lib/feature/orders/data/models/response/order_response/order_response.dart
import 'package:mechpro/feature/orders/data/models/response/order_response/data.dart'; // تأكد من المسار

class OrderResponse {
  // 🌟🌟🌟 هذا هو التعديل الأساسي والمهم جداً: تغيير نوع 'data' 🌟🌟🌟
  // لأن الـ API يرسل 'data' كـ قائمة (حتى لو كانت فارغة مثل []).
  List<DataOrder>? data; // قبل التحويل التلقائي قد يكون Data? data;

  String? successMessage;
  int? statusCode;
  List<dynamic>? errorList;
  dynamic validationErrorList;
  bool? isSuccess;
  dynamic totalRecords;

  OrderResponse({
    this.data,
    this.successMessage,
    this.statusCode,
    this.errorList,
    this.validationErrorList,
    this.isSuccess,
    this.totalRecords,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        // 🌟🌟🌟 هنا يجب أن يتم تحليل 'data' كقائمة من JSON objects 🌟🌟🌟
        // ثم تحويل كل منها إلى كائن Data.
        data: (json['data'] as List<dynamic>?) // نقوم بتحويل 'data' إلى List
            ?.map((e) => DataOrder.fromJson(e as Map<String,
                dynamic>)) // نمر على كل عنصر في القائمة ونحولها لـ Data
            .toList(), // نجمعها في قائمة من Data objects
        successMessage: json['successMessage'] as String?,
        statusCode: json['statusCode'] as int?,
        errorList: json['errorList'] as List<dynamic>?,
        validationErrorList: json['validationErrorList'] as dynamic,
        isSuccess: json['isSuccess'] as bool?,
        totalRecords: json['totalRecords'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'data': data
            ?.map((e) => e.toJson())
            .toList(), // عند إرسالها كـ JSON، نحول قائمة Data إلى قائمة JSON
        'successMessage': successMessage,
        'statusCode': statusCode,
        'errorList': errorList,
        'validationErrorList': validationErrorList,
        'isSuccess': isSuccess,
        'totalRecords': totalRecords,
      };
}

// كلاس Data يبقى كما هو، لأنه يمثل شكل العنصر الواحد داخل القائمة.
// lib/feature/orders/data/models/response/order_response/data.dart
class DataOrder {
  int? orderNumber;

  DataOrder({this.orderNumber});

  factory DataOrder.fromJson(Map<String, dynamic> json) => DataOrder(
        orderNumber: json['orderNumber'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'orderNumber': orderNumber,
      };
}
