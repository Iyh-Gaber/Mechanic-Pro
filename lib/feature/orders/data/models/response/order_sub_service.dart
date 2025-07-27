// lib/feature/orders/data/models/response/order_response/order_sub_service.dart

import 'package:json_annotation/json_annotation.dart';
part 'order_sub_service.g.dart'; // هذا السطر في مكانه الصحيح تمامًا

@JsonSerializable()
class OrderSubService {
  final String? orderSubServiceName;

  OrderSubService({this.orderSubServiceName});

  factory OrderSubService.fromJson(Map<String, dynamic> json) =>
      _$OrderSubServiceFromJson(json);
  Map<String, dynamic> toJson() => _$OrderSubServiceToJson(this);
}
