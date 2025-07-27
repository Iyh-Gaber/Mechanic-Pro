// lib/feature/orders/data/models/response/order_response/order_service.dart

import 'package:json_annotation/json_annotation.dart';

import '../request/order_request/order_request_sub_service.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order_service.g.dart'; // أضف/تأكد من هذا السطر
// ... بقية الكلاس

@JsonSerializable()
class OrderService {
  final String? orderServiceName;
  final List<OrderRequestSubService>? orderSubServices;

  OrderService({this.orderServiceName, this.orderSubServices});

  factory OrderService.fromJson(Map<String, dynamic> json) =>
      _$OrderServiceFromJson(json);
  Map<String, dynamic> toJson() => _$OrderServiceToJson(this);
}
