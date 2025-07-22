import 'order_sub_service.dart';

class OrderService {
  String? orderServiceName;
  List<OrderSubService>? orderSubServices;

  OrderService({this.orderServiceName, this.orderSubServices});

  factory OrderService.fromJson(Map<String, dynamic> json) => OrderService(
        orderServiceName: json['orderServiceName'] as String?,
        orderSubServices: (json['orderSubServices'] as List<dynamic>?)
            ?.map((e) => OrderSubService.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'orderServiceName': orderServiceName,
        'orderSubServices': orderSubServices?.map((e) => e.toJson()).toList(),
      };
}
