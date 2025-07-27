import 'package:json_annotation/json_annotation.dart';
import 'package:mechpro/feature/orders/data/models/response/order_sub_service.dart'; // هذا استيراد خاطئ!
// يجب أن تستورد order_request_sub_service.dart من مجلد الـ request هنا
import 'order_request_sub_service.dart'; // <--- **التغيير هنا: استيراد ملف الـ request sub-service الصحيح**

part 'order_request_service.g.dart'; // <--- تأكد أن اسم الـ part file يتطابق مع اسم الكلاس الجديد

@JsonSerializable()
class OrderRequestService { // اسم الكلاس صحيح الآن
  String? orderServiceName;
  List<OrderRequestSubService>? orderSubServices; // <--- **التغيير هنا: استخدام OrderRequestSubService**

  OrderRequestService({this.orderServiceName, this.orderSubServices});

  // <--- التغيير هنا: استخدم اسم الكلاس الجديد في الدوال المولدة
  factory OrderRequestService.fromJson(Map<String, dynamic> json) => _$OrderRequestServiceFromJson(json);

  // <--- التغيير هنا: استخدم اسم الكلاس الجديد في الدوال المولدة
  Map<String, dynamic> toJson() => _$OrderRequestServiceToJson(this);
}