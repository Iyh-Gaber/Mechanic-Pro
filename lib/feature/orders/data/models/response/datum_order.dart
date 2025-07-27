// lib/feature/orders/data/models/response/order_response/datum_order.dart

import 'package:json_annotation/json_annotation.dart';

import '../request/order_request/order_request_service.dart';
import 'package:json_annotation/json_annotation.dart';
part 'datum_order.g.dart'; // أضف/تأكد من هذا السطر
// ... بقية الكلاس

@JsonSerializable()
class DatumOrder {
  final int? orderId;
  final int? userId; // موجود هنا كبيانات راجعة، ليس مرسلة
  final String? userName; // موجود هنا كبيانات راجعة، ليس مرسلة
  final List<OrderRequestService>? orderServices;
  final String? maintenanceCenter;
  final bool? isHomeService;
  final DateTime? orderDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? isPaid;
  final double? orderAmount; // استخدم double إذا كانت القيمة عشرية
  final bool? isCanceled;

  DatumOrder({
    this.orderId,
    this.userId,
    this.userName,
    this.orderServices,
    this.maintenanceCenter,
    this.isHomeService,
    this.orderDate,
    this.startDate,
    this.endDate,
    this.isPaid,
    this.orderAmount,
    this.isCanceled,
  });

  factory DatumOrder.fromJson(Map<String, dynamic> json) =>
      _$DatumOrderFromJson(json);
  Map<String, dynamic> toJson() => _$DatumOrderToJson(this);
}
